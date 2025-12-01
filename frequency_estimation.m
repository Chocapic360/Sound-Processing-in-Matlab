function [char_est, f1_est, f2_est] = frequency_estimation(input_char)

    % Settings
    fs = 8000;
    toneDuration = 0.1;
    lobe_width = 5;

    numberFrequencies = containers.Map(...
        {'1','2','3','4','5','6','7','8','9','0','*','#'}, ...
        {[697,1209], [697,1336], [697,1477], ...
        [770,1209], [770,1336], [770,1477], ...
        [852,1209], [852,1336], [852,1477], ...
        [941,1336], [941,1209], [941,1477]});

    row_freqs = [697, 770, 852, 941];
    col_freqs = [1209, 1336, 1477];

    % #1 Recieve input char
    freqs = numberFrequencies(input_char);

    % #2 Generate tone
    timearray = 0:1/fs:toneDuration;
    waveform = sin(2*pi*freqs(1)*timearray) + sin(2*pi*freqs(2)*timearray);

    % #3 Zero padding (2x padding)
    padded_waveform = [zeros(1,(fs*toneDuration)/2) waveform zeros(1,(fs*toneDuration)/2)];

    % #4 FFT
    X = fft(padded_waveform);
    X_shift = fftshift(X);
    magnitude = abs(X_shift);

    % #5 Set X-Axis
    Ntotal = length(X);
    if mod(Ntotal, 2) == 0
        % Even length
        f = (-Ntotal/2 : Ntotal/2-1) * (fs / Ntotal);
    else
        % Odd length
        f = (-(Ntotal-1)/2 : (Ntotal-1)/2) * (fs / Ntotal);
    end

    % Work only with positive frequencies for detection
    pos_idx  = find(f >= 0);
    f_pos    = f(pos_idx);
    mag_pos  = magnitude(pos_idx);

    % #6 First Peak
    [~, idx1] = max(mag_pos);
    f1_raw = f_pos(idx1);

    % #7 Remove Lobe 1
    mag_pos2 = mag_pos;
    lobe_width = 5;
    idx_low  = max(1, idx1 - lobe_width);
    idx_high = min(length(mag_pos2), idx1 + lobe_width);
    mag_pos2(idx_low:idx_high) = 0;

    % #8 Second Peak
    [~, idx2] = max(mag_pos2);
    f2_raw = f_pos(idx2);

    % #9 Make sure it's in the realm of possible frequencies
    f_low = min(f1_raw, f2_raw);
    f_high = max(f1_raw, f2_raw);

    [~, row_est_idx] = min(abs(row_freqs - f_low));
    f_row_est = row_freqs(row_est_idx);

    [~, col_est_idx] = min(abs(col_freqs - f_high));
    f_col_est = col_freqs(col_est_idx);

    % #10 Find Character
    est = [f_row_est, f_col_est]
    keysList = numberFrequencies.keys;
    valuesList = numberFrequencies.values;
    char_out = '';

    for i = 1:length(keysList)
        freqPair = valuesList{i};
        if isequal(sort(freqPair), sort(est))
            char_out = keysList{i};
            break;
        end
    end

    % #11 Output
    char_est = char_out;
    f1_est = f_row_est;
    f2_est = f_col_est;
end

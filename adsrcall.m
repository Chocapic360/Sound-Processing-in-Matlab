% Description - This is the function that takes the wave and outputs both
% the adsr-enveloped wave and adsr envelope for graphing.
function [output_tone, a] = adsrcall(tone, fs, final_value, duration)
    % Create ADSR envelope
    duration_samples = round(fs * duration);
    phase_ends = cumsum(duration_samples);
    
    % Build envelope
    a = zeros(1, phase_ends(end));
    a(1:phase_ends(1)) = linspace(0, final_value(1), duration_samples(1));
    
    for phase = 2:4
        start_idx = phase_ends(phase-1) + 1;
        end_idx = phase_ends(phase);
        a(start_idx:end_idx) = linspace(a(start_idx-1), final_value(phase), duration_samples(phase));
    end
    
    a = interp1(1:length(a), a, linspace(1, length(a), length(tone)), 'linear');
    % Apply envelope
    output_tone = tone .* a;
end
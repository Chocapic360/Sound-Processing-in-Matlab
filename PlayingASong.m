clear, clc;
close all;

notes = dictionary('C',261.6,'C#',277.2,'D',293.7,'D#',311.1,'E',329.6,...
    'F',349.2,'F#',370.0,'G',392.0,'G#',415.3,'A',440.0,'A#',466.2,'B',493.9);
sample_rate = 44100;

attack_time = 0.05; % seconds
decay_time = 0.05;  % seconds
sustain_level = 0.7; % amplitude (0 to 1)
release_time = 0.1; % seconds

% Tempo 2/4 at 112 BPM since a quarter is 1 beat and we have it as 0.25 duration we make bpm = 112/4 = 28
bpm = 28;
beats_per_second = bpm / 60;

% TWINKLE TWINKLE LITTLE STAR - Treble Clef
notes_treble = {"C","C","G","G","A","A", ...
                "G","G","F","F","E","E", ... % First Line
                "D","D","E","C","G","G", ...
                "F","F","E","E","D","D", ... % Second Line
                "G","G","F","F","E","F", ...
                "E","D","E","F","E","D", ...
                "C","C","G","G", ... % Third Line
                "A","A","G","G","F","F", ...
                "E","E","D","E","D","E", ...
                "D","E","C" % Fourth Line
                };

duration_note_treble = {
    0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ...
    0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ... % First Line
    0.25, 0.1875, 0.0625, 0.5, 0.25, 0.25, ...
    0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ... % Second Line
    0.25, 0.25, 0.25, 0.25, 0.0625, 0.0625, ...
    0.0625, 0.0625, 0.1875, 0.0625, ...
    0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ... % Third Line
    0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ...
    0.25, 0.25, 0.0625, 0.0625, 0.0625, 0.0625, ...
    0.1875, 0.0625, 0.5 % Fourth Line
    };

% Generate treble clef waveform
longwave_treble = 0;
for i = 1:length(notes_treble)
    note = notes_treble{i};
    duration = duration_note_treble{i} / beats_per_second; % in seconds
    t = 0:1/sample_rate:duration;
    wave = frequency_to_waveform(notes(note), t);
    wave = apply_adsr_envelope(wave, sample_rate, attack_time, decay_time, sustain_level, release_time);
    wave(1) = []; % Remove the first sample to avoid overlap
    longwave_treble = [longwave_treble, wave];
end

%player = audioplayer(longwave_treble, sample_rate);
%play(player);
%playblocking(player);

% Tempo 4/4 at 200 BPM since a quarter is 1 beat and we have it as 0.25 duration we make bpm = 200/4 = 50
bpm = 50;
beats_per_second = bpm / 60;

% Fur Elise - Treble Clef
notes_fur_elise = { "E5","D#5","E5","D#5","E5","B4","D5","C5", ...
                    "A4","C4","E4","A4","B4", ... % First Line
                    "E4","G#4","B4","C5", ...
                    "E4","E5","D#5","E5","D#5", ... % Second Line
                    "E5","B4","D5","C5","A4", ...
                    "C4","E4","A4","B4", ...
                    "E4","C5","B4","A4", % Third Line
                    };

duration_note_fur_elise = {
    0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ...
    0.5, 0.25, 0.25, 0.25, 0.5, ... % First Line
    0.25, 0.25, 0.25, 0.5, ...
    0.25, 0.25, 0.25, 0.25, 0.25, ... % Second Line
    0.25, 0.25, 0.25, 0.25, 0.5, ...
    0.25, 0.25, 0.25, 0.5, 0.25, ...
    0.25, 0.25, 1.0 % Third Line
    };

% Generate Fur Elise waveform
longwave_fur_elise = 0;
for i = 1:length(notes_fur_elise)
    note = notes_fur_elise{i};
    duration = duration_note_fur_elise{i} / beats_per_second; % in seconds
    t = 0:1/sample_rate:duration;
    
    if endsWith(note, "4")
        note_name = extractBefore(note, strlength(note));
        octave = 4;
    elseif endsWith(note, "5")
        note_name = extractBefore(note, strlength(note));
        octave = 5;
    end
    
    frequency = notes(note_name) * 2^(octave - 4);
    wave = frequency_to_waveform(frequency, t);
    wave = apply_adsr_envelope(wave, sample_rate, attack_time, decay_time, sustain_level, release_time);
    wave(1) = []; % Remove the first sample to avoid overlap
    longwave_fur_elise = [longwave_fur_elise, wave];
end

player = audioplayer(longwave_fur_elise, sample_rate);
play(player);
playblocking(player);

function waveform = frequency_to_waveform(frequency, timearray)
    waveform = sin(2 * pi * frequency * timearray);
end

function enveloped_wave = apply_adsr_envelope(wave, sample_rate, attack_time, decay_time, sustain_level, release_time)
    % Robust ADSR: handle very short notes and avoid undefined vars / div-by-zero
    N = length(wave);
    attack_samples = round(attack_time * sample_rate);
    decay_samples = round(decay_time * sample_rate);
    release_samples = round(release_time * sample_rate);

    % If the sum of ADSR segments exceeds the available samples,
    total_needed = attack_samples + decay_samples + release_samples;
    if total_needed > N
        % reduce release first
        excess = total_needed - N;
        reduce = min(excess, release_samples);
        release_samples = release_samples - reduce;
        excess = excess - reduce;

        if excess > 0
            reduce = min(excess, decay_samples);
            decay_samples = decay_samples - reduce;
            excess = excess - reduce;
        end

        if excess > 0
            reduce = min(excess, attack_samples);
            attack_samples = attack_samples - reduce;
            excess = excess - reduce;
        end
    end

    sustain_samples = N - (attack_samples + decay_samples + release_samples);
    if sustain_samples < 0
        sustain_samples = 0;
    end

    envelope = zeros(1, N);

    idx = 1;
    % Attack
    if attack_samples > 0
        envelope(idx:idx+attack_samples-1) = linspace(0, 1, attack_samples);
        idx = idx + attack_samples;
    end

    % Decay
    if decay_samples > 0
        envelope(idx:idx+decay_samples-1) = linspace(1, sustain_level, decay_samples);
        idx = idx + decay_samples;
    end

    % Sustain
    if sustain_samples > 0
        envelope(idx:idx+sustain_samples-1) = sustain_level;
        idx = idx + sustain_samples;
    end

    % Release
    if release_samples > 0
        envelope(idx:idx+release_samples-1) = linspace(sustain_level, 0, release_samples);
        idx = idx + release_samples;
    end

    % In case of rounding differences, ensure envelope length matches
    if length(envelope) > N
        envelope = envelope(1:N);
    elseif length(envelope) < N
        envelope = [envelope, zeros(1, N - length(envelope))];
    end

    enveloped_wave = wave .* envelope;
end
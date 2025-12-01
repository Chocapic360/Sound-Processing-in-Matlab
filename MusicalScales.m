clc, clear;
clear sound;

% Base frequencies for octave 0 
baseFreqs = [16.35, 17.32, 18.35, 19.45, 20.60, 21.83, 23.12, 24.50, 25.96, 27.50, 29.14, 30.87];
octaves = 0:8; 

noteNames = {'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'};

freqTable = zeros(length(octaves), length(baseFreqs)); % Frequency table (table 2 in the reference)
for i = 1:length(octaves)
    for j = 1:length(baseFreqs)
        freqTable(i, j) = baseFreqs(j) * (2^octaves(i));
    end
end

% Create table using the array we made earlier
T = array2table(freqTable, 'VariableNames', noteNames);
T.Properties.RowNames = compose('Octave_%d', octaves);
disp(T);

fs = 44100;      % Sampling frequency
duration = 0.4;  % Duration of each note in seconds
pauseTime = 0.1; % Pause between notes

fprintf('Playing rows\n');
% Play each row
for row = 1:size(freqTable, 1)
    fprintf('Playing octave %d: ', octaves(row));
    for col = 1:size(freqTable, 2)
        frequency = freqTable(row, col);
        fprintf('%s ', noteNames{col});
        
        % Generate and play the tone using our function
        tone = generateTone(frequency, duration, fs);
        sound(tone, fs);
        pause(duration + pauseTime);
    end
    fprintf('\n');
    pause(0.1);
end

fprintf('\nPlaying columns\n');
% Play each column
for col = 1:size(freqTable, 2)
    fprintf('Playing %s: ', noteNames{col});
    for row = 1:size(freqTable, 1)
        frequency = freqTable(row, col);
        fprintf('%d ', octaves(row));
        
        % Generate and play the tone
        tone = generateTone(frequency, duration, fs);
        sound(tone, fs);
        pause(duration + pauseTime);
    end
    fprintf('\n');
    pause(0.1);
end

% Tone generation function
function tone = generateTone(frequency, duration, fs)
    t = 0:1/fs:duration;
    tone = sin(2 * pi * frequency * t);
    
    % ADSR envelope
    attackSamples = round(0.05 * fs); % 50ms attack
    releaseSamples = round(0.1 * fs); % 100ms release
    
    envelope = ones(size(t));
    
    % Attack portion
    if attackSamples > 0 && attackSamples <= length(t)
        envelope(1:attackSamples) = linspace(0, 1, attackSamples);
    end
    
    % Release portion
    if releaseSamples > 0 && (length(t) - releaseSamples) > 0
        releaseStart = length(t) - releaseSamples + 1;
        envelope(releaseStart:end) = linspace(1, 0, releaseSamples);
    end
    
    tone = tone .* envelope;
    
    % Normalize amplitude
    if max(abs(tone)) > 0
        tone = tone / max(abs(tone));
    end
end
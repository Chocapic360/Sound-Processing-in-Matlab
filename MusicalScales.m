% Description - Part C script that creates the table of notes. Just press
% play to start the process and listen
clc, clear;
clear sound;

% Base frequency
baseFreq = 16.35;
octaves = 0:8; % Number of octaves
freqTable = [];
freqTable(1) = baseFreq;
noteNames = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];

for i = 2:12 % Generate base octave 0 from base freq
    freqTable(i) = freqTable(i-1) * 2^(1/12); 
end
for j = 2:9 % Generate next octaves from first octave
    freqTable(j,:) = freqTable(j-1,:) * 2; 
end

% Create table using the array we made earlier
T = array2table(freqTable, 'VariableNames', noteNames);
T.Properties.RowNames = compose('Octave %d', octaves);
disp(T); % Display table

fs = 44100;      % Sampling frequency
duration = 0.2;  % Duration of each note in seconds
pauseTime = 0.1; % Pause between notes

% Generate rows of tones
fprintf('\nPlaying rows and then columns\n');
full_wave = [];
for row = 1:size(freqTable, 1)
    for col = 1:size(freqTable, 2)
        frequency = freqTable(row, col);        
        tone = generateTone(frequency, duration, fs);
        full_wave = [full_wave, tone, zeros(1, round(duration * fs))];
    end
end
% Generate columns of tones
for col = 1:size(freqTable, 2)
    for row = 1:size(freqTable, 1)
        frequency = freqTable(row, col);
        tone = generateTone(frequency, duration, fs);
        full_wave = [full_wave, tone, zeros(1, round(duration * fs))];
    end
end

sound(full_wave, fs); % Play the full sound

% Tone generation function
function tone = generateTone(frequency, duration, fs)
    t = 0:1/fs:duration;
    tone = sin(2 * pi * frequency * t);
    
    % Normalize amplitude
    if max(abs(tone)) > 0
        tone = tone / max(abs(tone));
    end
end
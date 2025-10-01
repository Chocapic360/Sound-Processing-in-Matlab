clear, clc

% Generate Frequency Table
Basefrequencies = [16.35, 17.32, 18.35, 19.45, 20.6, 21.83, 23.12, 24.5, ...
25.96, 27.5, 29.14, 30.87];

% Add 8 octaves to each base frequency
FrequencyTable = zeros(8, length(Basefrequencies));
for j = 1:length(Basefrequencies)
    for i = 1:8
        FrequencyTable(i,j) = Basefrequencies(j) * 2^(i-1);
    end
end

% Transform frequencies into waveforms

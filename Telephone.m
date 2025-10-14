clear, clc

% For this file we will use:
sample_rate = 44100;
duration = 0.5;

t = 0:1/44100:0.5;

array = phone_number_processor('3');

numCyclesToShow = 5;
numSamplesToShow = floor(numCyclesToShow * sample_rate / 1000);
plot(t(1:numSamplesToShow), array(1:numSamplesToShow));

function waveform = frequency_to_waveform(frequency, timearray)
    waveform = sin(2 * pi * frequency * timearray);
end

function [lowFreq, highFreq] = get_frequencies(key)
    frequencymap = containers.Map( ...
        {'1','2','3','4','5','6','7','8','9','*','0','#'}, ...
        {[697 1209], [697 1336], [697 1477], ...
         [770 1209], [770 1336], [770 1477], ...
         [852 1209], [852 1336], [852 1477], ...
         [941 1209], [941 1336], [941 1477]});

    if ~isKey(frequencymap, key)
        error('Invalid key! Use digits 0–9, * or #.');
    end

    freqs = frequencymap(key);
    lowFreq = freqs(1);
    highFreq = freqs(2);
end

function soundarray = phone_number_processor(phonenumber)
    soundarray = [];
    for i = 1:length(phonenumber)
        key = phonenumber(i);
        [lowFreq, highFreq] = get_frequencies(key);
        t = 0:1/44100:0.5;
        waveform1 = frequency_to_waveform(lowFreq, t);
        waveform2 = frequency_to_waveform(highFreq, t);
        combinedWaveform = waveform1 + waveform2;
        soundarray = [soundarray; combinedWaveform];
    end
end

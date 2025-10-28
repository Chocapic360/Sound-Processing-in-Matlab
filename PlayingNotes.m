clear, clc

sample_rate = 44100;
duration = 0.5;
t = 0:1/sample_rate:duration;

notes = dictionary('C',261.6,'C#',277.2,'D',293.7,'D#',311.1,'E',329.6,...
    'F',349.2,'F#',370.0,'G',392.0,'G#',415.3,'A',440.0,'A#',466.2,'B',493.9);

sequence1 = [notes('D'), notes('E'), notes('C'), notes('C')/2, notes('G')];
t_signal1 = 0:1/sample_rate:duration*length(sequence1);

longwave = 0;
for i = 1:length(sequence1)
    wave = frequency_to_waveform(sequence1(i), t);
    wave(1) = [];
    longwave = [longwave, wave];
end

hold on;
subplot(2,1,1);
plot(t_signal1, longwave);
title("signal");

%Frequency analysis
N = length(longwave);          % samples in your signal
Y = fft(longwave);             % FFT
P2 = abs(Y / N);               % two-sided spectrum (normalize)
P1 = P2(1:N/2+1);              % one-sided spectrum
P1(2:end-1) = 2*P1(2:end-1);   % energy from negative freqs

f = sample_rate * (0:(N/2)) / N;   % <-- x-axis in Hz

subplot(2,1,2);
plot(f, P1);
title("Frequency Spectrum");
xlabel("Frequency (Hz)");
ylabel("|Amplitude|");
xlim([0 600]);

sound(longwave, sample_rate);

function waveform = frequency_to_waveform(frequency, timearray)
    waveform = sin(2 * pi * frequency * timearray);
end

clear, clc
close all;

sample_rate = 44100;
duration = 0.5;
t = 0:1/sample_rate:duration;

notes = dictionary('C',261.6,'C#',277.2,'D',293.7,'D#',311.1,'E',329.6,...
    'F',349.2,'F#',370.0,'G',392.0,'G#',415.3,'A',440.0,'A#',466.2,'B',493.9);

% First sequence
sequence1 = [notes('D'), notes('E'), notes('C'), notes('C')/2, notes('G')];
t_signal1 = 0:1/sample_rate:duration*length(sequence1)*2;

longwave = 0;
for i = 1:length(sequence1)
    wave = frequency_to_waveform(sequence1(i), t);
    wave(1) = [];
    longwave = [longwave, wave];
    pause = zeros(1, length(t));
    pause(1) = [];
    longwave = [longwave, pause];
end

figure;
hold on;
subplot(2,1,1);
plot(t_signal1, longwave);
title("Signal 1");

%Frequency analysis
N = length(longwave);
Y = fft(longwave);
P2 = abs(Y / N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = sample_rate * (0:(N/2)) / N;

subplot(2,1,2);
plot(f, P1);
title("Frequency Spectrum");
xlabel("Frequency (Hz)");
ylabel("|Amplitude|");
xlim([0 600]);
hold off;

player = audioplayer(longwave, sample_rate);
play(player);
playblocking(player);


% Second sequence
% E E C# C E G F# C G E A A# G E G A F G E C
sequence2 = [notes('E'), notes('E'), notes('C#'), notes('C'), notes('E'), ...
    notes('G'), notes('F#'), notes('C'), notes('G'), notes('E'), ...
    notes('A'), notes('A#'), notes('G'), notes('E'), notes('G'), ...
    notes('A'), notes('F'), notes('G'), notes('E'), notes('C')];

t_signal2 = 0:1/sample_rate:duration*length(sequence2)*2;

longwave2 = 0;
for i = 1:length(sequence2)
    wave = frequency_to_waveform(sequence2(i), t);
    wave(1) = [];
    longwave2 = [longwave2, wave];
    pause = zeros(1, length(t));
    pause(1) = [];
    longwave2 = [longwave2, pause];
end

figure;
hold on;
subplot(2,1,1);
plot(t_signal2, longwave2);
title("Signal 2");

%Frequency analysis
N = length(longwave2);
Y = fft(longwave2);
P2 = abs(Y / N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = sample_rate * (0:(N/2)) / N;

subplot(2,1,2);
plot(f, P1);
title("Frequency Spectrum");
xlabel("Frequency (Hz)");
ylabel("|Amplitude|");
xlim([0 600]);
hold off;

player = audioplayer(longwave2, sample_rate);
play(player);
playblocking(player);

% Remove every other sample from signal 2
longwave2_decimated = longwave2(1:2:end);

figure;
hold on;
subplot(2,1,1);
plot(t_signal2(1:2:end), longwave2_decimated);
title("Decimated Signal 2");

%Frequency analysis
N = length(longwave2_decimated);
Y = fft(longwave2_decimated);
P2 = abs(Y / N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = (sample_rate/2) * (0:(N/2)) / N;
subplot(2,1,2);
plot(f, P1);
title("Frequency Spectrum of Decimated Signal");
xlabel("Frequency (Hz)");
ylabel("|Amplitude|");
xlim([0 600]);
hold off;

player = audioplayer(longwave2_decimated, sample_rate/2);
play(player);
playblocking(player);

function waveform = frequency_to_waveform(frequency, timearray)
    waveform = sin(2 * pi * frequency * timearray);
end

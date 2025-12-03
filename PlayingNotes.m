% Description - Function to play the notes in the given sequences and plot
clear, clc
close all;

sample_rate = 44000;
duration = 0.5;
t = 0:1/sample_rate:duration;

notes = dictionary('C',261.6*2,'C#',277.2*2,'D',293.7*2,'D#',311.1*2,'E',329.6*2,...
    'F',349.2*2,'F#',370.0*2,'G',392.0*2,'G#',415.3*2,'A',440.0*2,'A#',466.2*2,'B',493.9*2);

% First sequence
sequence1 = [notes('D')*2, notes('E')*2, notes('C')*2, notes('C'), notes('G')];
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

% ADSR of first sequence
duration = 1;
t = 0:1/sample_rate:duration;

sequence1 = [notes('D')*2, notes('E')*2, notes('C')*2, notes('C'), notes('G')];
t_signal1 = 0:1/sample_rate:duration*length(sequence1)*2;

longwave = 0;
adsr_final_values = [1.0, 0.8, 0.6, 0.2];      
adsr_times  = [.75, .25, .75, .25];
for i = 1:length(sequence1)
    wave = frequency_to_waveform(sequence1(i), t);
    [wave, envelope_graph] = adsrcall(wave, sample_rate, adsr_final_values, adsr_times);
    wave(1) = [];
    longwave = [longwave, wave]; % No pause on this one to get the desired effect
end

figure;
hold on;
subplot(3,1,1);
plot(longwave);
title("ADSR Enveloped Signal 1 (Close encounters)");

subplot(3,1,2);
plot(envelope_graph);
title("ADSR Envelope");

%Frequency analysis
N = length(longwave);
Y = fft(longwave);
P2 = abs(Y / N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = sample_rate * (0:(N/2)) / N;

subplot(3,1,3);
plot(f, P1);
title("Frequency Spectrum");
xlabel("Frequency (Hz)");
ylabel("|Amplitude|");
xlim([0 600]);
hold off;

player = audioplayer(longwave, sample_rate);
play(player);
playblocking(player);

duration = 0.25;
t = 0:1/sample_rate:duration;

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
plot(longwave2);
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
plot(longwave2_decimated);
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

player = audioplayer(longwave2_decimated, sample_rate);
play(player);
playblocking(player);

% Time reverse of signal 2
longwave2_reversed = fliplr(longwave2);
figure;
hold on;
subplot(2,1,1);
plot(t_signal2, longwave2_reversed);
title("Time Reversed Signal 2");
%Frequency analysis
N = length(longwave2_reversed);
Y = fft(longwave2_reversed);
P2 = abs(Y / N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = sample_rate * (0:(N/2)) / N;

subplot(2,1,2);
plot(f, P1);
title("Frequency Spectrum of Time Reversed Signal");
xlabel("Frequency (Hz)");
ylabel("|Amplitude|");
xlim([0 600]);
hold off;

player = audioplayer(longwave2_reversed, sample_rate);
play(player);
playblocking(player);

longwave2 = 0;
for i = 1:length(sequence2)
    freq = sequence2(i);
    wave = sin(1* 2 * pi *freq * t) .* exp(-0.0004 * 2 * pi * freq * t) / 1;
    wave = wave+sin(2* 2 * pi *freq * t) .* exp(-0.0004 * 2 * pi * freq * t) / 2;
    wave= wave+(wave.*wave.*wave);
    wave=wave/6;
    wave(1) = [];
    longwave2 = [longwave2, wave];
    pause = zeros(1, length(t));
    pause(1) = [];
    longwave2 = [longwave2, pause];
end

function waveform = frequency_to_waveform(frequency, timearray)
    waveform = sin(2 * pi * frequency * timearray);
end

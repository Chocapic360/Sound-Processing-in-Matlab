clear, clc
close all;

sample_rate = 44100;
duration = 0.25;
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

% ADSR Envelope Application for signal 2
% Define ADSR parameters (seconds and level)
attack_time = 0.003;
decay_time = 0.15;
sustain_level = 0.12;
release_time = 1.2;

% Number of samples that correspond to one note (wave + pause)
samples_per_note = 2 * (length(t) - 1); % note: t had one sample removed when building waves

% Convert ADSR times to samples
attack_samples = round(attack_time * sample_rate);
decay_samples = round(decay_time * sample_rate);
release_samples = round(release_time * sample_rate);

% Compute sustain samples so total equals samples_per_note
sustain_samples = samples_per_note - (attack_samples + decay_samples + release_samples);
if sustain_samples < 0
    sustain_samples = 0;
    excess = -(samples_per_note - (attack_samples + decay_samples + release_samples));

    if excess > 0
        reduce = min(excess, release_samples);
        release_samples = release_samples - reduce;
        excess = excess - reduce;
    end
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

% Build single-note envelope
env_attack = linspace(0, 1, max(1, attack_samples));
env_decay = linspace(1, sustain_level, max(1, decay_samples));
env_sustain = sustain_level * ones(1, max(0, sustain_samples));
env_release = linspace(sustain_level, 0, max(1, release_samples));

env_one = [env_attack, env_decay, env_sustain, env_release];

% Ensure env_one length equals samples_per_note
if length(env_one) < samples_per_note
    env_one = [env_one, zeros(1, samples_per_note - length(env_one))];
elseif length(env_one) > samples_per_note
    env_one = env_one(1:samples_per_note);
end

n_notes = length(sequence2);
full_env = [0, repmat(env_one, 1, n_notes)];

% Ensure full_env length matches longwave2 length
if length(full_env) < length(longwave2)
    full_env = [full_env, zeros(1, length(longwave2) - length(full_env))];
elseif length(full_env) > length(longwave2)
    full_env = full_env(1:length(longwave2));
end

% Apply envelope
enveloped_wave = longwave2 .* full_env;

% Plot and play the enveloped signal
figure;
hold on;
subplot(2,1,1);
plot(t_signal2, enveloped_wave);
title("Enveloped Signal 2 (ADSR)");

% Frequency analysis of enveloped signal
N = length(enveloped_wave);
Y = fft(enveloped_wave);
P2 = abs(Y / N);
P1 = P2(1:floor(N/2)+1);
P1(2:end-1) = 2*P1(2:end-1);

f = sample_rate * (0:(floor(N/2))) / N;
subplot(2,1,2);
plot(f, P1);
title("Frequency Spectrum (ADSR Enveloped)");
xlabel("Frequency (Hz)");
ylabel("|Amplitude|");
xlim([0 600]);
hold off;

player = audioplayer(enveloped_wave, sample_rate);
play(player);
playblocking(player);


function waveform = frequency_to_waveform(frequency, timearray)
    waveform = sin(2 * pi * frequency * timearray);
end

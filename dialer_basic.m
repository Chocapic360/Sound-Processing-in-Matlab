clc, clear
clear sound
% Dictionary for tones
    
% Phone number
phoneNumber = '1234567890';

% Settings
fs = 8000;
toneDuration = 0.1;
interDigitGap = 0.05;

% Use our function to generate time-separated sequence of tones
audioArray = generateAudioArray(phoneNumber,fs,toneDuration,interDigitGap);


function combinedAudio = generateAudioArray(phoneNumber, fs, toneDuration, interDigitGap)
    numberFrequencies = containers.Map(...
        {'1','2','3','4','5','6','7','8','9','0','*','#'}, ...
        {[697,1209], [697,1336], [697,1477], ...
         [770,1209], [770,1336], [770,1477], ...
         [852,1209], [852,1336], [852,1477], ...
         [941,1336], [941,1209], [941,1477]});
    
    % Generate dial tones
    combinedAudio = [];
    for i = 1:length(phoneNumber)
        digit = phoneNumber(i);
        if isKey(numberFrequencies, digit)
            freqs = numberFrequencies(digit);
            
            % Generate tone
            t = 0:1/fs:toneDuration;
            tone = sin(2*pi*freqs(1)*t) + sin(2*pi*freqs(2)*t);
            tone = tone / max(abs(tone));
            
            % Add to sequence
            combinedAudio = [combinedAudio, tone, zeros(1, round(interDigitGap*fs))];
        end
    end
    
    % Add ringing tone
    ringOnTime = 0:1/fs:2;
    ringTone = sin(2*pi*350*ringOnTime) + sin(2*pi*440*ringOnTime);
    ringTone = ringTone / max(abs(ringTone));
    ringSilence = zeros(1, round(4*fs));
    
    for i = 1:3 % Repeat ringing tone 3 times
        combinedAudio = [combinedAudio, ringTone, ringSilence];
    end
    
    % Add busy tone at end
    busyOnTime = 0:1/fs:0.5;
    busyTone = sin(2*pi*480*busyOnTime) + sin(2*pi*620*busyOnTime);
    busyTone = busyTone / max(abs(busyTone));
    busySilence = zeros(1, round(0.5*fs));
    
    for i = 1:4 % Repeat busy tone 4 times
        combinedAudio = [combinedAudio, busyTone, busySilence];
    end
end

% Plot time domain
subplot(2,1,1);
time = (0:length(audioArray)-1) / fs;
plot(time, audioArray);
title(sprintf('Time Domain - Phone Call: %s', phoneNumber));
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Plot frequency domain (FFT)
subplot(2,1,2);
N = length(audioArray);
f = (0:N-1) * (fs/N);
fftSignal = abs(fft(audioArray));
plot(f(1:round(N/2)), fftSignal(1:round(N/2)));
title('Frequency Domain (FFT)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

% Play sound
sound(audioArray, fs);
clc, clear
clear sound

% Phone number to plot (any number, 10 digits works fine)
phoneNumber = '1234567890';

% Single digit to plot
digit = '1';

% Settings
fs = 8000;
toneDuration = 0.1;
interDigitGap = 0.05;

% Use our function to generate time-separated sequence of tones
audioArray = generateAudioArray(phoneNumber,fs,toneDuration,interDigitGap);

% Generate single tone
tone = generateAudioArray(digit,fs,toneDuration,interDigitGap);

% Function that generates the phone number array
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
end

% Add ringing tone
ringOnTime = 0:1/fs:2;
ringTone = sin(2*pi*350*ringOnTime) + sin(2*pi*440*ringOnTime);
ringTone = ringTone / max(abs(ringTone));
ringSilence = zeros(1, round(4*fs));
phoneCallArray = audioArray;
for i = 1:3 % Repeat ringing tone 3 times
    phoneCallArray = [phoneCallArray, ringTone, ringSilence];
end

% Add busy tone at end
busyOnTime = 0:1/fs:0.5;
busyTone = sin(2*pi*480*busyOnTime) + sin(2*pi*620*busyOnTime);
busyTone = busyTone / max(abs(busyTone));
busySilence = zeros(1, round(0.5*fs));

for i = 1:4 % Repeat busy tone 4 times
    phoneCallArray = [phoneCallArray, busyTone, busySilence];
end

% Plot phone call
subplot(3,1,1);
time0 = (0:length(phoneCallArray)-1) / fs;
plot(time0, phoneCallArray);
title(sprintf('Time Domain - Phone Call: %s', phoneNumber));
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Plot phone number
subplot(3,1,2);
time1 = (0:length(audioArray)-1) / fs;
plot(time1, audioArray);
title(sprintf('Time Domain - Phone Number: %s', phoneNumber));
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Plot digit
subplot(3,1,3);
time2 = (0:length(tone)-1) / fs;
plot(time2, tone);
title(sprintf('Time Domain - Single Digit: %s', digit));
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

% Play sound
disp('Now playing full phone call');
sound(phoneCallArray, fs);
pause((length(phoneCallArray)-1) / fs + 1);
disp('Now playing phone number');
sound(audioArray, fs);
pause((length(audioArray)-1) / fs + 1);
disp('Now playing single tone');
sound(tone, fs);


clear, clc

sample_rate = 44100;
duration = 0.5;
t = 0:1/sample_rate:duration;

notes = dictionary('C',261.6,'C#',277.2,'D',293.7,'D#',311.1,'E',329.6,...
    'F',349.2,'F#',370.0,'G',392.0,'G#',415.3,'A',440.0,'A#',466.2,'B',493.9);

sequence1 = [notes('D'), notes('E'), notes('C'), notes('C')/2, notes('G')];

for i = sequence1
    wave = frequency_to_waveform(i, t);
    sound(wave, sample_rate);
    pause(duration+0.1);
end

function waveform = frequency_to_waveform(frequency, timearray)
    waveform = sin(2 * pi * frequency * timearray);
end

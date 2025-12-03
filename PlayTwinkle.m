% Play twinkle twinkle little star function for GUI app
function PlayTwinkle(sample_rate, bpm,final_values,adsr_times)
    notes = dictionary('C',261.6,'C#',277.2,'D',293.7,'D#',311.1,'E',329.6,...
    'F',349.2,'F#',370.0,'G',392.0,'G#',415.3,'A',440.0,'A#',466.2,'B',493.9);

    beats_per_second = bpm / 60 / 4; % Divide by 4 for quarter note
    
    % TWINKLE TWINKLE LITTLE STAR - Treble Clef
    notes_treble = {"C","C","G","G","A","A", ...
                    "G","G","F","F","E","E", ... % First Line
                    "D","D","E","C","G","G", ...
                    "F","F","E","E","D","D", ... % Second Line
                    "G","G","F","F","E","F", ...
                    "E","D","E","F","E","D", ...
                    "C","C","G","G", ... % Third Line
                    "A","A","G","G","F","F", ...
                    "E","E","D","E","D","E", ...
                    "D","E","C" % Fourth Line
                    };
    
    duration_note_treble = {
        0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ...
        0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ... % First Line
        0.25, 0.1875, 0.0625, 0.5, 0.25, 0.25, ...
        0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ... % Second Line
        0.25, 0.25, 0.25, 0.25, 0.0625, 0.0625, ...
        0.0625, 0.0625, 0.1875, 0.0625, ...
        0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ... % Third Line
        0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ...
        0.25, 0.25, 0.0625, 0.0625, 0.0625, 0.0625, ...
        0.1875, 0.0625, 0.5 % Fourth Line
        };
    
    % Generate treble clef waveform
    longwave_treble = 0;
    for i = 1:length(notes_treble)
        note = notes_treble{i};
        duration = duration_note_treble{i} / beats_per_second; % in seconds
        t = 0:1/sample_rate:duration;
        wave =  sin(2 * pi * notes(note) * t);
        wave = adsrcall(wave, sample_rate, final_values, adsr_times);
        wave(1) = []; % Remove the first sample to avoid overlap
        longwave_treble = [longwave_treble, wave];
    end
    
    sound(longwave_treble, sample_rate);
end

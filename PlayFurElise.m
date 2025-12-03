% Description - Play fur elise function for GUI app
function PlayFurElise(sample_rate, bpm,final_values,adsr_times)
    % Tempo 4/4 at 200 BPM since a quarter is 1 beat and we have it as 0.25 duration we make bpm = 200/4 = 50
    beats_per_second = bpm / 60 / 4; % Divide by 4 for quarter note
    notes = dictionary('C',261.6,'C#',277.2,'D',293.7,'D#',311.1,'E',329.6,...
    'F',349.2,'F#',370.0,'G',392.0,'G#',415.3,'A',440.0,'A#',466.2,'B',493.9);

    % Fur Elise - Treble Clef
    notes_fur_elise = { "E5","D#5","E5","D#5","E5","B4","D5","C5", ...
                        "A4","C4","E4","A4","B4", ... % First Line
                        "E4","G#4","B4","C5", ...
                        "E4","E5","D#5","E5","D#5", ... % Second Line
                        "E5","B4","D5","C5","A4", ...
                        "C4","E4","A4","B4", ...
                        "E4","C5","B4","A4", % Third Line
                        };
    
    duration_note_fur_elise = {
        0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, ...
        0.5, 0.25, 0.25, 0.25, 0.5, ... % First Line
        0.25, 0.25, 0.25, 0.5, ...
        0.25, 0.25, 0.25, 0.25, 0.25, ... % Second Line
        0.25, 0.25, 0.25, 0.25, 0.5, ...
        0.25, 0.25, 0.25, 0.5, 0.25, ...
        0.25, 0.25, 1.0 % Third Line
        };
    
    % Generate Fur Elise waveform
    longwave_fur_elise = 0;
    for i = 1:length(notes_fur_elise)
        note = notes_fur_elise{i};
        duration = duration_note_fur_elise{i} / beats_per_second; % in seconds
        t = 0:1/sample_rate:duration;
    
        if endsWith(note, "4")
            note_name = extractBefore(note, strlength(note));
            octave = 4;
        elseif endsWith(note, "5")
            note_name = extractBefore(note, strlength(note));
            octave = 5;
        end
    
        frequency = notes(note_name) * 2^(octave - 4);
        wave =  sin(2 * pi * frequency * t);
        wave = adsrcall(wave, sample_rate, final_values, adsr_times);
        wave(1) = []; % Remove the first sample to avoid overlap
        longwave_fur_elise = [longwave_fur_elise, wave];
    end
    
    sound(longwave_fur_elise, sample_rate);
end


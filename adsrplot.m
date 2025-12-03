% Description - This is a truncated version of adsrcall.m that only
% generates the plot so we can use it in the GUI app.
function a = adsrplot(fs, final_value, duration)
    % Create ADSR envelope 
    % This function is to plot the ADSR in the app
    duration_samples = round(fs * duration);
    phase_ends = cumsum(duration_samples);
    
    % Build envelope
    a = zeros(1, phase_ends(end));
    a(1:phase_ends(1)) = linspace(0, final_value(1), duration_samples(1));
    
    for phase = 2:4
        start_idx = phase_ends(phase-1) + 1;
        end_idx = phase_ends(phase);
        a(start_idx:end_idx) = linspace(a(start_idx-1), final_value(phase), duration_samples(phase));
    end
end
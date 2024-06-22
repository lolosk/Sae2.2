function [Y] = effet_chorus(X, FS, coeff)
    % Paramètres pour l'effet chorus
    delays = [0.003, 0.007, 0.011];  % Délais en secondes
    mod_depth = 0.002;               % Profondeur de modulation en secondes
    mod_rate = [0.25, 0.3, 0.35];    % Fréquences de modulation en Hz
    
    N = length(X);
    Y = X;
    
    for i = 1:length(delays)
        delay_samples = round(delays(i) * FS);
        mod_depth_samples = round(mod_depth * FS);
        mod_signal = mod_depth_samples * sin(2 * pi * mod_rate(i) * (1:N) / FS);
        
        delayed_signal = zeros(1, N);
        for n = (delay_samples + mod_depth_samples + 1):N
            delay = delay_samples + round(mod_signal(n));
            if (n - delay) > 0
                delayed_signal(n) = X(n - delay);
            end
        end
        
        Y = Y + coeff * delayed_signal;
    end
    
    % Normalisation du signal de sortie
    Y = Y / max(abs(Y));
end

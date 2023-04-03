%% Esercizio 2 - Sistema meccanico

M = 0.2;                        % kg
beta = [0.1, 0.01, 10, 0.1];    % Ns/m
k = [2, 2, 20, 2];              % N/m

for i=1:1:4
    A = [0 -k(i)/M; 1 -k(i)/beta(i)];
    B = [1/M; 0];
    C = [1 0];
    D = 0;
    [num, den] = ss2tf(A,B,C,D);

    % Opzionale, giusto per plottare
    F = tf(num, den);
    figure(1);
    bode(F);
    grid on
    
    if i<4
        pause
    end
end

%% Esercizio 2 - Sistema elettrico

C_c = 0.2;                    % F
R = [10, 100, 0.1, 10];     % ohm
L = [0.5, 0.5, 0.05, 0.5];  % H

for i=1:1:4
    A = [0, -1/C_c; 1/L(i), -R(i)/L(i)];
    B = [1/C_c; 0];
    C = [1, 0];
    D = 0;
    [num, den] = ss2tf(A,B,C,D);

    % Opzionale, giusto per plottare
    F = tf(num, den);
    figure(1);
    bode(F);
    grid on
    
    if i<4
        pause
    end
end



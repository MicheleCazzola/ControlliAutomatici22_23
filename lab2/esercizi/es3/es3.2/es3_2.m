%% Analisi di stabilità di sistemi dinamici LTI - Caso discreto

B = [1, 1]';
C = [1, 3];
D = 0;

t = 0:0.1:20;
U = zeros(1, length(t));
x0 = [1, 2]';

A{1} = [-0.5, 1; 0, -2];
A{2} = [-0.5, 1; 0, -1];
A{3} = [-0.5, 1; 0, 0];
A{4} = [-0.5, 1; 0, 1];

% Punto 1: instabile
% Punto 2: semplicemente stabile
% Punto 3: asintoticamente stabile
% Punto 4: semplicemente stabile
for i=1:1:length(A)
    sys = ss(A{i}, B, C, D, 0.1);
    [~, TS, XS] = lsim(sys, U, t, x0);

    figure(i);
    plot(TS, XS(:,1), 'r', TS, XS(:,2), 'b');
    grid on
end

%% ESERCIZIO 1 - POSIZIONAMENTO POLI MEDIANTE RETROAZIONE DEGLI STATI

%% Definizione del sistema da controllare

A = [0 1; 900 0];
B = [0; -9];
C = [600 0];
D = [0];
n = length(A);

system = ss(A, B, C, D);

% Autovalori del sistema controllato desiderati
p = [-40 -60];
%% 1 - Controllo raggiungibilità

M_r = ctrb(system);
if(rank(M_r) < n)
    disp('Sistema non completamente raggiungibile');
    return
end
%% 2 - Progetto matrice K

K = place(A, B, p);
%% 3 - Definizione sistema controllato complessivo con retroazione statica dallo stato

% Valore indicato nella consegna
alfa = -1;
% Valore necessario per ottenere condizione di regolazione y = r
% alfa = inv(-(C - D*K)*inv(A - B*K)*B + D);            
A_rs = A - B*K;
B_rs = B * alfa;
C_rs = C - D*K;
D_rs = D * alfa;

controlled_system = ss(A_rs, B_rs, C_rs, D_rs);
%% 4 - Simulazione risposta del sistema con ingresso di riferimento dato, al variare dello stato iniziale

% Riferimento ad onda quadra: uscita (posizione) oscillante intorno alla
% posizione di equilibrio
t = 0:0.001:6;
r = sign(sin(2*pi*0.5 * t));

% Stato iniziale variabile (con velocità iniziale sempre nulla)
d_x0 = {[0; 0], [0.01; 0], [-0.01; 0]};

figure(1);
plot(t, r, 'k');
colors = ['r', 'g', 'b'];
d_x = {[],[],[]};
for i=1:1:3
    % Simulazione sistema con stato iniziale i-esimo
    [d_y, t, d_x{i}] = lsim(controlled_system, r, t, d_x0{i});
    
    hold on
    plot(t, d_y, colors(i));
    grid on
end

legend('r(t)','\deltay(t) with \deltax_0 = [0,0]', '\deltay(t) with \deltax_0 = [0.01,0]', ...
    '\deltay(t) with \deltax_0 = [-0.01,0]');
hold off

figure(2);
plot(t, d_x{1}(1), 'r', t, d_x{2}(1), 'g', t, d_x{3}(1), 'b');
grid on

figure(3);
plot(t, d_x{1}(2), 'r', t, d_x{2}(2), 'g', t, d_x{3}(2), 'b');
grid on


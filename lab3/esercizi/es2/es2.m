%% ESERCIZIO 2 - PROGETTO DI UN OSSERVATORE DELLO STATO

%% Passo 0 - Definizione del sistema 

A = [0, 1; -2400, -100];
B = [0; 9];
C = [600, 0];
D = [0];
n = length(A);

eigs = [-120, -180];
sys = ss(A, B, C, D);
%% Passo 1 - Analisi proprietà osservabilità

M_o = obsv(sys);
if(rank(M_o) < n)
    disp('Sistema non completamente ossrvabile');
    return
end

%% Passo 2 - Progetto vettore colonna L

L = place(A', C', eigs)';

%% Passo 3 - Definizione sistema controllato complessivo

A_tot = [A, zeros(n,n);L*C, A - L*C];
B_tot = [B; B];
C_tot = [C, zeros(1,n); zeros(1,n), C];
D_tot = [D; D];
controlled_system = ss(A_tot, B_tot, C_tot, D_tot);

%% Passo 4 - Simulazione risposta sistema controllato complessivo

% Definizione riferimento ad onda quadra
t = 0:0.001:4;
u = sign(sin(2*pi*0.5 * t));

% Definizione stato iniziale
x_s0 = [0; 0];
x_tot0 = {[0; 0; x_s0], [0.01; 0; x_s0], [-0.01; 0; x_s0]};

% Simulazione sistemi
[y_tot1, t1, x_tot1] = lsim(controlled_system, u, t, x_tot0{1});
[y_tot2, t2, x_tot2] = lsim(controlled_system, u, t, x_tot0{2});
[y_tot3, t3, x_tot3] = lsim(controlled_system, u, t, x_tot0{3});

% Plot uscita/uscita stimata
figure(1);
plot(t, u, 'k',...
    t1, y_tot1(:,1), 'r', t1, y_tot1(:,2), 'c--', ...
    t2, y_tot2(:,1), 'g', t2, y_tot2(:,2), 'y--',...
    t3, y_tot3(:,1), 'b', t3, y_tot3(:,2), 'm--');
grid on
legend('u(t)', ...
    'y(t) with \deltax_0 = [0,0]', 'y_{oss}(t) with \deltax_0 = [0,0]', ...
    'y(t) with \deltax_0 = [0.01,0]', 'y_{oss}(t) with \deltax_0 = [0.01,0]', ...
    'y(t) with \deltax_0 = [-0.01,0]', 'y_{oss}(t) with \deltax_0 = [-0.01,0]');

figure(2);
plot(t, u, 'k',...
    t1, y_tot1(:,1), 'r', t1, y_tot1(:,2), 'c--', ...
    t2, y_tot2(:,1), 'g', t2, y_tot2(:,2), 'y--',...
    t3, y_tot3(:,1), 'b', t3, y_tot3(:,2), 'm--');
grid on
axis([0, 0.2, -6, 6]);
legend('u(t)', ...
    'y(t) with \deltax_0 = [0,0]', 'y_{oss}(t) with \deltax_0 = [0,0]', ...
    'y(t) with \deltax_0 = [0.01,0]', 'y_{oss}(t) with \deltax_0 = [0.01,0]', ...
    'y(t) with \deltax_0 = [-0.01,0]', 'y_{oss}(t) with \deltax_0 = [-0.01,0]');

% Plot posizione/posizione stimata 
figure(3);
plot(t1, x_tot1(:,1), 'r', t1, x_tot1(:,3), 'c--', ...
    t2, x_tot2(:,1), 'g', t2, x_tot2(:,3), 'y--',...
    t3, x_tot3(:,1), 'b', t3, x_tot3(:,3), 'm--');
grid on
legend('x_{1}(t) with \deltax_0 = [0,0]', 'x_{1,oss}(t) with \deltax_0 = [0,0]', ...
    'x_{1}(t) with \deltax_0 = [0.01,0]', 'x_{1,oss}(t) with \deltax_0 = [0.01,0]', ...
    'x_{1}(t) with \deltax_0 = [-0.01,0]', 'x_{1,oss}(t) with \deltax_0 = [-0.01,0]');

figure(4);
plot(t1, x_tot1(:,1), 'r', t1, x_tot1(:,3), 'c--', ...
    t2, x_tot2(:,1), 'g', t2, x_tot2(:,3), 'y--',...
    t3, x_tot3(:,1), 'b', t3, x_tot3(:,3), 'm--');
grid on
axis([0, 0.2, -0.015, 0.015]);
legend('x_{1}(t) with \deltax_0 = [0,0]', 'x_{1,oss}(t) with \deltax_0 = [0,0]', ...
    'x_{1}(t) with \deltax_0 = [0.01,0]', 'x_{1,oss}(t) with \deltax_0 = [0.01,0]', ...
    'x_{1}(t) with \deltax_0 = [-0.01,0]', 'x_{1,oss}(t) with \deltax_0 = [-0.01,0]');

% Plot velocità/velocità stimata
figure(5);
plot(t1, x_tot1(:,2), 'r', t1, x_tot1(:,4), 'c--', ...
    t2, x_tot2(:,2), 'g', t2, x_tot2(:,4), 'y--',...
    t3, x_tot3(:,2), 'b', t3, x_tot3(:,4), 'm--');
grid on
legend('x_{2}(t) with \deltax_0 = [0,0]', 'x_{2,oss}(t) with \deltax_0 = [0,0]', ...
    'x_{2}(t) with \deltax_0 = [0.01,0]', 'x_{2,oss}(t) with \deltax_0 = [0.01,0]', ...
    'x_{2}(t) with \deltax_0 = [-0.01,0]', 'x_{2,oss}(t) with \deltax_0 = [-0.01,0]');

figure(6);
plot(t1, x_tot1(:,2), 'r', t1, x_tot1(:,4), 'c--', ...
    t2, x_tot2(:,2), 'g', t2, x_tot2(:,4), 'y--',...
    t3, x_tot3(:,2), 'b', t3, x_tot3(:,4), 'm--');
grid on
axis([0, 0.2, -0.15, 0.25]);
legend('x_{2}(t) with \deltax_0 = [0,0]', 'x_{2,oss}(t) with \deltax_0 = [0,0]', ...
    'x_{2}(t) with \deltax_0 = [0.01,0]', 'x_{2,oss}(t) with \deltax_0 = [0.01,0]', ...
    'x_{2}(t) with \deltax_0 = [-0.01,0]', 'x_{2,oss}(t) with \deltax_0 = [-0.01,0]');
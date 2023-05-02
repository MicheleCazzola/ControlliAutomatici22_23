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

L = place(A, C', eigs)';

%% Passo 3 - Definizione sistema controllato complessivo

A_tot = [A, zeros(n,n);L*C, A - L*C];
B_tot = [B; B];
C_tot = [C, zeros(1,n); zeros(1,n), C];
D_tot = [D; D];
controlled_system = ss(A_tot, B_tot, C_tot, D_tot);

%% Passo 4 - Simulazione risposta sistema controllato complessivo

t = 0:0.001:6;
r = sign(sin(2*pi*0.5 * t));

x_s0 = [0; 0];
x_tot0 = {[0; 0; x_s0], [0.01; 0; x_s0], [-0.01; 0; x_s0]};

figure(1);
[y_tot1, t1, x_tot1] = lsim(controlled_system, r, t, x_tot0{1});
[y_tot2, t2, x_tot2] = lsim(controlled_system, r, t, x_tot0{2});
[y_tot3, t3, x_tot3] = lsim(controlled_system, r, t, x_tot0{3});

figure(1);
plot(t1, y_tot1(:,1), 'r', t1, y_tot1(:,2), 'g', ...
    t2, y_tot2(:,1), 'b', t2, y_tot2(:,2), 'y',...
    t3, y_tot3(:,1), 'k', t3, y_tot3(:,2), 'm');
grid on

figure(2);
plot(t1, y_tot1(:,1), 'r', t1, y_tot1(:,2), 'g', ...
    t2, y_tot2(:,1), 'b', t2, y_tot2(:,2), 'y',...
    t3, y_tot3(:,1), 'k', t3, y_tot3(:,2), 'm');
grid on
axis([0, 0.2, -6, 6]);

figure(3);
plot(t1, x_tot1(:,1), 'r', t1, x_tot1(:,3), 'g', ...
    t2, x_tot2(:,1), 'b', t2, x_tot2(:,3), 'y',...
    t3, x_tot3(:,1), 'k', t3, x_tot3(:,3), 'm');
grid on

figure(4);
plot(t1, x_tot1(:,1), 'r', t1, x_tot1(:,3), 'g', ...
    t2, x_tot2(:,1), 'b', t2, x_tot2(:,3), 'y',...
    t3, x_tot3(:,1), 'k', t3, x_tot3(:,3), 'm');
grid on
axis([0, 0.2, -0.015, 0.015]);

figure(5);
plot(t1, x_tot1(:,2), 'r', t1, x_tot1(:,4), 'g', ...
    t2, x_tot2(:,2), 'b', t2, x_tot2(:,4), 'y',...
    t3, x_tot3(:,2), 'k', t3, x_tot3(:,4), 'm');
grid on

figure(6);
plot(t1, x_tot1(:,2), 'r', t1, x_tot1(:,4), 'g', ...
    t2, x_tot2(:,2), 'b', t2, x_tot2(:,4), 'y',...
    t3, x_tot3(:,2), 'k', t3, x_tot3(:,4), 'm');
grid on
axis([0, 0.2, -0.15, 0.25]);
%legend('r(t)','\deltay(t) with \deltax_0 = [0,0]', '\deltay(t) with \deltax_0 = [0.01,0]', ...
 %   '\deltay(t) with \deltax_0 = [-0.01,0]');
%hold off
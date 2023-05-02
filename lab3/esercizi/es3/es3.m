%% ESERCIZIO 3 - POSIZIONAMENTO DEI POLI MEDIANTE REGOLATORE

%% Passo 0 - Definizione sistema

A = [0 1; 900 0];
B = [0; -9];
C = [600 0];
D = [0];
n = length(A);

system = ss(A, B, C, D);
eigs_oss = [-120, -180];
eigs_rs = [-40, -60];

%% Passo 1 - Verifica proprietà raggiungibilità e osservabilità del sistema

M_r = ctrb(system);
M_o = obsv(system);
if(rank(M_r) < n)
    disp('Sistema non completamente raggiungibile');
    return
end
if(rank(M_o) < n)
    disp('Sistema non completamente osservabile');
    return
end

%% Passo 2 - Progetto vettore colonna L

L = place(A', C', eigs_oss)';

%% Passo 3 - Progetto vettore riga K

K = place(A, B, eigs_rs);

%% Passo 4 - Definizione sistema controllato complessivo

%alfa = -1;
inv(-(C - D*K)*inv(A - B*K)*B + D);
A_tot = [A, -B*K; L*C, A - B*K - L*C];
B_tot = [alfa * B; alfa * B];
C_tot = [C, -D*K; zeros(1,n), C - D*K];
D_tot = [alfa * D; alfa * D];
controlled_system = ss(A_tot, B_tot, C_tot, D_tot);

%% Passo 5 - Simulazione risposta sistema controllato complessivo

t = 0:0.001:6;
r = sign(sin(2*pi*0.5 * t));

dx_s0 = [0; 0];
dx_tot0 = {[0; 0; dx_s0], [0.01; 0; dx_s0], [-0.01; 0; dx_s0]};

[dy_tot1, t1, dx_tot1] = lsim(controlled_system, r, t, dx_tot0{1});
[dy_tot2, t2, dx_tot2] = lsim(controlled_system, r, t, dx_tot0{2});
[dy_tot3, t3, dx_tot3] = lsim(controlled_system, r, t, dx_tot0{3});

figure(1);
plot(t, r, 'k--', t1, dy_tot1(:,1), 'r', t1, dy_tot1(:,2), 'g', ...
    t2, dy_tot2(:,1), 'b', t2, dy_tot2(:,2), 'y',...
    t3, dy_tot3(:,1), 'k', t3, dy_tot3(:,2), 'm');
grid on

figure(2);
plot(t1, dy_tot1(:,1), 'r', t1, dy_tot1(:,2), 'g', ...
    t2, dy_tot2(:,1), 'b', t2, dy_tot2(:,2), 'y',...
    t3, dy_tot3(:,1), 'k', t3, dy_tot3(:,2), 'm');
grid on
axis([0, 0.2, -6, 6]);

figure(3);
plot(t1, dx_tot1(:,1), 'r', t1, dx_tot1(:,3), 'g', ...
    t2, dx_tot2(:,1), 'b', t2, dx_tot2(:,3), 'y',...
    t3, dx_tot3(:,1), 'k', t3, dx_tot3(:,3), 'm');
grid on

figure(4);
plot(t1, dx_tot1(:,1), 'r', t1, dx_tot1(:,3), 'g', ...
    t2, dx_tot2(:,1), 'b', t2, dx_tot2(:,3), 'y',...
    t3, dx_tot3(:,1), 'k', t3, dx_tot3(:,3), 'm');
grid on
axis([0, 0.2, -0.015, 0.015]);

figure(5);
plot(t1, dx_tot1(:,2), 'r', t1, dx_tot1(:,4), 'g', ...
    t2, dx_tot2(:,2), 'b', t2, dx_tot2(:,4), 'y',...
    t3, dx_tot3(:,2), 'k', t3, dx_tot3(:,4), 'm');
grid on

figure(6);
plot(t1, dx_tot1(:,2), 'r', t1, dx_tot1(:,4), 'g', ...
    t2, dx_tot2(:,2), 'b', t2, dx_tot2(:,4), 'y',...
    t3, dx_tot3(:,2), 'k', t3, dx_tot3(:,4), 'm');
grid on
axis([0, 0.2, -0.5, 0.7]);

%% Sistema meccanico - Gradino

M = 0.2;                        % kg
beta = [0.1, 0.01, 10, 0.1];    % Ns/m
k = [2, 2, 20, 2];              % N/m
u0 = 1;                         % N
n_in = [[0, u0]; [0, u0]; [u0, 0]];
d_in = [0, 1, 0; 1, 0, 0; 1, 0, 16];
input = ['Gradino'; 'Rampa  '; 'Coseno '];

for r=1:1:3
    for i=1:1:4
        A = [0 -k(i)/M; 1 -k(i)/beta(i)];
        B = [1/M; 0];
        C = [1 0];
        D = 0;
        
        [num,den] = ss2tf(A,B,C,D);
        H = tf(num, den);
        U = tf(n_in(r,:), d_in(r,:));

        Y = H * U;

        [num,den] = tfdata(Y, 'v');
        [R,P,K] = residue(num,den);
        
        % Plot bovini
        input(r,:)
        R,P,K
        
        if(r < 3 || i < 4)
            pause
        end
        
        % noti residui R e poli P, l'antitrasformata va calcolata a mano
    end
end

%% Sistema elettrico - Gradino

C_c = 0.2;                    % F
R_c = [10, 100, 0.1, 10];     % ohm
L = [0.5, 0.5, 0.05, 0.5];    % H
u0 = 1;                       % A
n_in = [[0, u0]; [0, u0]; [u0, 0]];
d_in = [0, 1, 0; 1, 0, 0; 1, 0, 16];
input = ['Gradino'; 'Rampa  '; 'Coseno '];

for r=1:1:3
    for i=1:1:4
        A = [0, -1/C_c; 1/L(i), -R_c(i)/L(i)];
        B = [1/C_c; 0];
        C = [1, 0];
        D = 0;

        [num,den] = ss2tf(A,B,C,D);
        H = tf(num, den);
        U = tf(n_in(r,:), d_in(r,:));

        Y = H * U;

        [num,den] = tfdata(Y, 'v');
        [R,P,K] = residue(num,den);
        
        % Plot bovini
        input(r,:)
        R,P,K
        
        if(r < 3 || i < 4)
            pause
        end
        
        % noti residui R e poli P, l'antitrasformata va calcolata a mano
    end
end
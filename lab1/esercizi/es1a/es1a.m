%% Esercizio 1a - Gradino unitario(a)

n = 1000;
T = linspace(0,10,n)';
F = ones(n,1);
M = 0.2;    % kg

beta = 0.1; % Ns/m
k = 2;      % N/m
X0 = [0; 0];

[Y,T,X] = mec_sim(k, M, beta, F, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1a - Gradino unitario(b)

n = 1000;
T = linspace(0,100,n)';
F = ones(n,1);

beta = 0.01;
k = 2;
X0 = [0; 0];

[Y,T,X] = mec_sim(k, M, beta, F, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1a - Gradino unitario(c)

n = 1000;
F = ones(n,1);

T = linspace(0,10,n)';
beta = 10;
k = 20;
X0 = [0; 0];

[Y,T,X] = mec_sim(k, M, beta, F, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1a - Gradino unitario(d)

n = 1000;
F = ones(n,1);

T = linspace(0,10,n)';
beta = 0.1;
k = 2;
X0 = [0; 0.2];

[Y,T,X] = mec_sim(k, M, beta, F, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1a - Seno(a)

n = 1000;
T = linspace(0,100,n)';
F = ones(n,1) .* sin(4*T);

beta = 0.1;
k = 2;
X0 = [0; 0];

[Y,T,X] = mec_sim(k, M, beta, F, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1a - Seno(b)

n = 1000;
T = linspace(0,100, n)';
F = ones(n,1) .* sin(T);

beta = 0.01;
k = 2;
X0 = [0; 0];

[Y,T,X] = mec_sim(k, M, beta, F, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1a - Seno(c)

n = 1000;
T = linspace(0,100, n)';
F = ones(n,1) .* sin(T);

beta = 10;
k = 20;
X0 = [0; 0];

[Y,T,X] = mec_sim(k, M, beta, F, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1a - Seno(d)

n = 1000;
T = linspace(0,100, n)';
F = ones(n,1) .* sin(T);

beta = 0.1;
k = 2;
X0 = [0; 0.2];

[Y,T,X] = mec_sim(k, M, beta, F, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

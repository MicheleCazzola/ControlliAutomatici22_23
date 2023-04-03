%% Esercizio 1b - Gradino unitario(a)

n = 1000;
T = linspace(0,15,n)';
I = ones(n,1);
C = 0.2;

R = 10;
L = 0.5;
X0 = [0; 0];

[Y,X] = elt_sim(R, L, C, I, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1b - Gradino unitario(b)

n = 1000;
T = linspace(0,100,n)';
I = ones(n,1);
C = 0.2;

R = 100;
L = 0.5;
X0 = [0; 0];

[Y,X] = elt_sim(R, L, C, I, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1b - Gradino unitario(c)

n = 1000;
T = linspace(0,10,n)';
I = ones(n,1);
C = 0.2;

R = 0.1;
L = 0.05;
X0 = [0; 0];

[Y,X] = elt_sim(R, L, C, I, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1b - Gradino unitario(d)

n = 1000;
T = linspace(0,10,n)';
I = ones(n,1);
C = 0.2;

R = 10;
L = 0.5;
X0 = [0; 0.2];

[Y,X] = elt_sim(R, L, C, I, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1b - Seno(a)

n = 1000;
T = linspace(0,50,n)';
I = ones(n,1) .* sin(4*T);
C = 0.2;

R = 10;
L = 0.5;
X0 = [0; 0];

[Y,X] = elt_sim(R, L, C, I, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1b - Seno(b)

n = 1000;
T = linspace(0,50,n)';
I = ones(n,1) .* sin(4*T);
C = 0.2;

R = 100;
L = 0.5;
X0 = [0; 0];

[Y,X] = elt_sim(R, L, C, I, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1b - Seno(c)

n = 1000;
T = linspace(0,50,n)';
I = ones(n,1) .* sin(4*T);
C = 0.2;

R = 0.1;
L = 0.05;
X0 = [0; 0];

[Y,X] = elt_sim(R, L, C, I, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on

%% Esercizio 1b - Seno(d)

n = 1000;
T = linspace(0,50,n)';
I = ones(n,1) .* sin(4*T);
C = 0.2;

R = 100;
L = 0.5;
X0 = [0; 0.2];

[Y,X] = elt_sim(R, L, C, I, X0, T);

figure(1);
plot(T,Y,'b',T,X(:,2),'r');
grid on
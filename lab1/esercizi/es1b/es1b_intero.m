%% Eserczio 1b - Intero

n = 1000;
C = 0.2;    % F
maxt = [10, 50, 10, 10, 20, 20, 20, 20];
R = [10, 100, 0.1, 10];         % ohm
L = [0.5, 0.5, 0.05, 0.5];      % H
X0 = [[0, 0]',[0, 0]',[0, 0]',[0, 0.2]'];

% Ingresso gradino unitario
for i=1:1:4
    T = linspace(0,maxt(i),n)';
    I = ones(n,1);
    [Y,X] = elt_sim(R(i), L(i), C, I, X0(:,i), T);
    
    plot(T,Y,'b',T,X(:,2),'r');
    grid on
    pause
end

% Ingresso sinusoidale
for i=1:1:4
    T = linspace(0,maxt(i+4),n)';
    I = ones(n,1) .* sin(4*T);
    [Y,X] = elt_sim(R(i), L(i), C, I, X0(:,i), T);
    
    plot(T,Y,'b',T,X(:,2),'r');
    grid on

    if(i<4) 
        pause
    end
end



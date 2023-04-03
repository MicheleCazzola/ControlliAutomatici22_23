%% Eserczio 1a - Intero

n = 1000;
M = 0.2;    % kg
maxt = [10, 100, 10, 10, 50, 80, 50, 50];
beta = [0.1, 0.01, 10, 0.1];    %Ns/m
k = [2, 2, 20, 2];              %N/m
X0 = [[0, 0]',[0, 0]',[0, 0]',[0, 0.2]'];

% Ingresso gradino unitario
for i=1:1:4
    T = linspace(0,maxt(i),n)';
    F = ones(n,1);
    [Y,X] = mec_sim(k(i), M, beta(i),F,X0(:,i),T);
    
    plot(T,Y,'b',T,X(:,2),'r');
    grid on
    pause
end

% Ingresso sinusoidale
for i=1:1:4
    T = linspace(0,maxt(i+4),n)';
    F = ones(n,1) .* sin(4*T);
    [Y,X] = mec_sim(k(i), M, beta(i),F,X0(:,i),T);
    
    plot(T,Y,'b',T,X(:,2),'r');
    grid on
    if(i<4) 
        pause
    end
end



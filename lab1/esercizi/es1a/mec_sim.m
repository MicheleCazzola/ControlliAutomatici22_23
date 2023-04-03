function [ Y,X ] = mec_sim(k, M, beta, input, X0, T)
    % Simulazione di sistema dinamico lineare meccanico

    A = [0 -k/M; 1 -k/beta];
    B = [1/M; 0];
    C = [1 0];
    D = [0];
    U = input;

    sys = ss(A, B, C, D);
    [Y,~,X] = lsim(sys, U, T, X0);

end


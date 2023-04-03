function [ Y, X ] = elt_sim( R, L, C, I, X0, T )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    
    A = [0, -1/C; 1/L, -R/L];
    B = [1/C; 0];
    C = [1, 0];
    D = [0];
    U = I;
    
    sys = ss(A, B, C, D);
    [Y,~,X] = lsim(sys, U, T, X0);

end


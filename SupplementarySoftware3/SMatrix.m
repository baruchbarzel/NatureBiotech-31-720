%% IMPORTANT:
%% THIS IS THE ORIGINAL SLENCING CODE APPEARING IN -
%% "NETWORK LINK PREDICTION BY GLOBAL SILENCING OF INDIRECT CORRELATIONS"
%% THIS CODE IS OUT OF DATE.
%% PLEASE USE IMPROVED VERSION OF THE CODE IN SUPPLEMENTARY SOFTWARE 1

function [S] = SMatrix(G)
clear S;

[N cols] = size(G);
D = (G - eye(N)) * G;
for i = 1:N
    for j = i + 1:N
        D(i,j) = 0;
        D(j,i) = 0;
    end
end

S = (G - eye(N) + D) * inv(G);

for i = 1:N
    S(i,i) = 0;
end

S = abs(S)/max(max(abs(S)));


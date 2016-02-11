function [CIJ] = makerandCIJ(N,K)

% inputs:
%           N = number of vertices
%           K = number of edges
% outputs:
%           CIJ = directed random connection matrix
%
% Generates a random directed binary connection matrix, with size (N,K) and
% no connections on the main diagonal
%
% Olaf Sporns, Indiana University, 2007

ind = ~eye(N);
i = find(ind);
rp = randperm(length(i));
irp = i(rp);

CIJ = zeros(N);
CIJ(irp(1:K)) = 1;

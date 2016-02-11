function [is,os,str] = strengths(CIJ)

% input:  
%         CIJ  = connection/adjacency matrix
% output: 
%         is   = instrength for all vertices
%         os   = outstrength for all vertices
%         str  = strength for all vertices
%
% Computes the instrength, outstrength, and strength (indegree + outdegree)
% for a directed weighted matrix.
%
% Olaf Sporns, Indiana University, 2007
% =========================================================================

% compute strengths
is = sum(CIJ,1);    % instrength = column sum of CIJ
os = sum(CIJ,2)';   % outstrength = row sum of CIJ
str = id+od;        % strength = instrength+outstrength



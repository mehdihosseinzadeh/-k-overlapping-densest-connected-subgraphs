clear;clc
% import data
data= importdata('/Users/mehdi/Desktop/Network_Analysis/github_dens_weighted/data/real_data/G_graphA.txt');
 
[A]=Spars_Matrix_Data_OneInstance(data); clear data;

disp(' Please insert the number of densest sub_graph')
K=input(' #K>> ');

% RUN K_SUBGRAPH PROBLEMS for one instance
tic;  
[W, max_Densities,max_density_Greedy,G]=K_subgraph(A,K);
Time = toc;

max_densities_all=sum(max_Densities);
[Dd]=distance_subG(K,W);

output={W, max_densities_all, max_Densities, Dd, G, Time};
clear W max_densities_all max_Densities Dd max_density_Greedy G Time













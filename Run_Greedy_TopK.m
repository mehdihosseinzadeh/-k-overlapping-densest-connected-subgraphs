clear;clc
% import data before run the algorithm
data_Import; clear i filename dataDir;

[A_all]=Spars_Matrix_Data_synth(data);

%% number of subGraph #K
disp(' Please insert the number of densest sub_graph')
K=input(' #K>> ');

%%%%%%%%%%%******** Runnibg for many instaces ***********^^^^^^^^^^^^^^^^^^^
 for j=1:size(A_all,2)
     data_iteration=j
     A=A_all{1,j};
%%%%%%%%%%*******************^^^^^^^^^^^^^^^^^^^
    %% RUN K_SUBGRAPH PROBLEMS
    tic;  % Running Timing
    [W, max_Densities,max_density_Greedy,G]=K_subgraph(A,K);
    Time = toc;

    max_densities_all=sum(max_Densities);
    %%%% Distance
    [Dd]=distance_subG(K,W);

    output{j}={W, max_densities_all, max_Densities, Dd, G, Time};
    clear W max_densities_all max_Densities Dd max_density_Greedy G Time

 end

%%%%%%%%%%% F1=F1(t/d) & F2=F1(d/t) measure
[F1,F2]=find_F1_measure(A_all,output); 


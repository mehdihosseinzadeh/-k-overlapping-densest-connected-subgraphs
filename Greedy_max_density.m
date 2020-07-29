function [max_density_Greedy,max_densetSub_Greedy,G]=Greedy_max_density(A)

Node_lable = cellstr(strcat({'N'},(string(1:size(A,1))')));
G = graph(A,Node_lable);

G1 = G;
iteration=size(A,1);
density= zeros(1,iteration);
z= zeros(1,iteration);

for i=1:iteration


node_number = numnodes(G1); 

weight = G1.Edges.Weight;

Degree_A = centrality(G1,'degree','Importance',G1.Edges.Weight);

density(i) = sum(weight)/node_number;
z(i)=(density(i)+ 2*(density(i)/node_number));

max_density_Greedy=max(density); 
max_z=max(z); 
          
  if z(i) >= max_z    
          max_density_Greedy = density(i);
          max_densetSub_Greedy=G1;
   end

   [m,mm]= min (Degree_A);
   G1 = rmnode(G1,mm);
   
end

%%%%% conncomp
bins = conncomp(max_densetSub_Greedy);
if any (bins>1)    
   number_of_comp = unique(bins);
   for j=1:size(number_of_comp,2)
       ind = find (bins==j);
       comp_ind=max_densetSub_Greedy.Nodes.Name(ind);
       comp{j} = subgraph(max_densetSub_Greedy,comp_ind);
       density_comp(j)= sum(comp{j}.Edges.Weight)/numnodes(comp{j});
   end
   max_density_comp=max(density_comp);
   [i1]=find (density_comp==max_density_comp);
   max_densetSub_Greedy=comp{i1};
end
%%%%%%%
end






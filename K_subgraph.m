function [W, max_Densities,max_density_Greedy,G]=K_subgraph(A,K)

W=[];
max_Densities=[];

% run greedy algorithm
[max_density_Greedy,max_densetSub_Greedy,G] = Greedy_max_density(A);

%%%% parameters
f = ((1/2)*size(G.Nodes,1));
alpha_value=0.05;
beta_value=(1-alpha_value);
%%%%
ite_step2=0;
%%%%%%%%%

W{1}=max_densetSub_Greedy;
max_Densities(1)=max_density_Greedy;
u_nodes=W{1}.Nodes;

Node_lable = (strcat({'N'},(string(1:size(A,1))')));
Degree_G = centrality(G,'degree','Importance',G.Edges.Weight);
Degree_GG=table(Node_lable,Degree_G);


for ite =2:K
    while size(W,2) < K
    ite=ite
    
    if size(W,2) > 1       
        u_nodes = union(u_nodes, W{ite-1}.Nodes);            
    end
    clear j
    
   if size(u_nodes,1) <= f
%%%%%%%######## STEP 1   
     disp('STEP 1')   
     %%%% parameter
      alpha = round((size(u_nodes.Name,1))*(alpha_value));

     %%% find degree and hubs of the union in G
     [q,qq]=ismember(u_nodes.Name,Degree_GG.Node_lable);
    
     degree_union = Degree_GG.Degree_G(qq);    
     [m,mm] = maxk(degree_union,alpha);
     
     qq(mm)=[]; 
     epsi = Degree_GG.Node_lable(qq); 
     
     %%% 
    clear q1 qq1 m1 mm1
     [q1,qq1]=ismember(W{ite-1}.Nodes.Name,Degree_GG.Node_lable);
     degree_subG{ite-1} = Degree_GG.Degree_G(qq1);    
     [m1,mm1] = min(degree_subG{ite-1});
     min_deg_W{ite-1}=W{ite-1}.Nodes.Name(mm1); 
     
    %%% 
     All_min_deg_W = {cat(1, min_deg_W{:})};  
     epsi=union(epsi,All_min_deg_W{1,1});
    %%%removing epsi from G
      clear G2   
      G2 = rmnode(G,epsi); 
         
        iteration=size(G2.Nodes,1);
        clear i density 
        
        density= zeros(1,iteration);
        z= zeros(1,iteration);
        for i=1:iteration

        node_number = numnodes(G2); 
        weight = G2.Edges.Weight;

        Degree_A = centrality(G2,'degree','Importance',G2.Edges.Weight);

        density(i) = sum(weight)/node_number;
        z(i)=(density(i)+ 2*(density(i)/node_number));

        max_density_Step1=max(density); 
        max_z=max(z);
        
        if z(i) >= max_z 

              max_density_Step1 = density(i);
              max_densSub_Step1=G2;
        end

           [m,mm]= min (Degree_A);
           G2 = rmnode(G2,mm);
        end

    %%%%% conncted component
    clear bins number_of_comp ind comp_ind comp density_comp max_density_comp i1
    bins = conncomp(max_densSub_Step1);
    if any (bins>1)    
       number_of_comp = unique(bins);
       for j=1:size(number_of_comp,2)
           ind = find (bins==j);
           comp_ind=max_densSub_Step1.Nodes.Name(ind);
           comp{j} = subgraph(max_densSub_Step1,comp_ind);
           density_comp(j)= sum(comp{j}.Edges.Weight)/numnodes(comp{j});
       end
       max_density_comp=max(density_comp);
       [i1]=find (density_comp==max_density_comp);
       max_densSub_Step1=comp{i1};
    end
    %%%%%%%

    W(size(W,2)+1)={max_densSub_Step1};
    max_Densities(size(W,2))=max_density_Step1;
   
    
   elseif size(u_nodes,1) > f
        %%%%%%%######## STEP 2
        disp('STEP 2') 
        beta = round((size(u_nodes.Name,1))*(beta_value))
    
        [q2,qq2]=ismember(u_nodes.Name,Degree_GG.Node_lable);
        degree_union = Degree_GG.Degree_G(qq2);    
        [m2,mm2] = mink(degree_union,beta);
     
         qq22=qq2(mm2); 
         epsi_st2 = Degree_GG.Node_lable(qq22); 
        
         % find min deg node of each subG in W
         if ite_step2==0 && ite~=2
             min_deg_W_st2=min_deg_W;    
         end  
         ite_step2=ite_step2+1;

         clear q2 qq2 m2 mm2 
         [q2,qq2]=ismember(W{ite-1}.Nodes.Name,Degree_GG.Node_lable);
         degree_subG{ite-1} = Degree_GG.Degree_G(qq2);    
         [m2,mm2] = min(degree_subG{ite-1});
         min_deg_W_st2{ite-1}=W{ite-1}.Nodes.Name(mm2); 
     
        
         All_min_deg_W_st2 = {cat(1, min_deg_W_st2{:})};  
         epsi_st2=union(epsi_st2,All_min_deg_W_st2{1,1});
                         
        clear G3
        G3 = rmnode(G,epsi_st2); 

        clear i density2 
        iteration=size(G3.Nodes,1);

        density2= zeros(1,iteration);
        z2= zeros(1,iteration);
            
            for i=1:iteration

            node_number = numnodes(G3); 
            weight = G3.Edges.Weight;

            Degree_A = centrality(G3,'degree','Importance',G3.Edges.Weight);

            density2(i) = sum(weight)/node_number;
            z2(i)=(density2(i)+ 2*(density2(i)/node_number));

            max_density_Step2=max(density2); 
            max_z2=max(z2);

          if z2(i) >= max_z2
                  max_density_Step2 = density2(i);
                  max_densSub_Step2=G3;
          end

           [m,mm]= min (Degree_A);
           G3 = rmnode(G3,mm);

            end
        
            %%%%% conncted component
            clear bins number_of_comp ind comp_ind comp density_comp max_density_comp i1
            bins = conncomp(max_densSub_Step2);
            if any (bins>1)    
               number_of_comp = unique(bins);
               for j=1:size(number_of_comp,2)
                   ind = find (bins==j);
                   comp_ind=max_densSub_Step2.Nodes.Name(ind);
                   comp{j} = subgraph(max_densSub_Step2,comp_ind);
                   density_comp(j)= sum(comp{j}.Edges.Weight)/numnodes(comp{j});
               end
               max_density_comp=max(density_comp);
               [i1]=find (density_comp==max_density_comp);
               max_densSub_Step2=comp{i1};
            end
            %%%%%%%

         W(size(W,2)+1)={max_densSub_Step2};
         max_Densities(size(W,2))=max_density_Step2;
    end
ite=ite+1;
    end
end




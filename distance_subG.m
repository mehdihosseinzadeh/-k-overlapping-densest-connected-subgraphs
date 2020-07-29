function [Dd]=distance_subG(K,W)
 
clear D d
 D{1}=0;
 for j=2:K
    
     for i=1:j-1    
  b{i}=ismember(W{1,i}.Nodes,W{1,j}.Nodes);
  c(i)=size(find(b{i}),1);
  d{i,j-1}={(2-((c(i)^2)/(size(W{1,i}.Nodes,1)* size(W{1,j}.Nodes,1))))};
     end
     clear dd;
     for jj=1:size(d(:,j-1),1)
      dd(jj)=cell2mat(d{jj,j-1});
     end
         D{jj+1}=sum(dd);  
         
 end
Dd1=D;
 clear Ddd;
   for jjj=2:size(Dd1,2)     %7/nov/2018
      Ddd(jjj)=Dd1{1,jjj};
     end
Dd=sum(Ddd);
end




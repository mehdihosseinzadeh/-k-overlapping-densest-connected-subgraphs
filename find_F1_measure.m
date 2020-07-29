function [F1,F2]=find_F1_measure(A_all,output)
%        %%%% NON OV subG
    c{1}=cellstr(strcat({'N'},(string(1:30)'))); 
    c{2}=cellstr(strcat({'N'},(string(31:60)')));   
    c{3}=cellstr(strcat({'N'},(string(61:90)'))); 
    c{4}=cellstr(strcat({'N'},(string(91:120)')));
    c{5}=cellstr(strcat({'N'},(string(121:150)')));
    
for j=1:size(A_all,2) %loop for each data
    A=A_all{1,j};
    Node_lable = cellstr(strcat({'N'},(string(1:size(A,1))')));
    G = graph(A,Node_lable); 
    
    for i=1:size(output{1,1}{1,1},2) %loop for each subg 'k' in each data
        w{i}=output{1,j}{1,1}{1,i}; 
        for ii=1:size(c,2) %loop for each plantted subg
            interse=size(intersect(w{i}.Nodes.Name,c{1,ii}),1);
            F11(i,ii)=1-((abs(size(w{i}.Nodes.Name,1))-interse)/size(w{i}.Nodes.Name,1));%F1(d/t)
            F22(i,ii)=1-(abs(size(c{1,ii},1)-interse)/size(c{1,ii},1));%F2(d/t)
        end
        val1(i) =max (F11(i,:)); %find best maching        
        val2(i) =max (F22(i,:)); %find best maching
        
    end
    F1(j)=mean (val1(i));
    F2(j)=mean (val2(i));
end

end







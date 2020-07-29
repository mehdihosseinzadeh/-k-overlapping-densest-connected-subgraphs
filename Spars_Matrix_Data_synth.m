function [A_all]=Spars_Matrix_Data_synth(data)
    for i=1:size(data,2)
        a=[]; b=[]; w=[];
        a= data{1,i}(:,1);
        b= data{1,i}(:,2);
        w= data{1,i}(:,3);
        a=a'; b=b'; w=w';

%         k=ones(size(a,1),1);
%         v = [k];
%         a=a+v; %add one to all elements in order to start from 1 instead of 0
%         b=b+v;

        G = graph(a,b,w);
        A_all{i} = adjacency(G,'weighted');
        clear a b aa bb k v G;
    end

end









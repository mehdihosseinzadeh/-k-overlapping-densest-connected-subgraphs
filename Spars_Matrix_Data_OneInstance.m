function [A]=Spars_Matrix_Data_OneInstance(data)

    for i = 1:size(data.textdata,1)
        a{i}= data.textdata{i,1};
        b{i} = data.textdata{i,2};
        w(i)= data.data(i,1);
    end
% a = [data(:,1)];
% b = [data(:,2)];
% k=ones(size(a,1),1);
% v = [k];
% a=a+v; %add one to all elements in order to start from 1 instead of 0
% b=b+v;
% v=[v;v];
% aa=[a;b];
% bb=[b;a];
% A = sparse(aa,bb,v);

G = graph(a,b,w);
A = adjacency(G,'weighted');

end









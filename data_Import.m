%%%%% many instances NON Overlapp
 dataDir = dir('/Users/mehdi/Desktop/Network_Analysis/github_dens_weighted/data/synthetic/GraphsNonOverlapping/NonOverlapping_all/*.txt');

%%%%% many instances NON Overlapp Noisy
 %dataDir = dir('/Users/mehdi/Desktop/Network_Analysis/github_dens_weighted/data/synthetic/GraphsNonOverlapping/Noise05/*.txt');


 for i = 1:size(dataDir,1)
     filename{i} = dataDir(i).name;
     %data{i} = importdata(strcat('/Users/mehdi/Desktop/Network_Analysis/github_dens_weighted/data/synthetic/GraphsNonOverlapping/Noise05/',filename{i}));
     data{i} = importdata(strcat('/Users/mehdi/Desktop/Network_Analysis/github_dens_weighted/data/synthetic/GraphsNonOverlapping/NonOverlapping_all/',filename{i}));

 
 end







close all;
clear all;

%Visualize Dataset
load('k_means_data.mat');
figure;
gscatter(x(1,:), x(2,:), g,'brg','+++');
legend('cluster 3','cluster 1','cluster 2','Location','northeast')

%Clustering
rng(3);
[IDX_i, C] = kmeans(x', 3);
figure;
gscatter(x(1,:), x(2,:), IDX_i,'rgb','+++');
hold on
plot(C(1,1),C(1,2),'co');
plot(C(2,1),C(2,2),'mo');
plot(C(3,1),C(3,2),'yo');
legend('cluster 1','cluster 2','cluster 3','centroid 1','centroid 2','centroid 3','Location','northeast')
hold off

%Centroid gone wrong
rng(27);
[IDX_i, C] = kmeans(x', 3);
figure;
gscatter(x(1,:), x(2,:), IDX_i,'rbg','+++');
hold on
plot(C(1,1),C(1,2),'co');
plot(C(2,1),C(2,2),'mo');
plot(C(3,1),C(3,2),'yo');
legend('cluster 1','cluster 2','cluster 3','centroid 1','centroid 2','centroid 3','Location','northeast')
hold off
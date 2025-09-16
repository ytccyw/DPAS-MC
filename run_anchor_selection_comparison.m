%A comparison of anchor selection between the proposed DPAS and 
% the state-of-the-art HBNC demonstrates that the anchors selected by DPAS
% exhibit greater stability and representativeness, as observed over 【multiple runs】.
clear
addpath("function\");addpath("HBNC\");
rng(20250330);
total_samples = 10000;
n_clusters = 4;
mu_high1 = [0, 0]; sigma_high1 = [1 0; 0 1];
data_high1 = mvnrnd(mu_high1, sigma_high1, 3000);
mu_high2 = [10, 5]; sigma_high2 = [0.8 -0.5; -0.5 0.8];
data_high2 = mvnrnd(mu_high2, sigma_high2, 3000);
mu_low = [7, -3]; sigma_low = [4 1.5; 1.5 3];
data_low = mvnrnd(mu_low, sigma_low, 2000); 
theta = 2*pi*rand(2000,1);
r = 5 + 1*randn(2000,1); 
data_ring = [r.*cos(theta)+3, r.*sin(theta)-2];
all_data = [data_high1; data_high2; data_low; data_ring];
labels = [ones(3000,1); 2*ones(3000,1); 3*ones(2000,1); 4*ones(2000,1)];
idx = randperm(total_samples);
data = all_data(idx,:);
labels = labels(idx);

figure;
gscatter(data(:,1), data(:,2), labels, 'rgbm', 'o*+s', 8);
grid on;

%%
rng('shuffle')
colors = [0.6, 0.8, 0.85;   
          0.5, 0.75, 0.15; 
          0.6, 0.5, 0.8;
          0.6, 0.5, 0.2];  
gscatter(data(:,1),data(:,2),labels,colors,'o',2);
hold

[label_pre,~,~,~,~] = Pre_HBNC(data);
[~,~,theta,~,~] = Impro_HBNC(data,label_pre);
scatter(theta(:,1),theta(:,2),[],[0,0.1,0],'filled','hexagram','MarkerFaceAlpha', 0.7);

womao = anchor_select(data,0.95);
scatter(womao(:,1),womao(:,2),[],[0.0, 0.4, 1],'filled','h','MarkerFaceAlpha', 0.7);
lgd =legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'HBNC', 'DPAS');
lgd.ItemTokenSize = [10, 10];     
set(gca, 'xtick', [], 'ytick', []);
fprintf("HBNC: %d anchors   DPAS: %d anchors",length(theta),length(womao))
clear
warning off
addpath("function\");addpath("measure\");addpath("tensor\")
%%%
%The datasets are publicly available but not included due to file size limitations.
%For all datasets, rows of matrix represent samples, and Y denotes the labels.
% Caltech256_fea 1000 10 0.99 10 NoisyMNIST 100000 100 0.5 10 stl10_fea
% 1000 10 0.3 10 SUNRGBD_fea 1000 1 0.45 10 VGGFace2_200_4Views 0.1 1e-4
% 0.85 100
datasetname='Caltech101-all_fea';
lambda=1;
alpha=0.01;
c=0.35;% parameter \phi
d=10;
load(datasetname)
V=length(X);
for v=1:V
    liemin = min(X{v},[],1);liemax = max(X{v},[],1);X{v}=rescale(X{v},"InputMin",liemin,"InputMax",liemax);
end
[RES,~] = DPAS_MC(X,Y,lambda,alpha,c,d);%ACC nmi Fscore Precision AR Purity Recall
fprintf('ACC = %f, NMI = %f, PUR = %f, F = %f\n', RES(1), RES(2), RES(6), RES(3));


function [res,time]= DPAS_MC(Xhang,Y,lambda,rho,miyu,weidu)
V=length(Xhang);
cls_num = length(unique(Y));
time=0;
for v=1:V
    tic;
    A{v} = anchor_select(Xhang{v},miyu);
    time=time+toc;
    S{v}=(Xhang{v}*A{v}')*(A{v}*A{v}'+lambda*eye(size(A{v},1)) )^(-1);
    S{v}=S{v}';
end
A_com = compatibility(A,weidu);
duiqijieguo = align_tensor(A_com);
[SS,~] = align(duiqijieguo,S);

SS=permute(SS, [2,1,3]);
aaaa=size(SS);
ss = SS(:);
[g, ~] = wshrinkObj(ss,1/rho,aaaa,1,3);
g=real(g);
SS = reshape(g,aaaa);
all=zeros(aaaa(1),aaaa(2));
for v=1:V
    S{v}=SS(:,:,v);
    rowmin = min(S{v},[],2);rowmax = max(S{v},[],2);S{v}=rescale(S{v},"InputMin",rowmin,"InputMax",rowmax);
    all=all+S{v};
end
[S,~,~]=svd(all,'econ');
[res,stdd]=myNMIACCwithmean(S,Y,cls_num);

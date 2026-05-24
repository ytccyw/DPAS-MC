function [SS,SS_juzhen] = align(duiqijieguo,S)
n=size(S{1},2);
m=length(duiqijieguo);
V=length(S);
SS = zeros(m,n,V);
for i=1:m
    do=duiqijieguo{i};
    for j=1:V
        now=do(do(:,1)==j,2);
        if now
            temp=S{j}(now,:);
            temp=mean(temp,1);
            
            SS(i,:,j)=temp;
        end
    end

end
SS_juzhen=SS(:,:,1);
for v=2:V
    SS_juzhen=SS_juzhen+SS(:,:,v);
end
SS_juzhen=SS_juzhen';
end
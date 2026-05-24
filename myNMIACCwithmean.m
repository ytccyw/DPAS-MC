function [res,resstd]= myNMIACCwithmean(U,Y,numclass)

stream = RandStream.getGlobalStream;
reset(stream);
U_normalized = U ./ repmat(sqrt(sum(U.^2, 2)), 1,size(U,2));
maxIter = 2;

for iter = 1:maxIter
    indx = kmeans(U_normalized,numclass,'MaxIter',100, 'Replicates',3);
    indx = indx(:);
    result(iter,:) = Clustering8Measure(Y,indx);
end
res = mean(result,1);
resstd = std(result,1);
function label = criterion(distance)
n = length(distance(distance~=0));
label = zeros(n,1);
[S,I]=sort(distance(distance~=0));

for k=1:n
    Cri(k)=(1/k*sum(S(1:k)))  /  (  k*(n-k)/n/n* (1/k*sum(S(1:k))-1/(n-k)*sum(S((k+1):n))).^2  );
end
[threshold,location]=min(Cri);
num_location = S(location);
label = distance<=num_location;

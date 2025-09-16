function [res_neighbor,time_neighbor,label_neighbor,object,theta,class] = Neighbor(X0,Y)
k = length(unique(Y)) ;
n = size(Y,1); 
label = zeros(n,1); 
 tic 

 [label_pre,object_pre,theta_pre,num_class_pre,class_pre] = Pre_HBNC(X0); 
 [label,object,theta,num_class,class] = Impro_HBNC(X0,label_pre,object_pre);
%%  Organize label results

label_neighbor = label;
res_neighbor = Clustering8Measure(label_neighbor, Y);
time_neighbor = toc;

end


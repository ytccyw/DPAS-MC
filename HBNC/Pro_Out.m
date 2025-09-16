function [label,theta,num_class,class] = Pro_Out(X0,label_pre)
flag = 1;
n = size(X0,1);
label = label_pre;
class = max(unique(label));
% Process Outliers
while flag
    class = max(unique(label));
    clear num_class;
    for i=1:class
        num_class(i,:) = sum(label==i);
    end
    clear theta;
    for i=1:class 
        theta(i,:) = mean(X0(label==i,:),1);
    end
    [number_min,class_min_number] = min(num_class);
    clear theta_distance;
    for i = 1 : class 
        theta_distance(i,1) =  norm(theta(class_min_number,:)-theta(i,:));
    end
    if class > 1
        if number_min >= 2 && min(theta_distance(theta_distance~=0))/mean(theta_distance(theta_distance~=0))>=0.8
            flag = 0;
        else
            class_ori = find(theta_distance==min(theta_distance(theta_distance~=0)));
            if class_ori < class_min_number 
                label(label==class_min_number) = class_ori;
                for i = class_min_number+1 : class
                    label(label==i) = i-1;
                end
            else
                label(label==class_ori) = class_min_number;
                for i = class_ori+1 : class
                    label(label==i) = i-1;
                end
            end
            clear theta;
            for i=1:class
                theta(i,:) = mean(X0(label==i,:),1);
            end
            
        end
    else
        flag = 0;
    end
    
end

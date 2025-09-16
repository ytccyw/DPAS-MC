function [label,object,theta,num_class,class] = Pre_HBNC(X0)
flag = 1;
n = size(X0,1);
label = zeros(n,1);
target = randi([1 n]); 
target_range_label = ones(n,1); 
target_range_label = target_range_label > 0; 
class = 1;

while flag
    target_range = X0(target_range_label,:); 
    n_target = size(target_range,1);
    clear target_distance;
    for i=1:n_target
        target_distance(i,:) = norm(X0(target,:)-target_range(i,:))^2;
    end
    target_class_label = criterion(target_distance); 

    % Distinguish samples within the target range
    target_label = target_range_label;
    target_label_loc = find(target_range_label==1); 
    target_label(target_label_loc(target_class_label==0)) = 0; 

    target_label_other = target_range_label & ~target_label;

    % Update class label
    if sum(target_label_other)>5 
        label(target_label) = class; 
        theta(class,:) = mean(X0(target_label,:),1);
        nc = sum(target_label);
        num_class(class,:) = nc;
        clear Xcalss;
        Xclass = X0(target_label,:); 
        clear object_distance;
        for i=1:nc
            object_distance(i,:) = norm(theta(class,:)-Xclass(i,:))^2;
        end
        object(class,:) = sum(object_distance);

        % find next target 
        target_range_loc = find(target_range_label==1);
        [~,next_target_loc]=max(target_distance); 
        target = target_range_loc(next_target_loc); 
        target_range_label = label == 0; 
        class = class + 1;
    elseif sum(target_label_other)>0 
        label(label==0) = class; 
        theta(class,:) = mean(X0(label==class,:),1);
        nc = sum(label==class);
        num_class(class,:) = nc;
        clear Xcalss;
        Xclass = X0(label==class,:);
        clear object_distance;
        for i=1:nc
            object_distance(i,:) = norm(theta(class,:)-Xclass(i,:))^2;
        end
        object(class,:) = sum(object_distance);
        flag = 0;
    else
        flag = 0;
    end
end
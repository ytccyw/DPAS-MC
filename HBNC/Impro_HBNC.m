function [label,object,theta,num_class,class] = Impro_HBNC(X0,label_pre)
flag = 1;
n = size(X0,1);
iter = 1;
[label,theta,num_class,class] = Pro_Out(X0,label_pre); 

while flag

    % Update variables
    for i=1:class
        clear Xclass;
        Xclass = X0(label==i,:);
        clear object_distance;
        for j = 1:num_class(i) 
            object_distance(j,:) = norm(theta(i,:)-Xclass(j,:))^2;
        end
        object(i,:) = sum(object_distance);
    end
    
   % find target range 
   [object_max,class_max] = max(object); 
    target_range_label = label == class_max; 

    
    next_target_selection = find(target_range_label==1);
    target = next_target_selection(randi([1 size(next_target_selection,1)]));
    
    target_range = X0(target_range_label,:);
    n_target = size(target_range,1);
    clear target_distance;
    for i=1:n_target
        target_distance(i,:) = norm(X0(target,:)-target_range(i,:))^2;
    end
    
    clear target_theta_distance;
    for i=1:size(theta,1) 
        target_theta_distance(i,:) = norm(X0(target,:)-theta(i,:))^2;
    end
    if min(target_theta_distance)<min(target_distance(target_distance~=0)) 
        far_class = find(target_theta_distance==min(target_theta_distance)); 
        clear next_target_distance;
        for i=1:size(next_target_selection,1) 
            next_target_distance(i,:) = norm(X0(next_target_selection(i),:)-theta(far_class,:))^2;
        end
        Loc = find(next_target_distance == max(next_target_distance));
        target = next_target_selection(Loc); 
        for i=1:n_target
            target_distance(i,:) = norm(X0(target,:)-target_range(i,:))^2;
        end
    end

    target_class_label = criterion(target_distance); 
    
     % Distinguish samples within the target range
    target_label = target_range_label;
    target_label_loc = find(target_range_label==1);
    target_label(target_label_loc(target_class_label==0)) = 0; 
    target_label_other = target_range_label & ~target_label;
    
    if sum(target_class_label) < sum(target_range_label)
        % Update label
        class = class + 1; 
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
        
        % Calculate the center and distance of the remaining samples of the original category
        class_ori = class_max; 
        clear Xorigin;
        Xorigin = X0(label==class_ori,:); 
        theta_origin = mean(Xorigin,1); 
        no = sum(label==class_ori); 
        num_class(class_ori,:) = no;
        clear origin_distance;
        for i=1:no 
            origin_distance(i,1) = norm(theta_origin-Xorigin(i,:))^2;
        end
        origin = sum(origin_distance);
        object(class_ori,:) = origin;
        theta(class_ori,:) = theta_origin;
    else
        flag = 0;
    end
    
    
    [object_max,class_max] = max(object); 
    object_othersMean = mean(object(object~=object_max)); 
    Obj(iter,:) = (object_max-object_othersMean)/object_othersMean;
    iter = iter + 1 ;
    if sum(label==class_max)<n/50 
        flag = 0;
    end
    if sum(num_class==1)>=1 
        flag = 0;
    end
    if (object_max-object_othersMean)/object_othersMean <= 0.5   
        flag = 0;
    end 
    
end


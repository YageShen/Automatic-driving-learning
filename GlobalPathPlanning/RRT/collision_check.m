function collisionflag=collision_check(p_nearest,pnew, obstacle_list)
    collisionflag=0;
    for i=1:length(obstacle_list(:,1))
        x0=p_nearest;
        x1=pnew;
        x2=[obstacle_list(i,1),obstacle_list(i,2)];
        dd = distance_squared_point_to_segment(x0,x1,x2);
        if dd<(obstacle_list(i,3))^2   %%距离小于障碍物半径
            collisionflag=1;
            return
        end
    end
end

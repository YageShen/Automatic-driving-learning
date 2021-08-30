function path = RRT_planning(start, goal, obstacle_list)
% 路径存放
path = [];
% nodes=[x,y,fatherx,fathery]
nodes = [start(1), start(2), start(1), start(2)];
pnew = start;
RRT_stepsize = 0.5;
p = 0.3;
goalFlag = 0;
while ~goalFlag
    p_randx = randi(16)-1;  %x随机采样范围0-15
    p_randy = randi(13)-1;  %x随机采样范围0-12
    p_rand = [p_randx,p_randy];
    %一定概率采样点取得目标点
    if rand(1) < p
        p_rand = goal;
    end
    minID = FindNearest(p_rand, nodes);
    p_nearest = nodes(minID,1:2);
    
    %随机点和树中最近点连线与x轴夹角
    theta = atan2(p_rand(2)-p_nearest(2),p_rand(1)-p_nearest(1));
    %计算新节点
    pnew(1)= p_nearest(1)+ RRT_stepsize*cos(theta);
    pnew(2)= p_nearest(2)+ RRT_stepsize*sin(theta);
    %看该随机点是否已在随机树nodes中，是的话重新选择,防止pnew在nodes里出现两次
%     father = FindFather(pnew, nodes);
    if FindFather(pnew, nodes) == 1   %如果father非空说明能找到父节点说明在nodes里，重复了，避免出错
        continue
    end
    
    collisionFlag = collision_check(p_nearest, pnew, obstacle_list);
    if collisionFlag == 0
        nodes = [pnew(1), pnew(2), p_nearest(1), p_nearest(2); nodes];
        % 画图
        xx = [pnew(1), p_nearest(1)];
        yy = [pnew(2), p_nearest(2)];
        plot(xx, yy, '-*r')
        hold on
        pause(0.001)
    else % 发生碰撞进行下一次采样
        continue;
    end
        
    goalFlag = is_near_goal(pnew, goal, RRT_stepsize);
    if goalFlag == 1
       nodes = [goal(1), goal(2), pnew(1), pnew(2); nodes];
       path = GetPath(nodes, start, goal);
       return
    end
end
end


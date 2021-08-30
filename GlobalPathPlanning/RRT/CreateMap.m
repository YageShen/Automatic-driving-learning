function [] = CreateMap(start, goal, obstacle_list)
%     %CreateMap.m
%     start = [0,0];
%     goal = [10,14];
%     %障碍物(x,y,radiu)
%     obstacle_list=[3,3,1.5;
%                    12,2,3;
%                    3,9,2;
%                    9,11,2];
    %画出地图框及障碍物           
    axis([-2,18,-2,15])
    hold on
    for i=1:length(obstacle_list(:,1))
    %调用画障碍物函数
    plot_obstacle(obstacle_list(i,1),obstacle_list(i,2),obstacle_list(i,3))
    end
    plot(start(1),start(2),'og')
    hold on
    plot(goal(1),goal(2),'or')
    hold on
end


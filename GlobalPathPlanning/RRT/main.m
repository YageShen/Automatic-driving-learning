clear;
close all;
start = [0,0];
goal = [10,14];
%障碍物(x,y,radiu)
obstacle_list=[3,3,1.5;
               12,2,3;
               3,9,2;
               9,11,2];
           
CreateMap(start, goal, obstacle_list);
path = RRT_planning(start, goal, obstacle_list);
plot(path(:,1), path(:,2), 'g', 'LineWidth', 3);
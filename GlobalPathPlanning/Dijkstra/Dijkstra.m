% map 1表示陆地, 0表示水路，2表示障碍。障碍不能到达， 到达陆地的代价为1，达到水路的代价为2
% 左上角为起点，右下角为终点，求最短路径
clc;
clear;
close all;
map = [1 1 1 1 0; 0 1 2 1 0; 1 1 2 1 1; 0 2 0 0 1];
cmap = [0 0 1;... % 陆地
        0 1 0;... % 水路
        0 0 0;... % 障碍
        1 0 0;... % 红色 已经搜索过的地方
        1 1 0]; % 黄色路径
    
colormap(cmap);
image(1.5, 1.5, map+1);
grid on;
axis image;

[rows,cols] = size(map);
start_node = sub2ind(size(map), 1, 1);
dest_node = sub2ind(size(map), rows, cols);
distFromStart = Inf(rows, cols);
distFromStart(start_node) = 0;
parent = zeros(rows, cols);


costStep = [2,1];
while true
	image(1.5, 1.5, map+1);
    grid on; 
    axis image; 
    drawnow; 
    % Find the node with the minimum distance 
    [min_dist, current] = min(distFromStart(:)); 
    if((current == dest_node) || isinf(min_dist))
        break;
    end
    
    map(current) = 3;
    distFromStart(current) = Inf;
    [r, c] = ind2sub(size(distFromStart), current);
    
    neighbor = [r-1,c; r+1,c; r,c-1; r,c+1];
    outRange = (neighbor(:,1)<1) + (neighbor(:,2)<1) + (neighbor(:,1)>rows) + (neighbor(:,2)>cols);
    locate = find(outRange>0);
    neighbor(locate,:) = [];
    neighborIndex = sub2ind(size(map), neighbor(:,1), neighbor(:,2));
    for i = 1:length(neighborIndex)
       if map(neighborIndex(i)) ~= 2 && map(neighborIndex(i)) ~= 3
          if distFromStart(neighborIndex(i)) > (min_dist + costStep(map(neighborIndex(i))+1))
              distFromStart(neighborIndex(i)) = (min_dist + costStep(map(neighborIndex(i))+1));
              parent(neighborIndex(i)) = current;
          end
       end
    end
end

if isinf(distFromStart(dest_node))
    route = [];
else
   route = [dest_node];
   while parent(route(1)) ~= 0
       route = [parent(route(1)), route];
   end
   for k = 1:length(route)
        map(route(k)) = 4;
        pause(0.1);
        image(1.5, 1.5, map+1); 
        grid on; 
        axis image; 
   end
end

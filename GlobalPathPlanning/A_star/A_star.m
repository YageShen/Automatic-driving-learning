clc
clear
close all

% define map and obstacle
map = [1 1 1 1 0; 0 1 2 1 0; 1 1 2 1 1; 0 2 0 0 1];
m = 4;
n = 5;
start_node = [1, 1];
target_node = [4, 5];
obs = [4,2; 4,3; 4,4];
costStep = [2,1]; % 0:水地，代价2； 1:陆地，代价1

% 初始化closeList
closeList = start_node;
closeList_path = {start_node, start_node};
closeList_cost = 0;
child_nodes = findChilds(start_node, map, closeList);

% 初始化openList
openList = child_nodes;
for i = 1:size(openList, 1)
   openList_path{i, 1} = openList(i, :);
   openList_path{i, 2} = [start_node; openList(i, :)];
   
   g = costStep(map(openList(i,1), openList(i,2))+1);
   h = abs(target_node(1) - openList(i,1)) + abs(target_node(2) - openList(i,2));
   f = g + h;
   openList_cost(i, :) = [g, h, f];
end

[~, min_idx] = min(openList_cost(:,3));
parent_node = openList(min_idx, :);

while true
	child_nodes = findChilds(parent_node, map, closeList);
    for i = 1:size(child_nodes, 1)
        [inFlag, openList_idx] = ismember(child_nodes(i,:), openList, 'rows');
        g = openList_cost(min_idx, 1) + costStep(map(child_nodes(i,1), child_nodes(i,2))+1);
        h = abs(child_nodes(i,1) - target_node(1)) + abs(child_nodes(i,2) - target_node(2));
        f = g + h;
        if inFlag
           if g < openList_cost(openList_idx, 1)
               openList_cost(openList_idx, 1) = g;
               openList_cost(openList_idx, 3) = f;
               openList_path{openList_idx, 2} = [openList_path{min_dix, 2}; child_nodes(i,:)];
           end
        else
            openList(end+1, :) = child_nodes(i,:);
            openList_cost(end+1, :) = [g, h, f];
            openList_path{end+1, 1} = child_nodes(i,:);
            openList_path{end, 2} = [openList_path{min_idx, 2}; child_nodes(i,:)];
        end
    end
        
    closeList(end+1,:) = openList(min_idx,:);
    closeList_cost(end+1, 1) = openList_cost(min_idx, 3);
    closeList_path(end+1,:) = openList_path(min_idx,:);
    openList(min_idx,:) = [];
    openList_cost(min_idx,:) = [];
    openList_path(min_idx,:) = [];

    [~, min_idx] = min(openList_cost(:,3));
    parent_node = openList(min_idx, :);
    if parent_node == target_node
        closeList(end+1,: ) =  openList(min_idx,:);
        closeList_cost(end+1,1) =   openList_cost(min_idx,1);
        closeList_path(end+1,:) = openList_path(min_idx,:);
        break;
    end
end

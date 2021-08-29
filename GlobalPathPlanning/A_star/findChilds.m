function childs = findChilds(parent, map, closeList)
    childs = [];
    [rows, cols] = size(map);
    if parent(1) > 1 && map(parent(1)-1, parent(2)) ~= 2
        childs = [childs; [parent(1)-1, parent(2)]];
    end
    if parent(1) < rows && map(parent(1)+1, parent(2)) ~= 2
        childs = [childs; [parent(1)+1, parent(2)]];
    end
    if parent(2) > 1 && map(parent(1), parent(2)-1) ~= 2
        childs = [childs; [parent(1), parent(2)-1]];
    end
    if parent(2) < cols && map(parent(1), parent(2)+1) ~= 2
        childs = [childs; [parent(1), parent(2)+1]];
    end
    
    delete_idx = [];
    for i = 1:size(childs, 1)
        if ismember(childs(i,:), closeList, 'rows')
           delete_idx(end+1,:) = i; 
        end
    end
    childs(delete_idx, :) = [];
end


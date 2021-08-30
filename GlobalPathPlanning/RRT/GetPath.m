function path = GetPath(nodes, start, goal)
    path = goal;
    parent = nodes(1, 3:4);
    parent_id = 1;
    while parent ~= start
       path = [parent; path];
       for i = parent_id:length(nodes(:,1))
           if nodes(i,1:2) == parent
               parent = nodes(i,3:4);
               parent_id = i;
               break;
           end
       end
    end
    path = [start; path];
end


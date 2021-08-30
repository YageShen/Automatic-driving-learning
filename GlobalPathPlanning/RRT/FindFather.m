function findFlag = FindFather(pnew, nodes)
    for i = 1:size(nodes(:,1))
       if pnew(1) == nodes(i, 1) && pnew(2) == nodes(i, 2)
           findFlag = 1;
           break;
       end
    end
    findFlag = 0;
end


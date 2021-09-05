% 找到离散参考轨迹上的预瞄点
function [lookAheadPoint, idx] = findLookAheadPoint(pos, RefPos, Ld)
    sizeOfRef = size(RefPos, 1);
    dist = zeros(sizeOfRef, 1);
    for i = 1:sizeOfRef
        dist(i) = norm(RefPos(i,:) - pos);
    end
    [~, idx_cur] = min(dist);
    pos_cur = RefPos(idx_cur, :);
    
    L_step = 0;
    idx = idx_cur + 1;
    while L_step < Ld && idx <= sizeOfRef - 1
        L_step = norm(RefPos(idx, :) - pos_cur);
        idx = idx + 1;
    end
    if norm(RefPos(idx, :) - pos_cur) > norm(RefPos(idx - 1, :) - pos_cur)
       idx = idx - 1; 
    end
    lookAheadPoint = RefPos(idx, :);
end


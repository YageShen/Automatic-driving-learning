function target_idx = findTargetIdx(state, RefPos)
    d = zeros(size(RefPos,1), 1);
    for i = 1:size(RefPos,1)
        d(i,1) = norm(RefPos(i,:) - state(1:2));
    end
    [~,target_idx] = min(d);  % 找到距离当前位置最近的一个参考轨迹点的序号
end


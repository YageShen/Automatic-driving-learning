function [delta, error] = pure_pursuit_control(lookAheadPoint, idx, pos, heading, RefPos, RefHeading, Ld, L)
%pure_pursuit_control 此处显示有关此函数的摘要
    sizeOfRefPos = size(RefPos,1);
    if idx < sizeOfRefPos
        Point_temp = lookAheadPoint;
    else
        Point_temp = RefPos(end,1:2);
    end
    alpha = atan2(Point_temp(2) - pos(2), Point_temp(1) - pos(1))  - heading;
    
    % 根据apollo计算横向误差
    pos_err = pos - RefPos(idx, :);
%     heading_err = heading - RefHeading(idx);
    heading_err = RefHeading(idx);
    error = pos_err(2) * cos (heading_err) - pos_err(1) * sin(heading_err);
    
    delta = atan2(2 * L * sin(alpha), Ld);
end


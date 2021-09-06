function [delta,error] = stanley_control(idx, state, RefPos, RefHeading, k)
    % 根据百度Apolo，计算横向误差
    x_err = state(1) - RefPos(idx,1);
    y_err = state(2) - RefPos(idx,2);
    heading_err = RefHeading(idx);
    error = y_err * cos(heading_err) - x_err * sin(heading_err);
    
    delta_heading = RefHeading(idx)- state(3);
    delta_y = atan2(-k * error, state(4));
    delta = delta_heading + delta_y;
end


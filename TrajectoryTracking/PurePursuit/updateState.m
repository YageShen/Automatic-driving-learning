function [pos_new, heading_new, v_new] = updateState(a, pos, heading, v, delta, L, dt)
    %updateState 更新系统状态
    v_new = v + dt * a;
    pos_new(1) = pos(1) + v * cos(heading) * dt;
    pos_new(2) = pos(2) + v * sin(heading) * dt;
    heading_new = heading + v * dt * tan(delta) / L;
end


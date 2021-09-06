function state_new = UpdateState(a, state, delta, dt, L)
    state_new(1) =  state(1) + state(4) * cos(state(3)) * dt;       %纵向坐标
    state_new(2) =  state(2) + state(4) * sin(state(3)) * dt;       %横向坐标
    state_new(3) =  state(3) + state(4) * dt * tan(delta) / L;      %航向角
    state_new(4) =  state(4) + a * dt;                                %纵向速度
end


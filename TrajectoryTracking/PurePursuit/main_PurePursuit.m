clc
clear
close all
load RefPath.mat

%% 相关参数定义
targetSpeed = 10;      % m/s
Kv = 0.1;              % 前视距离系数
Kp = 0.8;              % 速度P控制器系数
Ld0 = 2;               % Ld0是预瞄距离的下限值
dt = 0.1;              % 时间间隔，单位：s
L = 2.9;               % 车辆轴距，单位：m

%% 参考路径定义
RefPos = path;
RefHeading = atan2(diff(RefPos(:,2)), diff(RefPos(:,1)));	% 参考航向角

%% main
% initial state
pos = RefPos(1,:) + 1;
v = -10;
heading = 0.1;

% actual path
pos_actual = pos;
heading_actual = heading;
v_actual = v;
idx = 1;
latError_PP = [];

while idx < size(RefPos, 1) - 1
    Ld = Kv * v + Ld0;
    [lookAheadPoint, idx] = findLookAheadPoint(pos, RefPos, Ld);
    [delta, error] = pure_pursuit_control(lookAheadPoint, idx, pos, heading, RefPos, RefHeading, Ld, L);

    % 如果误差过大，退出循迹
    if abs(error) > 3
        disp('误差过大，退出程序!\n')
        break
    end
    
    % 计算加速度,纵向速度控制
    a = Kp * (targetSpeed - v) / dt;
    
    % 更新状态量
    [pos, heading, v] = updateState(a, pos, heading, v,delta,L, dt);
    
    % 保存每一步的实际量
    pos_actual(end+1,:) = pos;
    heading_actual(end+1,:) = heading;
    v_actual(end+1,:) = v;
    latError_PP(end+1,:) = [idx, error];
end

% 画图
figure
plot(RefPos(:,1), RefPos(:,2), 'b');
xlabel('纵向坐标 / m');
ylabel('横向坐标 / m');
hold on 
for i = 1:size(pos_actual,1)
    scatter(pos_actual(i,1), pos_actual(i,2),150, '.r');
    pause(0.01)
end
legend('规划车辆轨迹', '实际行驶轨迹')




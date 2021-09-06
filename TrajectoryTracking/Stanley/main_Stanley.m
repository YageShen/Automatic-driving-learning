clc
clear
close all
load  RefPath.mat

%% 相关参数定义
targetSpeed = 10;      % m/s
k = 5;                 % 增益系数
Kp = 0.8;              % 速度P控制器系数
dt = 0.1;              % 时间间隔，单位：s
L = 2.9;               % 车辆轴距，单位：m

%% 参考路径定义
RefPos = path;
RefHeading = atan2(diff(RefPos(:,2)), diff(RefPos(:,1)));	% 参考航向角
RefHeading(end+1) = RefHeading(end);

%% main
% initial state
InitialState = [RefPos(1,:)+1,RefHeading(1)+0.02,0];  % 纵向位置、横向位置、航向角、速度
state = InitialState;
state_actual = state;
idx = 1;
latError_Stanley = [];

% control
while idx < size(RefPos, 1) - 1
    % 距离当前位置最近的一个参考轨迹点的序号
    idx = findTargetIdx(state, RefPos);
    % Stanley control
    [delta, error] = stanley_control(idx, state, RefPos, RefHeading, k);

    % 如果误差过大，退出循迹
    if abs(error) > 3
        disp('误差过大，退出程序!\n')
        break
    end
    
    % 计算加速度
    a = Kp* (targetSpeed-state(4));    
    
    % 更新状态量
    state = UpdateState(a, state, delta, dt, L);
    
    % 保存每一步的实际量
    state_actual(end+1,:) = state;
    latError_Stanley(end+1,:) =  [idx,error];
end

% 画图
figure
plot(RefPos(:,1), RefPos(:,2), 'r');
xlabel('纵向坐标 / m');
ylabel('横向坐标 / m');
hold on
for i = 1:size(state_actual,1)
    scatter(state_actual(i,1), state_actual(i,2),150, 'b.');
    pause(0.01)
end
legend('规划车辆轨迹', '实际行驶轨迹')


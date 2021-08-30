function dd=distance_squared_point_to_segment(x1,x2,x3)
%""" 计算线段 vw 和 点 p 之间的最短距离""",x1 near v; x2 new w; x3 obstacle_圆心 p
%点 v 和 点 w 重合的情况
if isequal(x1,x2)
    dd = (x3(1)-x1(1))^2 + (x3(2)-x1(2))^2;
    return
end
%线段 vw 长度的平方
l2 = (x2(1)-x1(1))^2 + (x2(2)-x1(2))^2;
t = max(0, min(1, (x3 - x1)*(x2 - x1)' / l2));   %向量（x3-x1）乘向量（x2-x1）求到O-pnearest在pnearest-pnew上的投影，投影/l2求导垂足在线段长度中的百分比，可能超过1或为负数。超过1时，最短距离取x3x2,小于0时距离取x3x1
projection = x1 + t * (x2 - x1);
dd = (x3 - projection)*(x3 - projection)';
end

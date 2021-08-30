function [] = plot_obstacle(x,y,r)
    para = [x-r, y-r, 2*r, 2*r];
    rectangle('Position', para, 'Curvature', [1 1],'edgecolor','k','facecolor','k');
end


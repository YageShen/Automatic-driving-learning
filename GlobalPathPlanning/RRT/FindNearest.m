function minID=FindNearest(p_rand,nodes)
    %dist矩阵存放p_rand到nodes节点每个节点的距离
    %nodes的节点数
    nodes_num = length(nodes(:,1));
    prand_matx=ones(nodes_num,1)*p_rand(1);
    prand_maty=ones(nodes_num,1)*p_rand(2);
    nodes_matx=nodes(:,1);
    nodes_maty=nodes(:,2);
    dist=((prand_matx-nodes_matx).^2+(prand_maty-nodes_maty).^2).^0.5;
    minID=find(dist==min(dist));
    minID=minID(1);  %万一有多个同样小的，只取其中一个
end
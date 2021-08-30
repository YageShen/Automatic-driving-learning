function goalflag=is_near_goal(pnew,goal,RRT_stepsize)
    goalflag=0;
    dist=pdist([pnew;goal],'euclidean');
    if dist<RRT_stepsize
        goalflag=1;
        return
    end
end
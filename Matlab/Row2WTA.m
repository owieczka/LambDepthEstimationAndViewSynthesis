function [rowdepth] = Row2WTA(sad,dx,dd)
    rowdepth = zeros(1,dx);
    for x=[1:dx]
        [minsad,bestd] = min(sad(x,:));
        [minsad,bestdd] = min(diag(sad,-(x-bestd)));
        %minsad = sad(x,1);
        %bestd = 0;
        %for d=[1:dd-1]
        %    if(sad(x,d+1)<minsad)
        %        minsad = sad(x,d+1);
        %        bestd = d;
        %    end
        %end
        if(bestd==bestdd)
            rowdepth(x) = bestd-1;
        else
            rowdepth(x) = 0;
        end
    end
end
 
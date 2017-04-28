function [rowdepth] = RowWTA(sad,dx,ds,de)
    rowdepth = zeros(1,dx);
    for x=[1:dx]
        [minsad,bestd] = min(sad(x,:));
        %minsad = sad(x,1);
        %bestd = 0;
        %for d=[1:dd-1]
        %    if(sad(x,d+1)<minsad)
        %        minsad = sad(x,d+1);
        %        bestd = d;
        %    end
        %end
        rowdepth(x) = bestd-1;
    end
end
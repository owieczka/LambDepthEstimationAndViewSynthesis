function [rowdepth] = RowGlobal2WTA(sad,dx,dd)
    rowdepth = zeros(1,dx);
    %sad(:,1:10) = inf(dx,10);
    i=1;
    %ta sama linia sort(sad(:) powinno byæ
    %gry nie trafi bestd==bestdd bierziemy kolejnego bestd
    for x=1:dx
        [minsadvec,bestdvec] = min(sad,[],2);
        [minsad,bestx] = min(minsadvec);
        
        bestd = bestdvec(bestx);
        [minsad,bestdd] = min(diag(sad,-(bestx-bestd)));
        if(bestd==bestdd)
            rowdepth(bestx) = bestd-1;
            %sad(bestx,bestd)=inf;
            sad(bestx,:)=inf(1,dd);
            for a=1:dd
                if(bestx-bestd+a<=dx)
                    sad(bestx-bestd+a,a)=inf;
                end
            end
            %diag(sad,-(bestx-bestd));
            %imshow(sad,[0,128]);
            %anim(i) = getframe();
            %i=i+1;
        else
            rowdepth(bestx) = 0;
        end
    end
    %movie(anim,2);
end
 
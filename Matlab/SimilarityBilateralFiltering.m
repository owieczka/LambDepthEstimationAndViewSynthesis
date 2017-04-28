function sad = SimilarityBilateralFiltering(x,y,d,image0,image1,dm,dn,dx,dy,sigmacolor,sigmadistance)
    sad = inf;
    %sy = max(min(y-dn,dy),1);
    %ey = max(min(y+dn,dy),1);
    %sx = max(min(x-dm,dx),1);
    %ex = max(min(x+dm,dx),1);
    if(x-d>0)
        sy = y-dn;
        ey = y+dn;
        sx = x-dm;
        ex = x+dm;

        sxx= sx-d;
        exx= ex-d;
        sm = -dm;
        em = dm;
        sn = -dn;
        en = dn;
        while(sxx<1 || sx<1)
            sx=sx+1;
            sxx=sxx+1;
            sm=sm+1;
        end
        while(exx>dx || ex>dx)
            ex=ex-1;
            exx=exx-1;
            em=em-1;
        end
        while(sy<1)
            sy=sy+1;
            sn=sn+1;
        end
        while(ey>dy)
            ey=ey-1;
            en=en-1;
        end
        diff = abs(image0(sy:ey,sx:ex,:)-image1(sy:ey,sxx:exx,:));
        [a,b,c] =size(diff);
        distancemask = exp(-(ones(en-sn+1,1)*[sm:em].^2+([sn:en].^2)'*ones(1,em-sm+1))/(2*sigmadistance^2));
        color0mask = exp(-sum((image0(sy:ey,sx:ex,:)-repmat(reshape(image0(y,x,:),1,1,3),ey-sy+1,ex-sx+1)).^2,3)/(2*sigmacolor^2));
        color1mask = exp(-sum((image1(sy:ey,sxx:exx,:)-repmat(reshape(image1(y,x-d,:),1,1,3),ey-sy+1,exx-sxx+1)).^2,3)/(2*sigmacolor^2));
        ab = sum(sum(distancemask.*color0mask.*color1mask));
        %diff.*repmat(distancemask.*color0mask.*color1mask,[1,1,3])
        sad = sum(sum(sum(double(diff).*repmat(distancemask.*color0mask.*color1mask,[1,1,3]))))/(ab);
    end
end
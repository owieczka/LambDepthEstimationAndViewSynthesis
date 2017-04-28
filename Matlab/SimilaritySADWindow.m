function sad = SimilaritySADWindow(x,y,d,image0,image1,dm,dn,dx,dy)
    sad = inf;
    sy = max(min(y-dn,dy),1);
    ey = max(min(y+dn,dy),1);
    sx = max(min(x-dm,dx),1);
    ex = max(min(x+dm,dx),1);
    sxx= sx-d;
    exx= ex-d;
    while(sxx<1)
        sx=sx+1;
        sxx=sxx+1;
    end
    while(exx>dx)
        ex=ex-1;
        exx=exx-1;
    end
    diff = abs(image0(sy:ey,sx:ex,:)-image1(sy:ey,sxx:exx,:));
    [a,b,c] =size(diff);
    sad = sum(sum(sum(diff)))/(a*b);
end
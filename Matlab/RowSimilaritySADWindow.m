function [sad] = RowSimilaritySADWindow(y,image0,image1,dx,dy,dd,dm,dn)    
    sad = inf(dx,dd);
    dmm = 2*dm+1;
    dnn = 2*dn+1;
    sy = max(min(y-dn,dy),1);
    ey = max(min(y+dn,dy),1);
    for d=[0:dd-1]
        diff = sum(sum(abs(image0(sy:ey,d+1:end,:) - image1(sy:ey,1:end-d,:)),3),1);
        diff = diff/dnn;
        diff = cumsum(diff);
        a = (diff(dmm+1:end)-diff(1:end-dmm))/dmm;
        sad(d+1:dx,d+1) = [diff(dm+1:dmm)./[dm+1:dmm] a (diff(end)-diff(end-dmm+1:end-dm-1))./[dmm-1:-1:dm+1]];
    end
end
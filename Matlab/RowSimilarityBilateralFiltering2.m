function [sad] = RowSimilarityBilateralFiltering2(y,image0,image1,dx,dy,ds,de,dm,dn,sigmacolor,sigmadistance)
    sad = inf(dx,de-ds+1);
    
    sy = max(min(y-dn,dy),1);
    ey = max(min(y+dn,dy),1);    
    dmm = 2*dm+1;
    %dnn = 2*dn+1;
    dnn = ey-sy+1;
        
    %sn=-dn;
    sn = sy-y;
    en = ey-y;
    %en=+dn;
    sm=-dm;
    em=+dm;
    
    distancemask = exp(-(ones(en-sn+1,1)*([sm:em]).^2+([sn:en].^2)'*ones(1,em-sm+1))/(2*sigmadistance^2));
    distancemask = repmat(distancemask(:),1,dx);
    
    rowsimage0 = permute(image0(sy:ey,:,:),[3,1,2]); %Get lines and change order or elements [y,x,c] -> [c,y,x];
    rowsimage1 = permute(image1(sy:ey,:,:),[3,1,2]);
    color0mask = buffer(rowsimage0(:),dmm*dnn*3,dmm*dnn*3-dnn*3); %Take overlaped segments or image
    color1mask = buffer(rowsimage1(:),dmm*dnn*3,dmm*dnn*3-dnn*3); 
    
    %Extend masks at the end
    color0mask(:,end+1:end+dm) = 0;
    color1mask(:,end+1:end+dm) = 0;
    for i=[1:dm]%5-(1+2+1):5
        color0mask(1:(dmm-i)*dnn*3,end-dm+i) = color0mask((i)*dnn*3+1:end,end-dm);
        color1mask(1:(dmm-i)*dnn*3,end-dm+i) = color1mask((i)*dnn*3+1:end,end-dm);
    end
    %Cut the mask at the begining
    color0mask = color0mask(:,dm+1:end);
    color1mask = color1mask(:,dm+1:end);
    
    addr=((dmm*dnn+1)/2)*3; %Adress of middle block element;
    addr=((dmm*dnn+1)/2-(en+sn)/2)*3; %Adress of middle block element;
    color0mask = (color0mask - repmat(color0mask(addr-2:addr,:),[dmm*dnn,1])).^2; %Subtract middle element and square
    color1mask = (color1mask - repmat(color1mask(addr-2:addr,:),[dmm*dnn,1])).^2; 
    color0mask = reshape(exp(-sum(reshape(color0mask,3,dmm*dnn,dx))/(2*sigmacolor^2)),[dmm*dnn,dx]); %Calculare Color Mask
    color1mask = reshape(exp(-sum(reshape(color1mask,3,dmm*dnn,dx))/(2*sigmacolor^2)),[dmm*dnn,dx]); 
    %Clear unised coefficient of the mask
    for i=[1:dm]
        %At the begining
        color0mask(1:(dm+1-i)*dnn,i) = 0;
        color1mask(1:(dm+1-i)*dnn,i) = 0;
        %distancemask(1:(dm+1-i)*dnn,i) = 0;
        %At the end
        color0mask((dm+i)*dnn+1:end,end-i+1) = 0;
        color1mask((dm+i)*dnn+1:end,end-i+1) = 0;
        %distancemask((dm+i)*dnn+1:end,end-i+1) = 0;
    end    
    
            
    %v(bsxfun(@plus,(1:cs),(0:sh:length(v)-cs)')) cs=4;sh=2; v=natirx
   
    %color0mask = exp(-sum((image0(sy:ey,sx:ex,:)-repmat(reshape(image0(y,x,:),1,1,3),ey-sy+1,ex-sx+1)).^2,3)/(2*sigmacolor^2));
    %color1mask = exp(-sum((image1(sy:ey,sxx:exx,:)-repmat(reshape(image1(y,x-d,:),1,1,3),ey-sy+1,exx-sxx+1)).^2,3)/(2*sigmacolor^2));    
    
    for d=[ds:de]
        %d
        %SAD
        if(d>=0)
            diff = sum(abs(image0(sy:ey,d+1:end,:) - image1(sy:ey,1:end-d,:)),3);
        else
            diff = sum(abs(image0(sy:ey,1:end+d,:) - image1(sy:ey,-d+1:end,:)),3);
        end
        diff = buffer(diff(:),dmm*dnn,dmm*dnn-dnn);
        %Extend masks at the end
        diff(:,end+1:end+dm) = 0;
        for i=[1:dm]%5-(1+2+1):5
            diff(1:(dmm-i)*dnn,end-dm+i) = diff((i)*dnn+1:end,end-dm);
        end
        %And Cut at the begining
        diff = diff(:,dm+1:end);
        
        %size(distancemask(:,1:end-d))
        %size(color0mask(:,d+1:end))
        %size(color1mask(:,1:end-d))
        %size(diff)
        if(d>=0)
            nn = distancemask(:,1:end-d).*color0mask(:,d+1:end).*color1mask(:,1:end-d);
        else
            nn = distancemask(:,-d+1:end).*color0mask(:,1:end+d).*color1mask(:,-d+1:end);
        end
        diff = diff.*nn;
        diff = sum(diff,1)./sum(nn,1);
        %size(diff)
        if(d>=0)
            sad(d+1:dx,d-ds+1) = diff;
        else
            sad(1:dx+d,d-ds+1) = diff;
        end
        %diff = diff/dnn;
        %diff = cumsum(diff);
        %a = (diff(dmm+1:end)-diff(1:end-dmm))/dmm;
        %sad(d+1:dx,d+1) = [diff(dm+1:dmm)./[dm+1:dmm] a (diff(end)-diff(end-dm:end-1))./[dm:-1:1]];
    end
end
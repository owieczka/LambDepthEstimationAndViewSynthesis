function bp = BadPixel(newdepth,truedepth,nonocc,scale)
    [dy,dx] = size(newdepth);
    bp = sum(sum((uint8(abs(int8(newdepth) - int8(truedepth))).*nonocc)>scale))*100.0/(dy*dx);
    %bp = 0;
    %for y=[1:dy]
    %    for x=[1:dx]
    %        if(nonocc(y,x)>0)
    %            if(abs(int8(newdepth(y,x))-int8(truedepth(y,x)))>scale)
    %                bp = bp + 1;
    %            end
    %        end
    %    end
    %end
    %bp = bp*100/(dx*dy);
end
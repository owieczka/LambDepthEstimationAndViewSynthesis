function [sad] = RowSimilaritySADWindowNaive(y,image0,image1,dx,dy,dd,dm,dn)    
    sad = inf(dx,dd);
    for x=[1:dx]
        for d=[0:dd-1]
            %sad(x,d+1) = SimilaritySAD(x,y,d,image0,image1);
            sad(x,d+1) = SimilaritySADWindow(x,y,d,image0,image1,dm,dn,dx,dy);
        end
    end
end
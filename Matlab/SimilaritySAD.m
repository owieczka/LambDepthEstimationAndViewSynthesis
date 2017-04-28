function sad = SimilaritySAD(x,y,d,image0,image1)
    sad = inf;
    if(x-d>1)
        sad = sum(abs(image0(y,x,:) - image1(y,x-d,:)));
    end
end
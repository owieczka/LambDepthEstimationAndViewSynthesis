function [YUV,isEndOfFile] = ReadYUV(filename,dx,dy,frameid,bps)
    if nargin < 5
        bps = 8;
    end
    if bps==8
        mode = 'uint8';
    else
        if bps==16
            mode = 'uint16';
        end
    end
    fid = fopen(filename,'rb');
    fseek(fid,frameid*dx*dy*2*bps/8,'bof');
	y = fread(fid,dx*dy,mode);
    u = fread(fid,dx*dy/4,mode);
    v = fread(fid,dx*dy/4,mode);
    
    y = reshape(y,dx,dy)';
    u = reshape(u,dx/2,dy/2)';
    v = reshape(v,dx/2,dy/2)';
    
    u = imresize(u,2);
    v = imresize(v,2);
    
    YUV(:,:,1) = y;
    YUV(:,:,2) = u;
    YUV(:,:,3) = v;
    
    isEndOfFile = feof(fid);
    
    fclose(fid);
end
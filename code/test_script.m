for z = 1:size(img,3)
    fprintf('(%d/%d) %dth image slice is being processed...\n',z,size(img,3),z);
    img(:,:,z) =medfilt2(img(:,:,z),[3 3]);
end
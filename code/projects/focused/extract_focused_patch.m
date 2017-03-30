function [ret] = extract_focused_patch( img, seg, msk_id, bdr_id, patch, dust )
% Extract small focused annotation subvolumes from the whole segmentation.
%
% Args:
%   img: image.
%   seg: segmentation.
%   msk_id: focused annotation mask ID.
%   bdr_id: focused annotation border ID.
%   patch: minimum patch size.
%   dust: volume of dust connected component to ignore.

    if ~exist('patch','var'); patch = [256,256,20]; end;
    if ~exist('dust', 'var'); dust  = 100*100*1;    end;

    ret = {};

    % Find 3D connected components.
    BW = seg == msk_id;
    CC = bwconncomp(BW);

    % Process each connected component.
    siz = size(seg);
    idx = 1;
    n = CC.NumObjects;
    for i = 1:n
        indices = CC.PixelIdxList{i};
        [x,y,z] = ind2sub(siz,indices);
        % Bounding box.
        cmin  = [min(x),min(y),min(z)];
        cmax  = [max(x),max(y),max(z)];
        shape = cmax - cmin + 1;
        % Minimum volume & minimum z-dim constraints.
        if prod(shape) <= dust || shape(3) < 2
            continue;
        end
        % Extract subvolume.
        subseg = seg(cmin(1):cmax(1),cmin(2):cmax(2),cmin(3):cmax(3));
        subseg(subseg==msk_id)= 0;
        submsk = subseg > 0;
        subseg(subseg==bdr_id)= 0;
        % Padding.
        pre  = ceil((patch - shape)./2);
        pre  = max(pre,[0,0,0]);
        post = floor((patch - shape)./2);
        post = max(post,[0,0,0]);
        subseg = padarray(subseg,pre,'pre');
        subseg = padarray(subseg,post,'post');
        submsk = padarray(submsk,pre,'pre');
        submsk = padarray(submsk,post,'post');
        % Image.
        imin = cmin - pre;
        imax = cmax + post;
        % Handle out-of-bounds.
        off1 = [0,0,0];
        off2 = [0,0,0];
        if any(imin < 1)
            disp(['min: ' num2str(idx)]);
            off1 = (imin < 1) .* (abs(imin) + 1);
            imin = max(imin,[1,1,1]);
        end
        if any(imax > siz)
            disp(['max: ' num2str(idx)]);
            off2 = (imax > siz) .* (imax - siz);
            imax = min(imax,siz);
        end
        % Mirror.
        subimg = img(imin(1):imax(1),imin(2):imax(2),imin(3):imax(3));
        subimg = padarray(subimg,off1,'pre','symmetric');
        subimg = padarray(subimg,off2,'post','symmetric');
        % Return.
        ret{idx}.img = subimg;
        ret{idx}.seg = subseg;
        ret{idx}.msk = submsk;
        idx = idx + 1;
    end

end

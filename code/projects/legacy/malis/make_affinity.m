function [affs] = make_affinity( seg, dst, reverse )

    if ~exist('dst','var'); dst = [1,1,1]; end;
    if ~exist('reverse','var'); reverse = false; end;

    xaff = zeros(size(seg));
    yaff = zeros(size(seg));
    zaff = zeros(size(seg));

    fcn = @(x,y) (x == y) & (x > 0) & (y > 0);
    if reverse
        xaff(1:end-dst(1),:,:) = bsxfun(fcn,seg(1:end-dst(1),:,:),seg(dst(1)+1:end,:,:));
        yaff(:,1:end-dst(2),:) = bsxfun(fcn,seg(:,1:end-dst(2),:),seg(:,dst(2)+1:end,:));
        zaff(:,:,1:end-dst(3)) = bsxfun(fcn,seg(:,:,1:end-dst(3)),seg(:,:,dst(3)+1:end));
    else
        xaff(dst(1)+1:end,:,:) = bsxfun(fcn,seg(1:end-dst(1),:,:),seg(dst(1)+1:end,:,:));
        yaff(:,dst(2)+1:end,:) = bsxfun(fcn,seg(:,1:end-dst(2),:),seg(:,dst(2)+1:end,:));
        zaff(:,:,dst(3)+1:end) = bsxfun(fcn,seg(:,:,1:end-dst(3)),seg(:,:,dst(3)+1:end));
    end

    affs = cat(4,xaff,yaff,zaff);

end

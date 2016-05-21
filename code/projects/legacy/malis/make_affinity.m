function [affs] = make_affinity( seg, dst, reverse )

    if ~exist('dst','var'); dst = 1; end;
    if ~exist('reverse','var'); reverse = false; end;

    xaff = zeros(size(seg));
    yaff = zeros(size(seg));
    zaff = zeros(size(seg));

    fcn = @(x,y) (x == y) & (x > 0) & (y > 0);
    if reverse
        xaff(1:end-dst,:,:) = bsxfun(fcn,seg(1:end-dst,:,:),seg(dst+1:end,:,:));
        yaff(:,1:end-dst,:) = bsxfun(fcn,seg(:,1:end-dst,:),seg(:,dst+1:end,:));
        zaff(:,:,1:end-dst) = bsxfun(fcn,seg(:,:,1:end-dst),seg(:,:,dst+1:end));
    else
        xaff(dst+1:end,:,:) = bsxfun(fcn,seg(1:end-dst,:,:),seg(dst+1:end,:,:));
        yaff(:,dst+1:end,:) = bsxfun(fcn,seg(:,1:end-dst,:),seg(:,dst+1:end,:));
        zaff(:,:,dst+1:end) = bsxfun(fcn,seg(:,:,1:end-dst),seg(:,:,dst+1:end));
    end

    affs = cat(4,xaff,yaff,zaff);

end
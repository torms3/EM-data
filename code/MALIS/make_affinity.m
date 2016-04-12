function [affs] = make_affinity( seg )

    xaff = zeros(size(seg));
    yaff = zeros(size(seg));
    zaff = zeros(size(seg));

    fcn = @(x,y) (x == y) & (x > 0) & (y > 0);
    xaff(2:end,:,:) = bsxfun(fcn,seg(1:end-1,:,:),seg(2:end,:,:));
    yaff(:,2:end,:) = bsxfun(fcn,seg(:,1:end-1,:),seg(:,2:end,:));
    zaff(:,:,2:end) = bsxfun(fcn,seg(:,:,1:end-1),seg(:,:,2:end));

    affs = cat(4,xaff,yaff,zaff);

end
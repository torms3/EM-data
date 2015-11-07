function [xaff,yaff] = make_affinity( map, is_seg )

    if ~exist('is_seg','var'); is_seg = true; end;

    xaff = zeros(size(map));
    yaff = zeros(size(map));

    if is_seg
        fcn = @(x,y) (x == y) && (x*y > 0);
        xaff(2:end,:) = bsxfun(fcn,map(1:end-1,:),map(2:end,:));
        yaff(:,2:end) = bsxfun(fcn,map(:,1:end-1),map(:,2:end));
    else
        xaff(2:end,:) = bsxfun(@min,map(1:end-1,:),map(2:end,:));
        yaff(:,2:end) = bsxfun(@min,map(:,1:end-1),map(:,2:end));
    end

end
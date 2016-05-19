function [idx,map] = get_indexed_clrmap( data, clrmap, step )

    if ~exist('step','var'); step = 64; end;

    idx = fix(scaledata(data(:),1,step));
    idx = reshape(idx,size(data));
    map = eval([clrmap '(' num2str(step) ')']);

end
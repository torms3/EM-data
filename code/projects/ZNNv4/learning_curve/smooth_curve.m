function data = smooth_curve( data, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'data');
    addOptional(p,'w',1,@(x)isnumeric(x)&&(x>0));
    addOptional(p,'method','moving');
    parse(p,data,varargin{:});

    w = p.Results.w;
    m = p.Results.method;

    if w > 0
        filtered    = smooth(data.err,w,m);
        data.stderr = sqrt(smooth(data.err.^2,w,m) - filtered.^2);
        data.err    = filtered;
        filtered    = smooth(data.cls,w,m);
        data.stdcls = sqrt(smooth(data.cls.^2,w,m) - filtered.^2);
        data.cls    = filtered;

        % cutting leading and trailing edges
        if strcmp(m,'moving')
            hw  = floor(w/2);
            n   = numel(data.iter);
            idx = [1:hw n-hw+1:n];

            data.iter(idx)   = [];
            data.stderr(idx) = [];
            data.err(idx)    = [];
            data.stdcls(idx) = [];
            data.cls(idx)    = [];
        end
    end

end
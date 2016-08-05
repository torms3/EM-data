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
        fields = fieldnames(data);
        if isfield(data,'iter')
            iter = 'iter';
        elseif isfield(data,'it')
            iter = 'it';
        else
            assert(false);
        end
        for i = 1:numel(fields)
            field = fields{i};
            if strcmp(field,iter);continue;end;
            filtered = smooth(data.(field),w,m);
            data.(field) = filtered;
            key = ['stderr_' field];
            data.(key) = sqrt(smooth(data.(field).^2,w,m) - filtered.^2);
        end

        % cutting leading and trailing edges
        if strcmp(m,'moving')
            hw  = floor(w/2);
            n   = numel(data.(iter));
            idx = [1:hw n-hw+1:n];

            for i = 1:numel(fields)
                field = fields{i};
                data.(field)(idx) = [];
            end
        end
    end

end
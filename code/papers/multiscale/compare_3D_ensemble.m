function compare_3D_ensemble( data, metric, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'data',@(x)iscell(x));
    addRequired(p,'metric',@(x)isequal(metric,'Rand')||isequal(metric,'VI'));
    addOptional(p,'color',[],@(x)isnumeric(x)&&all(0<=x)&&all(x<=1)&&numel(x)==3);
    addOptional(p,'focus',[],@(x)isnumeric(x)&&all(0<=x)&&all(x<=1)&&numel(x)==2);
    addOptional(p,'width',[],@(x)isnumeric(x)&&(0<x));
    addOptional(p,'style','',@(x)isstr(x));
    addOptional(p,'lgnd',{},@(x)iscell(x));
    addOptional(p,'fontsize',{},@(x)isnumeric(x)&&(0<x));
    parse(p,data,metric,varargin{:});

    color = p.Results.color;
    width = p.Results.width;
    style = p.Results.style;
    focus = p.Results.focus;
    lgnd  = p.Results.lgnd;

    ndata = numel(data);

    fontsize = get(0,'DefaultAxesFontSize');
    set(0,'DefaultAxesFontSize',p.Results.fontsize);

    figure;
    hold on;
    plot_comparison(metric);
    hold off;
    daspect([1 1 1]);

    % revert default font size
    set(0,'DefaultAxesFontSize',fontsize);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function plot_comparison( metric )

        clrmap = colormap(lines);

        for i = 1:ndata
            h = merge_split_curve(data{i},metric,lgnd{i});

            % line color
            if isempty(color)
                h.Color = clrmap(i,:);
            else
                h.Color = color;
            end

            % line style
            if i < 4
              if ~isempty(style); h.LineStyle = style; end;
            end
            if ~isempty(width); h.LineWidth = width; end;
        end

        % legend
        if ~isempty(lgnd); legend(lgnd,'location','Best'); end;

        % focus
        if isempty(focus)
            axis([0 1 0 1]);
        else
            v = axis;
            axis([focus(1) v(2) focus(2) v(4)]);
        end

    end

end

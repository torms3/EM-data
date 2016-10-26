function compare_voxel( data, metric, varargin )

    % Input parsing & validation.
    p = inputParser;
    addRequired(p,'data',@(x)iscell(x));
    addRequired(p,'metric',@(x)isequal(metric,'Rand')||isequal(metric,'VI')||isequal(metric,'Voxel'));
    addOptional(p,'lwidth',1.0,@(x)isnumeric(x)&&(0<x));
    addOptional(p,'lstyle','-',@(x)isstr(x));
    addOptional(p,'mstyle','o',@(x)isstr(x));
    addOptional(p,'lgnd',{},@(x)iscell(x));
    addOptional(p,'fontsize',0,@(x)isnumeric(x)&&(0<x));
    parse(p,data,metric,varargin{:});

    lwidth = p.Results.lwidth;
    lstyle = p.Results.lstyle;
    mstyle = p.Results.mstyle;
    lgnd   = p.Results.lgnd;

    fontsize = get(0,'DefaultAxesFontSize');
    if p.Results.fontsize > 0
        set(0,'DefaultAxesFontSize',p.Results.fontsize);
    end

    figure;

    % Curves.
    hold on;
    for i = 1:numel(data)
        x = data{i}.iter;
        y = data{i}.data;
        h = plot(x,y);
        % Style.
        if ~isempty(lwidth); h.LineWidth = lwidth; end;
        if ~isempty(lstyle); h.LineStyle = lstyle; end;
        if ~isempty(mstyle); h.Marker    = mstyle; end;
        % Best score.
        color{i} = h.Color;
        [best{i},idx{i}] = max(y);
        disp(['Best ' metric ' score = ' num2str(best{i}) ' (' lgnd{i} ')']);
    end
    hold off;

    % Revert default font size.
    set(0,'DefaultAxesFontSize',fontsize);

    % Plot decoration.
    grid on;
    xlabel('Iteration');
    ylabel('Score');
    legend(lgnd,'location','Best');
    title([metric ' score']);

    % Best line.
    hold on;
    for i = 1:numel(data)
        x = data{i}.iter(idx{i});
        y = best{i};
        h = plot(x,y,'o');
        h.Color = [0 0 0];
        h.MarkerFaceColor = color{i};
        line([0 x],[y y],'LineStyle','-.','Color',color{i});
    end
    hold off;

end

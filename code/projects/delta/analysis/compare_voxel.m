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
    hold on;
    for i = 1:numel(data)
        x = data{i}.iter;
        y = 1-data{i}.data;
        h = plot(x,y);
        if ~isempty(lwidth); h.LineWidth = lwidth; end;
        if ~isempty(lstyle); h.LineStyle = lstyle; end;
        if ~isempty(mstyle); h.Marker    = mstyle; end;
        % Best accuracy.
        disp(['Best accuracy = ' num2str(max(y)) ' (' lgnd{i} ')']);
    end
    hold off;

    % Revert default font size.
    set(0,'DefaultAxesFontSize',fontsize);

    % Plot decoration.
    grid on;
    xlabel('Iteration');
    ylabel('Accuracy');
    legend(lgnd,'location','Best');
    title([metric ' accuracy']);

end

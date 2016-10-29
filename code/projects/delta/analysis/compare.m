function compare( data, metric, varargin )

    % Input parsing & validation.
    p = inputParser;
    % Data cell.
    addRequired(p,'data',@(x)iscell(x));
    % Metric.
    fcn = @(x) isequal(x,'Rand')||isequal(x,'VI')||isequal(x,'Voxel');
    addRequired(p,'metric',fcn);
    % Plot legend.
    default = repmat({''},size(data));
    fcn = @(x) isequal(size(data),size(x)) && iscell(x);
    addOptional(p,'lgnd',default,fcn);
    % Line style.
    default = repmat({'-'},1,size(data,2));
    fcn = @(x) numel(x)==size(data,2) && iscell(x);
    addOptional(p,'lstyle',default,fcn);
    % Decorations.
    addOptional(p,'lwidth',1.0,@(x)isnumeric(x)&&(0<x));
    addOptional(p,'mstyle','o',@(x)isstr(x));
    addOptional(p,'bstyle',':',@(x)isstr(x));
    addOptional(p,'fontsize',0,@(x)isnumeric(x)&&(0<x));
    % Parse input.
    parse(p,data,metric,varargin{:});

    lstyle = p.Results.lstyle;
    lwidth = p.Results.lwidth;
    mstyle = p.Results.mstyle;
    bstyle = p.Results.bstyle;
    lgnd   = p.Results.lgnd;

    fontsize = get(0,'DefaultAxesFontSize');
    if p.Results.fontsize > 0
        set(0,'DefaultAxesFontSize',p.Results.fontsize);
    end

    figure;

    % Colormap.
    clr = colormap('lines');
    clr = clr(1:size(data,1),:);

    % Curves.
    hold on;
    for j = 1:size(data,2)
        for i = 1:size(data,1)
            x = data{i,j}.iter;
            y = data{i,j}.data;
            h = plot(x,y);
            % Style.
            h.LineStyle = lstyle{j};
            h.LineWidth = lwidth;
            h.Marker    = mstyle;
            h.Color     = clr(i,:);
            color{i,j}  = h.Color;
            % Best score.
            [best(i,j),idx(i,j)] = max(y);
            disp(['Best ' metric ' score = ' num2str(best(i,j)) ' (' lgnd{i,j} ')']);
        end
    end
    hold off;

    % Revert default font size.
    set(0,'DefaultAxesFontSize',fontsize);

    % Plot decoration.
    grid on;
    xlabel('Iteration');
    ylabel('Score');
    % legend(lgnd{:},'location','bestoutside');
    legend(lgnd{:},'location','best');
    title([metric ' score']);

    % Best line.
    [M,I] = max(best,[],2);
    hold on;
    for i = 1:size(data,1)
        j = I(i);
        x = data{i,j}.iter(idx(i,j));
        y = best(i,j);
        h = plot(x,y,'o');
        h.Color = [0 0 0];
        h.MarkerFaceColor = color{i,j};
        line([0 x],[y y],'LineStyle',bstyle,'Color',color{i,j});
    end
    hold off;

end

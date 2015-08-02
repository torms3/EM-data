function compare_prec_rec_curve( batch )

    % batch name
    batchname = {'Test'; ...
                 'Training';  ...
                 'Training'};

    S = get_exp_list;

    % collect data
    for i = 1:numel(S)    

        disp(S{i}.lgnd);
        cd(S{i}.path);        

        % load
        file = dir(['out' num2str(batch) '*.mat']);
        if isempty(file)
            S{i}.prec = nan;
            S{i}.rec  = nan;
        else
            load(file(1).name,'result');
        
            % metrics
            [~,idx] = sort(result.conn.rec,'ascend');
            S{i}.conn.rec  = result.conn.rec(idx);
            S{i}.conn.prec = result.conn.prec(idx);
            
            [~,idx] = sort(result.ws.rec,'ascend');
            S{i}.ws.rec  = result.ws.rec(idx);
            S{i}.ws.prec = result.ws.prec(idx);
        end

    end

    % plot
    % plot_comparison('conn','connected component');
    plot_comparison('ws','watershed');


    function plot_comparison( field, method )

        fontsize = get(0,'DefaultAxesFontSize');
        set(0,'DefaultAxesFontSize',24);

        color = colormap(lines);

        marker = {'-x','-s','-o'};
        % marker = {'-x','-d','-s','-o'};

        figure;
        hold on;
        for i = 1:numel(S)
            data = S{i};
            h(i) = plot(data.(field).rec,data.(field).prec,marker{i},'LineWidth',3,'MarkerSize',16);
            lgnd{i} = data.lgnd;
        end
        hold off;
        grid on;
        xlim([0.6 1]);ylim([0.6 1]);
        
        xlabel('Recall');
        ylabel('Precision');        
        legend(h,lgnd,'Location','SouthWest');

        title(['Rand score (' method ')']);

        % revert default font size
        set(0,'DefaultAxesFontSize',fontsize);

    end

end
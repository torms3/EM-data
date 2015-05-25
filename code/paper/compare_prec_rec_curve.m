function compare_prec_rec_curve( batch )

    % batch name
    batchname = {'7nm-IDSIA (Test)'; ...
                 '7nm-512pix (Training)';  ...
                 '7nm-notTrained (Training)'};

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
            S{i}.prec = result.conn.prec;
            S{i}.rec  = result.conn.rec;
        end

    end

    % plot
    plot_comparison;


    function plot_comparison

        fontsize = get(0,'DefaultAxesFontSize');
        set(0,'DefaultAxesFontSize',12);

        figure;
        hold on;
        for i = 1:numel(S)
            data = S{i};
            plot(data.rec,data.prec,'LineWidth',1.5);
            lgnd{i} = data.lgnd;
        end
        hold off;
        grid on;
        xlim([0.5 1]);ylim([0.5 1]);
        
        xlabel('Recall');
        ylabel('Precision');        
        legend(lgnd,'Location','Best');

        title(['Precision-Recall Curve on ' batchname{batch}]);

        % revert default font size
        set(0,'DefaultAxesFontSize',fontsize);

    end

end
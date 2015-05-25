function compare_boundary_result

    % batch name
    batchname = {'7nm-512pix (Training)';     ...
                 '7nm-notTrained (Training)'; ...
                 '7nm-IDSIA (Validation)'};

    S = get_exp_list;

    % collect data
    for i = 1:numel(S)    

        disp(S{i}.lgnd);
        cd(S{i}.path);

        batch = S{i}.batch;
        for j = 1:numel(batch)

            % load
            file = dir(['out' num2str(batch(j)) '*.mat']);
            if isempty(file)
                S{i}.pixel(j)   = nan;
                S{i}.rand2D(j)  = nan;
            else
                load(file(1).name,'result');
            
                % metrics
                S{i}.pixel(j)   = min(result.voxel.err);
                S{i}.rand2D(j)  = min(result.conn.re);
            end
            
        end

    end

    % plot
    plot_comparison;


    function plot_comparison

        fontsize = get(0,'DefaultAxesFontSize');
        set(0,'DefaultAxesFontSize',12);


        %% Pixel classification error
        %
        data = [];
        lgnd = {};
        for i = 1:numel(S)
            data(:,end+1) = S{i}.pixel(:);
            lgnd{end+1} = S{i}.lgnd;
        end
        
        % plot
        figure;
        subplot(2,1,1);
        h = bar(data,'grouped');
        v = axis;
        axis([v(1) v(2) 0.07 0.13]);
        grid on;
        set(gca,'XTickLabel',batchname,'XTick',1:numel(batchname));
        fix_xticklabels(gca,0.1,{'FontSize',12});
        legend(lgnd,'Location','bestoutside');
        ylabel('Best pixel error');
        title('Pixel Classification Error');

        
        %% 2D Rand error
        %
        data = [];
        for i = 1:numel(S)
            data = [data S{i}.rand2D(:)];
        end

        % plot
        % figure;
        subplot(2,1,2);
        h = bar(data,'grouped');
        v = axis;
        axis([v(1) v(2) 0.08 0.18]);
        grid on;
        set(gca,'XTickLabel',batchname,'XTick',1:numel(batchname));
        fix_xticklabels(gca,0.1,{'FontSize',12});
        legend(lgnd,'Location','bestoutside');
        ylabel('Best 2D Rand error');
        title('2D Rand Error');


        % revert default font size
        set(0,'DefaultAxesFontSize',fontsize);

    end

end
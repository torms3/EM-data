function simple_merge_split_plot( fname, nickname, metric )

    fontsize = get(0,'DefaultAxesFontSize');
    set(0,'DefaultAxesFontSize',16);

    figure;
    hold on;
    lgnds = {};
    cur   = pwd;
    for n = 1:numel(fname)

        % load data
        try
            load(fname{n});
        catch
            continue;
        end

        thresh  = result.(metric).thresh;
        split   = result.(metric).split;
        merge   = result.(metric).merge;
        score   = result.(metric).score;

        if strcmp(metric,'Rand')
            [~,idx] = sort(split,'ascend');
            plot(split(idx),merge(idx),'-');
            xlabel([metric ' split score']);
            ylabel([metric ' merge score']);
        elseif strcmp(metric,'VI')
            [~,idx] = sort(merge,'ascend');
            plot(merge(idx),split(idx),'-');
            xlabel([metric ' merge score']);
            ylabel([metric ' split score']);
        else
            assert(false);
        end

        % legend
        lgnds{end+1} = nickname{n};
        disp([lgnds{end} ', best ' metric ' F-score = ' num2str(max(score))]);

    end
    cd(cur);
    hold off;
    grid on;
    legend(lgnds);
    xlim([0 1]);
    ylim([0 1]);
    daspect([1 1 1]);
    title([metric ' score']);

    % revert default font size
    set(0,'DefaultAxesFontSize',fontsize);

end
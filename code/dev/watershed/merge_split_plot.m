function merge_split_plot( fname )

    %% assume that we are in the right directory location.
    %
    high  = [0.999];
    low   = [0.0];
    % thold = 2.^[8:16];
    thold = [4096];
    farg  = [0.3];

    figure;
    lgnds = {};
    hold on;
        for i = 1:numel(high)
            for j = 1:numel(low)
                for k = 1:numel(thold)

                    oname = [fname '_high' num2str(high(i))];
                    oname = [oname '_low' num2str(low(j))];
                    oname = [oname '_size' num2str(thold(k))];
                    oname = [oname '_arg' num2str(farg)];
                    load([oname '.mat']);

                    rs = result.rs;
                    rm = result.rm;
                    [~,idx] = sort(rs,'ascend');

                    plot(rs(idx),rm(idx),'-');

                    lgnd = ['high=' num2str(high(i))];
                    lgnd = [lgnd ', low=' num2str(low(j))];
                    lgnd = [lgnd ', size=' num2str(thold(k))];
                    lgnds{end+1} = lgnd;
                    disp([lgnds{end} ', best Rand F-score = ' num2str(max(result.rf))]);

                end
            end
        end
    hold off;
    grid on;
    legend(lgnds);
    xlabel('Rand split score');
    ylabel('Rand merge score');
    title('Rand score');

end
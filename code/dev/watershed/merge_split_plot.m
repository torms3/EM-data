function merge_split_plot( fpath, nickname, fname, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'fpath',@(x)iscell(x));
    addRequired(p,'nickname',@(x)iscell(x));
    addRequired(p,'fname',@(x)isstr(x));
    addOptional(p,'high',0.999,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'low',0.3,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'thold',256,@(x)isnumeric(x)&&all(x>=0));
    addOptional(p,'arg',0.3,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    parse(p,fpath,nickname,fname,varargin{:});

    high  = p.Results.high;
    low   = p.Results.low;
    thold = p.Results.thold;
    arg   = p.Results.arg;

    figure;
    hold on;
    lgnds = {};
    cur   = pwd;
    for n = 1:numel(fpath)
        if ~exist(fpath{n},'dir'); continue; end;
        cd(fpath{n});
        for i = 1:numel(high)
            for j = 1:numel(low)
                for k = 1:numel(thold)
                    for l = 1:numel(arg)
                        % load data
                        oname = [fname '_high' num2str(high(i))];
                        oname = [oname '_low' num2str(low(j))];
                        oname = [oname '_size' num2str(thold(k))];
                        oname = [oname '_arg' num2str(arg(l))];
                        try
                            load([oname '.mat']);
                        catch
                            continue;
                        end

                        % sort
                        rs = result.rs;
                        rm = result.rm;
                        [~,idx] = sort(rs,'ascend');

                        % plot
                        plot(rs(idx),rm(idx),'-');

                        % legend
                        lgnd = p.Results.nickname{n};
                        lgnd = [lgnd ', high=' num2str(high(i))];
                        lgnd = [lgnd ', low=' num2str(low(j))];
                        lgnd = [lgnd ', size=' num2str(thold(k))];
                        lgnds{end+1} = lgnd;
                        disp([lgnds{end} ', best Rand F-score = ' num2str(max(result.rf))]);
                    end
                end
            end
        end
    end
    cd(cur);
    hold off;
    grid on;
    legend(lgnds);
    xlabel('Rand split score');
    ylabel('Rand merge score');
    title('Rand score');

end
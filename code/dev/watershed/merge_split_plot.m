function merge_split_plot( fpath, nickname, fname, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'fpath',@(x)iscell(x));
    addRequired(p,'nickname',@(x)iscell(x));
    addRequired(p,'fname',@(x)isstr(x));
    addOptional(p,'high',0.999,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'low',0.3,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'merge',true,@(x)islogical(x));
    addOptional(p,'thold',256,@(x)isnumeric(x)&&all(x>=0));
    addOptional(p,'arg',0.3,@(x)isnumeric(x)&&all(0<=x)&&all(x<=1));
    addOptional(p,'metric','Rand',@(x)isstr(x));
    parse(p,fpath,nickname,fname,varargin{:});

    high   = p.Results.high;
    low    = p.Results.low;
    aggl   = p.Results.merge;
    thold  = p.Results.thold;
    arg    = p.Results.arg;
    metric = p.Results.metric;

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
                        if aggl
                            oname = [oname '_size' num2str(thold(k))];
                            oname = [oname '_arg' num2str(arg(l))];
                        end
                        try
                            load([oname '.mat']);
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
                        lgnd = p.Results.nickname{n};
                        lgnd = [lgnd ', high=' num2str(high(i))];
                        lgnd = [lgnd ', low=' num2str(low(j))];
                        if aggl
                            lgnd = [lgnd ', size=' num2str(thold(k))];
                            lgnd = [lgnd ', thold=' num2str(arg(l))];
                        end
                        lgnds{end+1} = lgnd;
                        disp([lgnds{end} ', best ' metric ' F-score = ' num2str(max(score))]);
                    end
                end
            end
        end
    end
    cd(cur);
    hold off;
    grid on;
    legend(lgnds);
    title([metric ' score']);

end
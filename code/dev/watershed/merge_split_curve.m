function p = merge_split_curve( data, metric, nickname )

    if ~exist('nickname','var'); nickname = []; end;
    assert(isequal(metric,'Rand')||isequal(metric,'VI'));

    thresh = data.(metric).thresh;
    split  = data.(metric).split;
    merge  = data.(metric).merge;
    score  = data.(metric).score;

    if isequal(metric,'Rand')
        [~,idx] = sort(split,'ascend');
        p = plot(split(idx),merge(idx),'-');
        xlabel([metric ' split score']);
        ylabel([metric ' merge score']);
    elseif isequal(metric,'VI')
        [~,idx] = sort(merge,'ascend');
        p = plot(merge(idx),split(idx),'-');
        xlabel([metric ' merge score']);
        ylabel([metric ' split score']);
    else
        assert(false);
    end

    if isempty(nickname)
      disp(['Best ' metric ' F-score = ' num2str(max(score))]);
    else
      disp(['Best ' metric ' F-score = ' num2str(max(score)) ' (' nickname ')']);
    end

    grid on;
    grid minor;

end

function merge_split_curve( data, metric )

    assert(isequal(metric,'Rand')||isequal(metric,'VI'));

    thresh  = data.(metric).thresh;
    split   = data.(metric).split;
    merge   = data.(metric).merge;
    score   = data.(metric).score;

    if isequal(metric,'Rand')
        [~,idx] = sort(split,'ascend');
        plot(split(idx),merge(idx),'-');
        xlabel([metric ' split score']);
        ylabel([metric ' merge score']);
    elseif isequal(metric,'VI')
        [~,idx] = sort(merge,'ascend');
        plot(merge(idx),split(idx),'-');
        xlabel([metric ' merge score']);
        ylabel([metric ' split score']);
    else
        assert(false);
    end

    disp(['Best ' metric ' F-score = ' num2str(max(score))]);

    grid on;
    grid minor;

end
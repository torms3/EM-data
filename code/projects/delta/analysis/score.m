function [ret] = score( fname, metric, iters, subdir, do_plot )

    % Data collection.
    cur = pwd;
    data = [];
    for i = 1:numel(iters)
        iter = iters(i);
        cd([cur '/iter_' num2str(iter) '/' subdir]);
        load(fname);
        data(i) = max(result.(metric).score);
    end
    cd(cur);

    % Plot.
    if do_plot
        figure;
        plot(iters,data,'-o');
        grid on;
        xlabel('Iteration');
        ylabel('Score');
    end

    % Return.
    ret.iter = iters;
    ret.data = data;

end

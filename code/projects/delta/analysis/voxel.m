function [ret] = voxel( fname, iters, do_plot )

    % Data collection.
    cur = pwd;
    data = [];
    for i = 1:numel(iters)
        iter = iters(i);
        cd([cur '/iter_' num2str(iter)]);
        load(fname);
        data(i) = (min(result.x.err)+min(result.y.err)+min(result.z.err))./3;
    end
    cd(cur);

    % Plot.
    if do_plot
        figure;
        plot(iters,data,'-o');
        grid on;
        xlabel('Iteration');
        ylabel('Classification error');
    end

    % Return.
    ret.iter = iters;
    ret.data = data;

end

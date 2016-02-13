function plot_mean_over_depth( data )

    if ~iscell(data); data = {data}; end;

    figure;
    hold on;
        for i = 1:numel(data)
            do_plot(data{i});
        end
    hold off;
    grid on;

    xlabel('depth');
    ylabel('mean');


    function h = do_plot( stack )

        [sx,sy,sz] = size(stack);
        stack = reshape(stack,sx*sy,sz);
        h = plot(mean(stack,1));

    end

end
function compare_2D_ensemble

    nickname = {'VD2D-P4','VD2D-P3','VD2D-P2','VD2D-P1','Ensemble'};
    pixel_error = [0.0951 0.0949 0.0936 0.0931 0.0914];
    N = numel(pixel_error);

    figure;
    plot_comparison;

    function plot_comparison

        % fontsize = get(0,'DefaultAxesFontSize');
        set(0,'DefaultAxesFontSize',16);

        color = colormap(lines);

        hold on;
        for i = 1:N
            b = bar(i,pixel_error(i));
            b.BarWidth  = 0.8;
            b.FaceColor = color(i,:);
            b.LineWidth = 1.5;
            b.EdgeColor = 'k';
        end
        hold off;

        grid on;
        v = axis;
        axis([v(1) v(2) 0.080 v(4)]);
        set(gca,'XTickLabel','');
        legend(nickname,'Location','best');
        ylabel('Best pixel error');
        title('Pixel classification error');

        % revert default font size
        % set(0,'DefaultAxesFontSize',fontsize);

    end

end
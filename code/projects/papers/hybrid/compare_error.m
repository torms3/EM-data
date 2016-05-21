function compare_error

    % # pixels
    numpxl = [prod([255,255,168]),prod([512,512,170]),prod([512,512,169]),prod([256,256,121])];

    % pixel error
    %
    % pixel = [0.1066 0.0977 0.0876];
    % pixel = [0.1066 0.1063 0.0977 0.0876];
    % pixel = [0.1063 0.0977 0.0876]; % v1
    % pixel = [0.0979 0.0978 0.0892]; % v4
     pixel = [0.1063 0.0978 0.0892];

    % connected component
    %
    % conn  = [0.1621 0.1098 0.0766];
    % conn  = [0.1621 0.1390 0.1098 0.0766];
    % conn  = 1 - [0.1390 0.1098 0.0766]; % v1
    % conn  = 1 - [0.1247 0.1204 0.0772]; % v4
    conn  = 1 - [0.1390 0.1204 0.0772];


    % watershed
    %
    % ws    = [0.0749 0.0537 0.0280];
    % ws    = [0.0749 0.0696 0.0537 0.0280];
    % ws    = 1 -[0.0696 0.0537 0.0280]; % v1
    % ws    = 1 -[0.0578 0.0576 0.0324]; % v4
    ws    = 1 -[0.0696 0.0576 0.0324];

    % zshed
    %
    % ws    = 1 -[0.055 0.0425 0.0246];

    % legend
    % lgnd  = {'Base2D','N4','VD2D','VD2D3D'};
    lgnd  = {'N4','VD2D','VD2D3D'};

    errtype = {'Connected component','Watershed'};


    figure;
    plot_comparison;


    function plot_comparison

        fontsize = get(0,'DefaultAxesFontSize');
        set(0,'DefaultAxesFontSize',24);

        color = colormap(lines);

        % plot
        % subplot(1,2,2);
        % b = bar([pixel; [0 0 0]],'grouped');
        % for i = 1:3
        %     b(i).FaceColor = color(i,:);
        %     b(i).LineWidth = 3;
        %     b(i).EdgeColor = 'k';
        % end
        % v = axis;
        % axis([v(1) 1.5 0.070 v(4)]);
        % grid on;
        % grid minor;
        % % set(gca,'XTickLabel','Test set');
        % set(gca,'XTickLabel','');
        % % fix_xticklabels(gca,0.1,{'FontSize',12});
        % legend(lgnd,'Location','best');
        % ylabel('Best pixel error');
        % title('Pixel Classification Error');


        %% 2D Rand error
        %
        % plot
        % subplot(2,2,3:4);
        b = bar([conn; ws],'grouped');
        for i = 1:numel(b)
            b(i).FaceColor = color(i,:);
            b(i).LineWidth = 3;
            b(i).EdgeColor = 'k';
        end
        v = axis;
        axis([v(1) v(2) 0.8 v(4)]);
        grid on;
        grid minor;
        set(gca,'XTickLabel',errtype,'XTick',1:numel(errtype));
        fix_xticklabels(gca,0.1,{'FontSize',20});
        legend(lgnd,'Location','best');
        ylabel('Rand F-score');
        title('Best Rand F-score');


        % revert default font size
        set(0,'DefaultAxesFontSize',fontsize);

    end

end
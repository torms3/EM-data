function [data] = show_learning( cost_type, avg_winidow, start_iter, nvalid, errline )

    fontsize = get(0,'DefaultAxesFontSize');
    set(0,'DefaultAxesFontSize',12);

    %% Options
    %
    if ~exist('cost_type','var');   cost_type = 'Cost';end;
    if ~exist('avg_winidow','var');    avg_winidow = 0;end;
    if ~exist('start_iter','var');      start_iter = 0;end;
    if ~exist('nvalid','var');          nvalid = 10000;end;
    if ~exist('errline','var');        errline = false;end;

    % Load train info
    [train] = load_info('train');

    % Load test info
    [test] = load_info('test');

    % [kisuklee] TEMP
    idx = (train.iter == 0);
    train.iter(idx) = [];
    train.err(idx)  = [];
    train.cls(idx)  = [];
    idx = (test.iter == 0);
    test.iter(idx)  = [];
    test.err(idx)   = [];
    test.cls(idx)   = [];

    if strcmp(cost_type,'RMSE')
        train.err = sqrt(train.err);
        test.err  = sqrt(test.err);
    end

    % train/test checkpoint frequency ratio
    ratio = train.n/test.n;

    % smoothing
    [train] = smooth_curve(train,avg_winidow);
    if( avg_winidow > 0 )
        avgStr = [', Smoothing Window = ' num2str(avg_winidow)];
    else
        avgStr = '';
    end

    % return data
    data.train = train;
    data.test  = test;
    data.cost  = cost_type;

    begin = test.iter(1);
    idx = find(test.iter < begin + nvalid,1,'last');
    x = idx:idx:numel(test.iter);
    % x = test.iter(x);
    x = test.iter(x - floor(idx/2));

    % Plot cost
    figure;
    hold on;

        % train
        h(1) = plot(train.iter,train.err,'-k');
        lgnd{1} = 'Train';

        % test
        z = buffer(test.err,idx);
        y = mean(z,1);
        s = std(z,1);
        if mod(numel(test.err),idx)
            y(end) = [];
            s(end) = [];
        end
        h(2) = plot(x,y,'-sr');
        stderr = [s(:) s(:)];
        shadedErrorBar(x,y,stderr,{'-r','LineWidth',1.5},1,errline);
        lgnd{2} = 'Test';

        xl = xlim;
        xlim([start_iter xl(2)]);
        xlabel('Iteration');
        ylabel(cost_type);
        title(['Cost' avgStr]);
        legend(h,lgnd);

    hold off;
    grid on;

    % Plot classification error
    figure;
    hold on;

        % train
        h(1) = plot(train.iter,train.cls,'-k');
        lgnd{1} = 'Train';

        % test
        z = buffer(test.cls,idx);
        y = mean(z,1);
        s = std(z,1);
        if mod(numel(test.cls),idx)
            y(end) = [];
            s(end) = [];
        end
        h(2) = plot(x,y,'-sr');
        stderr = [s(:) s(:)];
        % shadedErrorBar(x,y,stderr,{'-r','LineWidth',1.5},1,errline);
        lgnd{2} = 'Test';

        xl = xlim;
        xlim([start_iter xl(2)]);
        xlabel('Iteration');
        ylabel('Classification error');
        title(['Classification Error' avgStr]);
        legend(h,lgnd);

    hold off;
    grid on;

    % revert default font size
  set(0,'DefaultAxesFontSize',fontsize);

end
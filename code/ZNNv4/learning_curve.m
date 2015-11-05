function learning_curve( fname, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'fname',@(x)exist(x,'file'));
    addOptional(p,'w',1,@(x)isnumeric(x)&&(x>0));
    addOptional(p,'method','moving');
    addOptional(p,'nvalid',10000,@(x)isnumeric(x)&&(x>0));
    addOptional(p,'siter',0,@(x)isnumeric(x)&&(x>=0));
    parse(p,fname,varargin{:});

    figure;
    subplot(1,2,1); plot_curve('err','Cost');
    subplot(1,2,2); plot_curve('cls','Classification error');


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function plot_curve( errtype, lbl )

        hold on;

            % train curve
            train = load_data('train');
            train = smooth_curve(train);
            h(1) = plot(train.iter,train.(errtype),'-k');

            % test curve
            test = load_data('test');
            h(2) = plot_test_curve(test,errtype);

        hold off;
        grid on;

        % plot decoration
        xl = xlim;
        xlim([p.Results.siter xl(2)]);
        legend(h,{'Train','Test'});
        xlabel('Iteration');
        ylabel(lbl);

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function h = plot_test_curve( data, errtype )

        nv = p.Results.nvalid;

        intv  = find(data.iter < data.iter(1)+nv,1,'last');
        hintv = floor(intv/2);
        niter = numel(data.iter);
        idx   = intv:intv:niter;

        [z,~] = buffer(data.(errtype),intv); % only take full frames
        x = data.iter(idx-hintv);
        y = mean(z,1);
        s = std(z,1);

        h = plot(x,y,'-sr');
        stderr = [s(:) s(:)];
        shadedErrorBar(x,y,stderr,{'-r','LineWidth',1.5},1);

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function data = load_data( phase )

        assert(strcmp(phase,'train')||strcmp(phase,'test'));

        data.iter = hdf5read(fname,['/' phase '/it']);  % iterations
        data.err  = hdf5read(fname,['/' phase '/err']); % cost
        data.cls  = hdf5read(fname,['/' phase '/cls']); % classification error

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function data = smooth_curve( data )

        w = p.Results.w;
        m = p.Results.method;

        if w > 0
            filtered    = smooth(data.err,w,m);
            data.stderr = sqrt(smooth(data.err.^2,w,m) - filtered.^2);
            data.err    = filtered;
            filtered    = smooth(data.cls,w,m);
            data.stdcls = sqrt(smooth(data.cls.^2,w,m) - filtered.^2);
            data.cls    = filtered;

            % cutting leading and trailing edges
            if strcmp(m,'moving')
                hw  = floor(w/2);
                n   = numel(data.iter);
                idx = [1:hw n-hw+1:n];

                data.iter(idx)   = [];
                data.stderr(idx) = [];
                data.err(idx)    = [];
                data.stdcls(idx) = [];
                data.cls(idx)    = [];
            end
        end

    end

end
function ret = learning_curve( fname, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'fname',@(x)exist(x,'file'));
    addOptional(p,'w',1,@(x)isnumeric(x)&&(x>0));
    addOptional(p,'method','moving');
    addOptional(p,'nvalid',10000,@(x)isnumeric(x)&&(x>0));
    addOptional(p,'siter',0,@(x)isnumeric(x)&&(x>=0));
    addOptional(p,'eiter',0,@(x)isnumeric(x)&&(x>=0));
    addOptional(p,'title',[],@(x)isempty(x)||isstr(x));
    addOptional(p,'vline',[],@(x)isempty(x)||isnumeric(x));
    addOptional(p,'ucost',false,@(x)islogical(x));
    parse(p,fname,varargin{:});

    if p.Results.ucost
        cost_type = 'ucost';
    else
        cost_type = 'err';
    end

    figure;
    h(1) = subplot(1,2,1); plot_curve('err','Cost');
    h(2) = subplot(1,2,2); plot_curve('cls','Classification error');

    if ~isempty(p.Results.title)
        suptitle(p.Results.title);
    end

    % return
    ret.params = p.Results;
    ret.h = h;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function plot_curve( errtype, lbl )

        hold on;

            % test curve
            test = load_data(fname,'test',cost_type);
            h(2) = plot_test_curve(test,errtype);

            % train curve
            train = load_data(fname,'train',cost_type);
            eiter = train.iter(end); % before smoothing
            train = smooth_curve(train,p.Results.w);
            h(1)  = plot(train.iter,train.(errtype),'-k');

        hold off;
        grid on;

        if p.Results.eiter > 0
            eiter = p.Results.eiter;
        end

        % plot decoration
        xlim([p.Results.siter eiter]);
        legend(h,{'Train','Test'});
        xlabel('Iteration');
        ylabel(lbl);

        % vertical line, if any
        vline = p.Results.vline;
        if ~isempty(vline)
            yl = ylim;
            line([vline vline],yl,'Color',[1 1 0]); % currently yellow
            ylim(yl);
        end

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function h = plot_test_curve( data, errtype )

        nv    = p.Results.nvalid;
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
        if length(x)==length(stderr)
            shadedErrorBar(x,y,stderr,{'-r','LineWidth',1.5},1);
        end

    end

end
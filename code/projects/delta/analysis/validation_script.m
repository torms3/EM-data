function validation_script( fpath, prefix, sample, iters, option, varargin )

    % Load ground truth.
    switch prefix
        case 'SNEMI3D'
            data = load_SNEMI3D_dataset(sample, false);
            data1 = load_SNEMI3D_dataset(sample, true);
        otherwise
            assert(false);
    end
    template = [prefix '_dataset%d_output'];

    cur = pwd;
    for i = 1:numel(fpath)
        cd(fpath{i});
        root = pwd;
        for i = 1:numel(iters)
            iter = iters(i);
            cd([root '/iter_' num2str(iter)]);
            measure;
        end
    end
    cd(cur);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function measure

        % Classification error.
        if option(1)
            for j = 1:numel(sample)
                fname = {sprintf(template,sample(j))};
                affinity_graph_script(fname,data1(j));
            end
        end
        % Rand score.
        if option(2)
            prepare;
            Rand_score({pwd},template,sample,data,varargin{:});
        end
        % VI Score.
        if option(3)
            prepare;
            VI_score({pwd},template,sample,data,varargin{:});
        end
        % Mean affinity.
        if option(4)
            prepare;
            mean_affinity_script({pwd},template,sample,data,varargin{:});
        end

    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function prepare

        for j = 1:numel(sample)
            oname = sprintf(template,sample(j));
            if exist([oname '.affin'],'file') ~= 2
                aff = hdf5read([oname '.h5'],'/main');
                export_tensor(oname,aff,'affin','single');
            end
            if exist([oname '.uaffin'],'file') ~= 2
                affs2uniform_script({pwd}, template, sample(j));
            end
        end

    end

end

function validation_script( fpath, prefix, sample, iters, option )

    % DEBUG
    option = [1 0 0 0];

    % Load ground truth.
    switch prefix
        case 'SNEMI3D'
            data1 = load_SNEMI3D_dataset(sample, true);
            data2 = load_SNEMI3D_dataset(sample, false);
        otherwise
            assert(false);
    end

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
            fname = {};
            for i = 1:numel(sample)
                fname{i} = [prefix '_dataset' num2str(sample(i)) '_output'];
            end
            affinity_graph_script(fname,data1);
        end
        % Rand score.
        if option(2)
        end
        % VI Score.
        if option(3)
        end
        % Mean affinity.
        if option(4)
        end

    end

end

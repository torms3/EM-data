function fmaps2tif_script( net_type, fpath )

    if ~exist('net_type','var'); net_type = '2D';end;
    if ~exist('fpath','var');        fpath = pwd;end;
    cd(fpath);

    keys = {'INPUT','C1','C2','C3','FC','OUTPUT'};
    switch net_type
    case '2D'
        z = [1 1 1 1 1 1];
        layer = containers.Map(keys,z);
    case '3D'
        z = [2 2 2 2 1 1];
        layer = containers.Map(keys,z);
    case '2D-R'
        z = [1 1 1 1 1 1];
        layer = containers.Map(keys,z);
        layer('INPUT2') = 1;
    case '3D-R'
        z = [2 2 2 2 1 1];
        layer = containers.Map(keys,z);
        layer('INPUT2') = 2;
    otherwise
        assert(false);
    end

    list = dir('out*');
    for i = 1:numel(list)

        fname = list(i).name;
        if any(findstr(fname,'size'))
            continue;
        end

        idx = findstr(fname,'.');
        z = layer(fname(idx+1:end));
        % disp([fname(idx+1:end) ' = ' num2str(z)]);
        fmaps2tif(fname,[],z);

    end

end
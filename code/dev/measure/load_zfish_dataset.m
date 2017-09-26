function data = load_zfish_dataset( idx )

    if ~exist('idx','var'); idx = [];   end;
    if isempty(idx);        idx = 1:7; end;

    cur = pwd;
    cd('~/Data_local/datasets/Zfish/original');

    imgs{1} = 'r1.daan.img.h5';
    lbls{1} = 'r1.daan.lbl.h5';

    imgs{2} = 'r1.kyle.img.h5';
    lbls{2} = 'r1.kyle.lbl.h5';

    imgs{3} = 'new/r1.merlin.1.img.h5';
    lbls{3} = 'new/r1.merlin.1.lbl.h5';

    imgs{4} = 'r2.kyle.img.h5';
    lbls{4} = 'r2.kyle.lbl.h5';

    imgs{5} = 'r2.merlin.img.h5';
    lbls{5} = 'r2.merlin.lbl.h5';

    imgs{6} = 'r2.selden.img.h5';
    lbls{6} = 'r2.selden.lbl.h5';

    imgs{7} = 'new/r1.merlin.2.img.h5';
    lbls{7} = 'new/r1.merlin.2.lbl.h5';

    for i = 1:numel(idx)
        n = idx(i);
        disp(['load stack' num2str(n) '...']);
        data{i}.image = hdf5read(imgs{n},'/main');
        data{i}.label = hdf5read(lbls{n},'/main');
    end

    cd(cur);

end

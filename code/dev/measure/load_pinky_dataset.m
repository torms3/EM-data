function data = load_pinky_dataset( idx )

    if ~exist('idx','var'); idx = [];   end;
    if isempty(idx);        idx = 1:10; end;

    cur = pwd;
    cd('~/Data_local/datasets/pinky/ground_truth');

    map = [19,20,21,22,23,24,27,29,31,33];

    for i = 1:numel(idx)
        n = map(idx(i));
        disp(['load stack' num2str(n) '...']);
        cd(['vol' num2str(n)]);
        data{i}.image = hdf5read('chann.h5','/main');
        data{i}.label = hdf5read('seg.h5','/main');
    end

    cd(cur);

end

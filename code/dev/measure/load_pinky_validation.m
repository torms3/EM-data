function data = load_pinky_dataset()

    cur = pwd;
    cd('~/Data_local/pinky/net_comparison/validation');

    data{1}.label = hdf5read('seg_bordered.h5','/main');

    cd(cur);

end

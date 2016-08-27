function data = load_zfish_validation()

  data = {};
  cur = pwd;
  cd('~/Data_local/zfish/blend_test/validation/');
  disp(['load ground truth...']);
  fname = 'zfish_chunk_33405_8905_229.omni.seg.ben.h5';
  data{1}.label = hdf5read(fname,'/main');
  cd(cur);

end

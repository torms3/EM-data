function data = load_zfish_validation(idx)
  
  if ~exist('idx','var'); idx = 1:3; end;

  data = {};
  cur = pwd;
  cd('~/Data_local/zfish/blend_test/validation/');
  disp(['load ground truth...']);
  fname{1} = 'bordered_label.h5';
  fname{2} = 'W3_label1.h5';
  fname{3} = 'W3_label2.h5';
  for i = 1:numel(idx)
    data{i}.label = hdf5read(fname{idx(i)},'/main');
  end
  cd(cur);

end

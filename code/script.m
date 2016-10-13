for i = 1:numel(fpath)

  cd(fpath{i});

  % Prep.
  %template = 'zfish_dataset%d_output';
  %template = 'pinky_dataset%d_output';
  template = 'SNEMI3D_dataset%d_output';
  if true
  %if false
    for j = 1:numel(sample)
      oname = sprintf(template,sample(j));
      aff = hdf5read([oname '.h5'],'/main');
      export_tensor(oname,aff,'affin','single');
      affs2uniform_script({pwd}, template, sample(j));
    end
  end

  % Quantify.
  Rand_score({pwd},template,sample,'high',0.9,'low',0.01,'thold',800,'lowt',600,'arg',0.2,'remap',true,'overwrite',true);
  VI_score({pwd},template,sample,'high',0.9,'low',0.01,'thold',800,'lowt',600,'arg',0.2,'remap',true,'overwrite',true);
  mean_affinity_script({pwd}, template, sample, true);

end

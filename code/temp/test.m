function test( fname, dim, th )

    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/');
    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/hdf5/');
    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/util/');

    path_xxlws_exe='/omelette/omic.home/zlateski/quta/xxlws';

    %dim = 224;
    if( ~exist('th','var') )
        th = 999;
    end

    %xxl_watershed_prepare_dired_hdf5(['test_aff_' num2str(dim) '.h5'],'wstemp',dim);
    xxl_watershed_prepare_dired_hdf5(fname,'wstemp',dim);

    sysline =[path_xxlws_exe ' --filename wstemp --high 0.' num2str(th) ' --dust 100 --dust_low 0.30 --low 0.3'];
    system(sysline);

    global seg
    [dend, dendValues]=xxl_watershed_read_global('wstemp',[dim dim dim],dim);


    hdf5write(['ws_' fname],'/main',seg,'/dend',uint32(dend),'/dendValues',single(dendValues));

end
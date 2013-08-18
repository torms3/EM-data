function [] = generate_hdf5_for_omnification( fname, dim, th )

	%% Argument validations
	%
	if( ~exist('th','var') )
        th = 999;
    end


    %% Temporary dir for temporary files
    %
    [dpath] = get_project_data_path();
    mkdir(dpath,'temp');
    temp_path = [dpath '/temp'];


    %% Preparation
    %    
    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/');
    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/hdf5/');
    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/util/');
    xxlws = '/omelette/omic.home/zlateski/quta/xxlws';

    
    %% Watershed
    %
    wstemp = [temp_path '/wstemp'];
    xxl_watershed_prepare_dired_hdf5( fname, wstemp, dim );
    sysline = [xxlws ' --filename ' wstemp ' --high 0.' num2str(th) ' --dust 100 --dust_low 0.30 --low 0.3'];
    system(sysline);

    global seg
    [dend,dendValues] = xxl_watershed_read_global( wstemp, [dim dim dim], dim );

    hdf5write(fname,'/main',seg,'/dend',uint32(dend),'/dendValues',single(dendValues));


    %% Rmove temporary dir
    %
    system(['rm -rf ' temp_path]);

end
function [] = create_hdf5_for_omnification( fname, segm, chann, thold )

	%% Argument validations
	%
	if( ~exist('thold','var') )
        thold = 999;
    end


    %% Temporary dir for temporary files
    %
    [dpath] = get_project_data_path();
    mkdir(dpath,'temp');
    temp_path = [dpath '/temp'];


    %% Path
    %    
    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/');
    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/hdf5/');
    addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/util/');
    xxlws = '/omelette/omic.home/zlateski/quta/xxlws';


    %% Raw hdf5
    %
    generate_hdf5_segment_channel( segm, chann, fname );
    dim = size(chann);

    
    %% Watershed
    %    
    wstemp = [temp_path '/wstemp'];
    segmHDF5 = [fname '.segm.h5'];
    xxl_watershed_prepare_dired_hdf5( segmHDF5, wstemp, min(dim) );
    sysline = [xxlws ' --filename ' wstemp ' --high 0.' num2str(thold) ...
                     ' --dust 100 --dust_low 0.30 --low 0.3'];
    system(sysline);

    global seg
    [dend,dendValues] = xxl_watershed_read_global( wstemp, dim, min(dim) );

    hdf5write(segmHDF5,'/main',seg,'/dend',uint32(dend),'/dendValues',single(dendValues));


    %% Rmove temporary dir
    %
    system(['rm -rf ' temp_path]);

end
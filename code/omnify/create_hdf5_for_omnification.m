function [] = create_hdf5_for_omnification( fname, segm, params, chann )

	%% Argument validations
	%
    assert(exist('fname','var')~=0);    
    assert(exist('segm','var')~=0);
    if ~exist('params','var')
        params.Th = 999;
        params.Tl = 200;
        params.Ts = 100;
        params.Te = 100;
    end
	if( ~exist('chann','var') )
        chann = [];
    end


    %% Augment the file name with threshold value
    %
    [fname] = watershed_fname( fname, params );


    %% Temporary dir for temporary files
    %
    [dpath] = get_project_data_path();
    mkdir(dpath,'temp');
    temp_path = [dpath '/temp'];


    %% Path
    %    
    % addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/');
    % addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/hdf5/');
    % addpath('/omelette/omic.home/zlateski/zcode/ziKode/trunk/matlab/util/');
    % xxlws = '/omelette/omic.home/zlateski/quta/xxlws';
    addpath('/omicfs/home/zlateski/zcode/ziKode/trunk/matlab/');
    addpath('/omicfs/home/zlateski/zcode/ziKode/trunk/matlab/hdf5/');
    addpath('/omicfs/home/zlateski/zcode/ziKode/trunk/matlab/util/');
    xxlws = '/omicfs/home/zlateski/quta/xxlws';


    %% Raw hdf5
    %
    generate_hdf5_segment_channel( fname, segm, chann );
    dim = size(segm(:,:,:,1));

    
    %% Watershed
    %    
    wstemp = [temp_path '/wstemp'];
    segmHDF5 = [fname '.segm.h5'];
    xxl_watershed_prepare_dired_hdf5( segmHDF5, wstemp, min(dim) );
    sysline = [xxlws ' --filename ' wstemp ...
                     ' --high 0.' num2str(params.Th) ...
                     ' --dust ' num2str(params.Ts) ...
                     ' --dust_low 0.' num2str(params.Te) ...
                     ' --low 0.' num2str(params.Tl)];
                     
    system(sysline);

    global seg
    [dend,dendValues] = xxl_watershed_read_global( wstemp, dim, min(dim) );

    hdf5write(segmHDF5,'/main',seg,'/dend',uint32(dend),'/dendValues',single(dendValues));


    %% Rmove temporary dir
    %
    system(['rm -rf ' temp_path]);

end
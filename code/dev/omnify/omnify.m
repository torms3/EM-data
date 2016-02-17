function omnify( fname, chann, varargin )

    % input parsing & validation
    p = inputParser;
    addRequired(p,'fname',@(x)isstr(x));
    addRequired(p,'chann');
    addOptional(p,'high',0.999,@(x)isnumeric(x)&&(0<=x)&&(x<=1));
    addOptional(p,'low',0.3,@(x)isnumeric(x)&&(0<=x)&&(x<=1));
    addOptional(p,'thold',256,@(x)isnumeric(x)&&(x>=0));
    addOptional(p,'arg',0.3,@(x)isnumeric(x)&&(0<=x)&&(x<=1));
    parse(p,fname,chann,varargin{:});

    % temporary working directory
    cur_dir  = pwd;
    temp_dir = 'omnify_temp';
    mkdir(temp_dir);

    % project name
    oname = [fname '_high' num2str(p.Results.high) ];
    oname = [oname '_low'  num2str(p.Results.low)  ];
    oname = [oname '_size' num2str(p.Results.thold)];
    oname = [oname '_arg'  num2str(p.Results.arg)  ];

    % segmentation
    seg   = import_volume(oname, size(chann), 'segment', 'uint32');
    mtree = load_merge_tree(oname);
    disp('seg.h5...');
    hdf5write([temp_dir '/seg.h5'],'/main',uint32(seg), ...
                                   '/dend',uint32(reshape(mtree.pairs,2,[]))', ...
                                   '/dendValues',single(mtree.vals)');

    % channel
    disp('chann.h5...');
    chann = scaledata(double(chann),0,1);
    hdf5write([temp_dir '/chann.h5'],'/main',single(chann));

    % omnify command file
    fid = fopen([temp_dir '/omnify.cmd'],'w');
    assert(fid~=-1);
    fprintf(fid,'create:%s/%s.omni\n',cur_dir,oname);
    fprintf(fid,'loadHDF5chann:%s/%s/chann.h5\n',cur_dir,temp_dir);
    fprintf(fid,'loadHDF5seg:%s/%s/seg.h5\n',cur_dir,temp_dir);
    fprintf(fid,'mesh\n');
    fprintf(fid,'quit\n\n');
    fclose(fid);

    % omnify
    % bin = '/usr/people/kisuk/seungmount/Omni/omni/omni';
    % sysline = [bin ' --headless --cmdfile=' cur_dir '/' temp_dir '/omnify.cmd'];
    % [~,cmdout] = system(sysline);
    % disp(cmdout);

    % clean up temporary working directory
    % rmdir(temp_dir,'s');

end
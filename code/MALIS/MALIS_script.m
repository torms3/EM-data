function MALIS_script( psz, xy )

    % params
    bname = 'boundary_map.bin';
    lname = 'label_fill_hole.bin';
    fsz   = 504;
    high  = 1;
    low   = 0;

    % argument validation
    if ~exist('psz','var'); psz = 100; end;
    if ~exist('xy','var');    xy = []; end;

    % patch
    base  = '/usr/people/kisuk/Workbench/znn-release/experiments/malis_2d/';
    cd([base 'data']);
        pwd

        if isempty(xy)
            bmap  = import_volume(bname,[fsz fsz 1]);
            lbl   = import_volume(lname,[fsz fsz 1]);
            [xy(1),xy(2)] = export_random_patch( bmap, lbl, psz, pwd );
        end

        subdir = sprintf('/patch_%dx%d/',psz,psz);
        bpname = [pwd subdir sprintf('x%d_y%d_bmap.bin',xy)];
        lpname = [pwd subdir sprintf('x%d_y%d_lbl.bin',xy)];

    cd(base);
    oname = [base 'out'];

    % run znn-malis
    malis = '/usr/people/kisuk/Workbench/znn-release/bin/debug';
    temp = generate_option;
    sysargs = sprintf(' --options=%s --type=malis_2d --high=%f --low=%f', ...
                      temp,high,low);
    system([malis sysargs]);
    system(['rm ' temp]);

    % visualize
    visualize_MALIS( bpname, lpname, oname );


    function temp = generate_option

        temp = 'temp.config';
        fid  = fopen(temp,'w');

        fprintf(fid,'[PATH]\n');
        fprintf(fid,'load=%s\n',bpname);
        fprintf(fid,'data=%s\n',lpname);
        fprintf(fid,'save=%s\n',oname);
        fprintf(fid,'\n');
        fprintf(fid,'[TRAIN]\n');
        fprintf(fid,'outsz=%d,%d,1',psz,psz);

        fclose(fid);

    end

end
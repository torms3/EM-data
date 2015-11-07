function MALIS_script_v4( psz, is_debug, timestamp, xy )

    % params
    bname       = 'boundary_map.bin';
    lname       = 'label_fill_hole.bin';
    fsz         = 504;
    high        = 1;
    low         = 0;
    phase       = 'BOTH';
    constrain   = 0;

    % argument validation
    if ~exist('psz','var');       psz = 100;         end;
    if ~exist('is_debug','var');  is_debug = true;   end;
    if ~exist('timestamp','var'); timestamp = false; end;
    if ~exist('xy','var');        xy = [];           end;

    % patch
    base  = '/usr/people/kisuk/Workbench/znn-release/experiments/malis_2d/';
    cd([base 'data']);

        if isempty(xy)
            bmap  = import_volume(bname,[fsz fsz 1]);
            lbl   = import_volume(lname,[fsz fsz 1]);
            [xy(1),xy(2)] = export_random_patch( bmap, lbl, psz, pwd );
            fprintf('\n%dx%d patch at (x,y) = (%d,%d) has been extracted!\n', ...
                    [psz psz xy]);
        end

        subdir = sprintf('/patch_%dx%d/',psz,psz);
        bpname = [pwd subdir sprintf('x%d_y%d_bmap.bin',xy)];
        lpname = [pwd subdir sprintf('x%d_y%d_lbl.bin',xy)];

    cd(base);
    oname = [base 'out'];

    % run ZNNv4 malis
    if is_debug
        malis = '/usr/people/kisuk/Workbench/seung-lab/znn-release/bin/malis_debug';
    else
        malis = '/usr/people/kisuk/Workbench/seung-lab/znn-release/bin/malis';
    end
    temp = generate_option;
    system([malis ' ' pwd '/' temp]);
    system(['rm ' temp]);

    % visualize
    if is_debug
        visualize_MALIS_debug( lpname, oname, timestamp );
    else
        visualize_MALIS( lpname, oname );
    end


    function temp = generate_option

        temp = 'temp.config';
        fid  = fopen(temp,'w');

        fprintf(fid,'size %d,%d,%d\n',1,psz,psz);
        fprintf(fid,'bmap %s\n',bpname);
        fprintf(fid,'lbl %s\n',lpname);
        fprintf(fid,'out %s\n',oname);
        fprintf(fid,'high %f\n',high);
        fprintf(fid,'low %f\n',low);
        fprintf(fid,'phase %s\n',phase);
        fprintf(fid,'constrain %d\n',constrain);
        fprintf(fid,'debug_print 0\n');

        fclose(fid);

    end

end
function MALIS_script_v4( psz, is_debug, timestamp, xy, z )

    % params
    bname       = 'boundary_map.tif';
    lname       = 'label.tif';
    fsz         = 512;
    high        = 1;
    low         = 0.7;
    phase       = 'MERGER';
    constrain   = 1;
    frac_norm   = 1;

    % argument validation
    if ~exist('psz','var');       psz = 100;         end;
    if ~exist('is_debug','var');  is_debug = true;   end;
    if ~exist('timestamp','var'); timestamp = false; end;
    if ~exist('xy','var');        xy = [];           end;

    % patch
    base  = '/usr/people/kisuk/Workbench/seung-lab/znn-release/test/malis/';
    cd([base 'data/Piriform/']);

        if isempty(xy)
            % bmap  = import_volume(bname,[fsz fsz 1]);
            % lbl   = import_volume(lname,[fsz fsz 1]);
            bmap = loadtiff(bname);
            lbl  = loadtiff(lname);

            if ~exist('z','var');z = randi(size(bmap,3));end;
            bmap = bmap(:,:,z);
            lbl  = lbl(:,:,z);

            [xy(1),xy(2)] = export_random_patch( bmap, lbl, psz, pwd, z );
            fprintf('\n%dx%d patch at (x,y,z) = (%d,%d,%d) has been extracted!\n', ...
                    [psz psz xy z]);
        end

        subdir = sprintf('/patch_%dx%d/',psz,psz);
        xpname = [pwd subdir sprintf('x%d_y%d_z%d_xaff.bin',[xy z])];
        ypname = [pwd subdir sprintf('x%d_y%d_z%d_yaff.bin',[xy z])];
        zpname = [pwd subdir sprintf('x%d_y%d_z%d_zaff.bin',[xy z])];
        lpname = [pwd subdir sprintf('x%d_y%d_z%d_lbl.bin', [xy z])];

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
        fprintf(fid,'xaff %s\n',xpname);
        fprintf(fid,'yaff %s\n',ypname);
        fprintf(fid,'zaff %s\n',zpname);
        fprintf(fid,'lbl %s\n',lpname);
        fprintf(fid,'out %s\n',oname);
        fprintf(fid,'high %f\n',high);
        fprintf(fid,'low %f\n',low);
        fprintf(fid,'phase %s\n',phase);
        fprintf(fid,'constrain %d\n',constrain);
        fprintf(fid,'frac_norm %d\n',frac_norm);
        fprintf(fid,'debug_print 0\n');

        fclose(fid);

    end

end

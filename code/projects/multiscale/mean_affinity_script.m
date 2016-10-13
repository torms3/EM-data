function mean_affinity_script( fpath, template, samples, remap, is_2D )

    if ~iscell(fpath); fpath = {fpath};      end;
    if ~exist('remap','var'); remap = false; end;
    if ~exist('is_2D','var'); is_2D = false; end;

    %data = load_Piriform_dataset(samples); % piriform dataset.
    %data = load_zfish_validation(); % zfish blend test.    
    %data = load_zfish_dataset(samples); % zfish dataset.
    %data = load_pinky_dataset(samples); % pinky dataset.
    %data = load_pinky_validation();  % pinky validation.
    data = load_SNEMI3D_dataset(samples,false);  % SNEMI3D dataset.

    %idx = samples == 2;
    %if any(idx)
    %    disp('Correcting Piriform sample2 label...');
    %    affs = make_affinity(data{idx}.label);
    %    seg  = get_segmentation(affs(:,:,:,1),affs(:,:,:,2),affs(:,:,:,3));
    %    data{idx}.label = seg;
    %end

    % Convert 3D segmentation to 2D one.
    if is_2D
        for idx = 1:numel(data)
            affs = make_affinity(data{idx}.label);
            zaff = zeros(size(affs(:,:,:,3)));
            seg  = get_segmentation(affs(:,:,:,1),affs(:,:,:,2),zaff);
            data{idx}.label = seg;
        end
    end

    for i = 1:numel(fpath)
        cd(fpath{i});

        for j = 1:numel(samples)
            sample = samples(j);
            if remap
                iname = [pwd '/' sprintf(template,sample) '_u.h5'];
            else
                iname = [pwd '/' sprintf(template,sample) '.h5'];
            end
            oname = [pwd '/' sprintf(template,sample) '_mean_affinity'];
            if exist([oname '.h5'], 'file') ~= 2
                disp(['mean affinity agglomeration: ' oname '.h5']);
                mean_affinity_agglomeration(iname, [oname '.h5']);
            end
            [seg,mt]    = load_segmentation(oname);
            result.Rand = optimize_Rand_score(seg, data{j}.label, mt);
            result.VI   = optimize_VI_score(seg, data{j}.label, mt);

            % if exist, update
            update_result([oname '.mat'], result);
        end
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function update_result( fname, update )

    if exist(fname,'file')
        load(fname);
        fields = fieldnames(update);
        for i = 1:numel(fields)
            field = fields{i};
            result.(field) = update.(field);
        end
    else
        result = update;
    end

    save(fname,'result');

end

function focused_annotation_script( fpath, msk_id, bdr_id, k )

    if ~exist('k','var'); k = 10; end;

    cur = pwd;
    cd(fpath);

    % Load volumes.
    disp('Load img.h5...');
    tic;img = hdf5read('img.h5','/main');toc
    disp('Load seg.h5...');
    tic;seg = hdf5read('focused_cell_segmentation/seg.h5','/main');toc

    % Extract patches.
    mkdir('focused');
    cd('focused');
    [patches] = extract_focused_patch(img,seg,msk_id,bdr_id);

    % Postprocess patches.
    postprocess_focused_patch(patches, k);

end

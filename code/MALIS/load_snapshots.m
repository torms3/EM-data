function ret = load_snapshots( fname )

    ret.snapshots = import_tensor([fname '.snapshots']);
    ret.timestamp = import_tensor([fname '.timestamp']);

    fsnaptime = fopen([fname '.snapshots_time'], 'r');
    snaptime  = zeros(size(ret.snapshots,4), 1);
    snaptime  = fread(fsnaptime, size(snaptime), 'double');
    fclose(fsnaptime);

    ret.snaptime = snaptime;

end
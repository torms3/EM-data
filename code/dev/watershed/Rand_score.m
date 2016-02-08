% watershed parameters
args.iname = '/path/to/affinity/graph';
args.oname = '/path/to/output';
args.isize = [x y z];
args.lowv  = 0.3;
args.highv = 0.999;
args.lowt  = 256;
args.thold = 256;

% watershed
run_watershed(args);

% load segmentation
seg = import_volume(fname, args.isize, 'segment', 'uint32');

% load merge tree
mt = load_merge_tree(fname);

%
ret = optimize_Rand_score(seg, gt_seg, mt);
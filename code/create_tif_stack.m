function [ret] = create_tif_stack( fpath )

	if ~strcmp(fpath(end),'/')
		fpath(end+1) = '/';
	end

	% .png or .tif file list
	flist = dir([fpath '*.png']);
	if isempty(flist)
		flist = dir([fpath '*.tif']);
	end

	% sort
	names = extractfield(flist,'name');
	names = sort(names);

	ret = [];
	for i = 1:numel(flist)
		disp(names{i});
		ret(:,:,i) = imread([fpath names{i}]);
	end

end
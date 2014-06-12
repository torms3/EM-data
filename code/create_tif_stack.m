function [ret] = create_tif_stack( fpath )

	if ~strcmp(fpath(end),'/')
		fpath(end+1) = '/';
	end

	% .png or .tif file list
	listing = dir([fpath '*.png']);
	if isempty(listing)
		listing = dir([fpath '*.tif']);
	end

	% sort
	names = extractfield(listing,'name');
	names = sort(names);

	ret = [];
	for i = 1:numel(listing)
		disp(names{i});
		ret(:,:,i) = imread([fpath names{i}]);
	end

end
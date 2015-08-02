function [ret] = create_tif_stack( fpath, match )

	if ~strcmp(fpath(end),'/')
		fpath(end+1) = '/';
	end

	% section list
	if exist('match','var')
		flist = dir([fpath match]);
	else
		flist = dir([fpath '*.png']);
		if isempty(flist)
			flist = dir([fpath '*.tif']);
		end
	end

	% sort
	names = extractfield(flist,'name');
	names = sort(names);

	% create stack
	ret = [];	
	for i = 1:numel(flist)
		fname = names{i};
		disp(fname);
		if strcmp(fname(end-2:end),'tif')
			section = loadtiff([fpath fname]);
		else
			section = imread([fpath fname]);
		end		
		ret = cat(4,ret,section);
	end
	ret = squeeze(ret);

end
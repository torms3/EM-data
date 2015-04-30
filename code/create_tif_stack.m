function [ret] = create_tif_stack( fpath, rgb )

	if ~strcmp(fpath(end),'/')
		fpath(end+1) = '/';
	end

	if ~exist('rgb','var')
		rgb = false;
	end

	% .png or .tif file list
	flist = dir([fpath '*.png']);
	if isempty(flist)
		flist = dir([fpath '*.tif']);
	end

	% sort
	names = extractfield(flist,'name');
	names = sort(names);

	if rgb
		ret = process_rgb_stack();
	else
		ret = [];
		for i = 1:numel(flist)
			disp(names{i});
			ret(:,:,i) = imread([fpath names{i}]);
		end
	end


	function ret = process_rgb_stack()

		rgb_stack = [];
		for i = 1:numel(flist)
			disp(names{i});
			rgb_stack(:,:,i,:) = imread([fpath names{i}]);
		end

		dim = size(rgb_stack);
		stack = reshape(rgb_stack,dim(1)*dim(2)*dim(3),dim(4));
		[C,ia,ic] = unique(stack,'rows');
		ret = reshape(ic-1,dim(1),dim(2),dim(3));

	end

end
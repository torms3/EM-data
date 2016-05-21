function [vol] = import_volume( fname, dim, ext, dtype )
%
% Import 3D volume from file
%
% Usage:
% 	import_volume( fname )
% 	import_volume( fname, [x y z] )
% 	import_volume( fname, [], ext )
% 	import_volume( fname, [x y z], ext )
%
% 	fname:	file name
% 	dim:	3D volume dimension
% 			if not exists, read information from [fname.size]
%	ext: 	if exists, file name becomes [fname.ext]
%
% Return:
%	vol		3D volume
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>, 2014

	if ~exist('dim','var'); 		  dim = []; end;
	if ~exist('dtype','var'); dtype = 'double'; end;

	% volume dimension
	if isempty(dim)
		dim = import_size(fname,3);
	end
	assert(numel(dim) == 3);
	fprintf('dim = [%d %d %d]\n',dim);

	% volume
	if exist('ext','var')
		fvol = fopen([fname '.' ext], 'r');
	else
		fvol = fopen(fname, 'r');
	end
	if fvol < 0
		vol = [];
		return;
	end

	vol = zeros(prod(dim), 1);
	vol = fread(fvol, size(vol), dtype);
	vol = reshape(vol, dim);

end
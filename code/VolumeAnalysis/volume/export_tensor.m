function [] = export_tensor( fname, tensor, ext, dtype )
%
% Export 4D tensor in binary format
%
% Usage:
% 	export_tensor( fname, tensor )
% 	export_tensor( fname, tensor, ext )
%
% 	fname:	file name
% 	tensor:	4D tensor
%	ext: 	if exists, file name becomes [fname.ext]
%
% Results:
%	[fname]	or [fname.ext]	4D tensor in binary format
%	[fname.size]	4D tensor dimension in binary format
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>, 2014

	if ~exist('ext','var'); 		  ext = []; end;
	if ~exist('dtype','var'); dtype = 'double'; end;

	% tensor dimension
	fsz = fopen([fname '.size'], 'w');
	sz  = size(tensor);
	switch ndims(tensor)
	case 2; sz = [sz 1 1];
	case 3; sz = [sz 1];
	end
	fwrite(fsz, uint32(sz), 'uint32');

	% tensor
	if isempty(ext)
		fvol = fopen(fname, 'w');
	else
		fvol = fopen([fname '.' ext], 'w');
	end
	switch dtype
	case 'double'
		fwrite(fvol, double(tensor), 'double');
	case 'single'
		fwrite(fvol, single(tensor), 'single');
	otherwise
		assert(false);
	end

end
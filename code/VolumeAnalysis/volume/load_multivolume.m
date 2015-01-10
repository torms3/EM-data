function [mvol] = load_multivolume( fname, nvol, dim )
% 
% Load a series of 3D volumes from files
% 
% Usage:
% 	load_multivolume( fname, 3 )
% 	load_multivolume( fname, 3, [255 255 168] )
% 	
% 	fname:	file name
% 	nvol:	number of volumes in the volume series
% 	dim:	3D volume dimension
% 			if not exists, read information from [fname.size]
%
% Return:
%	mvol	multiple 3D volumes
%
% Program written by:
% Kisuk Lee <kiskulee@mit.edu>, 2015
	
	if ~exist('dim','var')
		dim = [];
	end

	mvol = {};
	for i = 1:nvol

		volname = [fname '.' num2str(i-1)];
		if exist('dim','var')
			mvol{i} = import_volume(volname, dim);
		else
			mvol{i} = import_volume(volname);
		end

	end

end
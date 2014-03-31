function [img] = revert_image( img, config )

	if( rem(config,2) == 0 )
		transpose = false;
		flipdim_idx = config;
	else
		transpose = true;
		flipdim_idx = config - 1;
	end

	% flipdim_idx
	% 	0 = 000 -> x:0 y:0 z:0
	% 	2 = 010 -> x:0 y:1 z:0
	% 	4 = 100 -> x:1 y:0 z:0
	% 	6 = 110 -> x:1 y:1 z:0	
	switch( flipdim_idx )		
	case 2
		img = flipdim(img,2);
	case 4
		img = flipdim(img,1);
	case 6
		img = flipdim(img,1);
		img = flipdim(img,2);
	end	

	if( transpose )
		img = permute(img,[2 1 3]);
	end

end
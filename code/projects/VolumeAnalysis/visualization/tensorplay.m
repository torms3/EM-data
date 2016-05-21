function [] = tensorplay( tensor, scale_mode )
% 
% Display 4-D tensor
% 
% Usage:
% 	tensorplay( tensor )
% 
% Key Control:
%	'up' & 'down' 		scroll along the 3rd dimension (z-direction)
%	'left' & 'right'	scroll along the 4th dimension (w-direction)
%
% Dependency:
%	scaledata
%
% Program written by:
% Copyright (C) 2015 	Kisuk Lee <kiskulee@mit.edu>

	if ~exist('scale_mode','var')
		scale_mode = 'none';
	end

	% dimension
	Z = size(tensor,3);
	W = size(tensor,4);

	% scale tensor
	switch scale_mode
	case 'volume'
		tensor = single(tensor);
		for w = 1:W
			tensor(:,:,:,w) = scaledata(tensor(:,:,:,w),0,1);
		end
	case 'tensor'
		tensor = scaledata(single(tensor),0,1);
	end	

	% set data	
	data.tensor = tensor;
	data.z 		= 1;
	data.w		= 1;
	
	% display the first slice
	display_slice;
	h = gcf;

	% set event functions
	set( h, 'KeyPressFcn', @key_press );


	%% Key press event
	%
	function key_press( src, event )
		
		z = data.z;
		w = data.w;
		
		switch event.Key
		case 'uparrow'
			z = rem(z - 1,Z);
			if( z == 0 )
				z = Z;
			end
		case 'downarrow'
			z = rem(z + 1,Z);
			if( z == 0 )
				z = Z;
			end
		case 'leftarrow'
			w = rem(w - 1,W);
			if( w == 0 )
				w = W;
			end
		case 'rightarrow'
			w = rem(w + 1,W);
			if( w == 0 )
				w = W;
			end
		end

		data.z = z;
		data.w = w;
		display_slice;		

	end


	%% Display slice
	%
	function display_slice()

		img = data.tensor(:,:,data.z,data.w);
		imshow(img,[min(img(:)) max(img(:))]);

		% [2/16/2015 kisuklee]
		% Without hold on/off, dispaly window alternates between
		% dual monitors abnormally.
		hold on;
		hold off;

		str = ['z = ' num2str(data.z) ', w = ' num2str(data.w)];
		title(str);

	end

end
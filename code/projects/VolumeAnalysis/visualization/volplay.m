function [] = volplay( volume, alphas, map, ratio )
%
% Display 3D volume as a stack of 2D image slices
%
% Usage:
% 	volplay( volume )
% 	volplay( volume, {alpha1,alpha2,...} )
%
% 	volume: 3D volume as a stack of 2D image slices
% 	alphas: cell array of 3D alpha channels of the same size with volume
% 			(each alpha channel is re-scaled to [0,1])
%
% Key Control:
%	'up' & 'down' 	move up and down along z-direction
%	'c'	 			change alpha channel color randomly
%	'1', '2', ...	turn on/off volume and/or alpha channels
%	'p' 			save current figure as file
%
% Mouse Control:
%	mouse scroll	adjust alpha level
%
% Dependency:
%	scaledata
%
% Program written by:
% Copyright (C) 2014 	Kisuk Lee <kiskulee@mit.edu>

	if ~exist('alphas','var') || ~iscell(alphas)
		alphas = {};
	end
	if ~exist('map','var')
		map = [];
	end
	if ~exist('ratio','var')
		ratio = [1 1 1];
	end

	% preprocessing alpha channels
	for i = 1:numel(alphas)
		alphas{i} = scaledata(alphas{i},0,1);
	end

	% set data
	data.volume = scaledata(double(volume),0,1);
	data.alphas = alphas;
	data.map 	= map;
	data.rgb 	= cell(1,numel(data.alphas));
	data.z 		= 1;
	% data.level 	= 0.2;
    data.level 	= 0.3;
	data.vis 	= logical(zeros(1,1+numel(alphas)));
	data.vis(1) = true;
	data.ratio  = ratio;
	% for i = 1:numel(data.rgb)
	% 	data.rgb{i} = rand(1,3);
	% end
	for i = 1:numel(data.rgb)
		data.rgb{i} = [1 0 0];
	end

	% additional info.
	Z = size(volume,3);
	step = 0.05;

	% display the first slice
	display_slice;
	h = gcf;

	% set event functions
	set( h, 'KeyPressFcn', @key_press );
	set( h, 'WindowScrollWheelFcn', @scroll_wheel );


	%% Key press event
	%
	function key_press( src, event )

		z = data.z;

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
		% change color
		case 'c'
			for i = 1:numel(data.rgb)
				data.rgb{i} = rand(1,3);
			end
		 % toggle visibility
		case {'1','2','3','4','5','6','7','8','9'}
			num = str2num(event.Key);
			if num <= numel(data.vis)
				data.vis(num) = ~data.vis(num);
			end
		case 'p'
			fname = uiputfile;
			if fname == 0
				fname = 'temp.png';
			end
			f = getframe(gca);
			imwrite(f.cdata,fname,'png');
		end

		data.z = z;
		display_slice;

	end


	%% Mouse wheel event
	%
	function scroll_wheel( src, event )

		level = data.level;

		% adjust alpha level within [0,1]
		level = level - (event.VerticalScrollCount*step);
		level = max(min(level,1),0);

		data.level = level;
		display_slice;

	end


	%% Display slice
	%
	function display_slice()

		img = data.volume(:,:,data.z);
		if ~data.vis(1)
			img = ones(size(img));
		end
		imshow(img);

		hold on;
		display_alpha(img);
		display_map(img);
		hold off;

		daspect(data.ratio);

		title(['z = ' num2str(data.z)]);
		% disp(['z = ' num2str(data.z)]);

	end

	function display_alpha(img)

		for i = 1:numel(data.alphas)

			alpha = data.alphas{i};

			clr = data.rgb{i};
			one = ones(size(img));
			msk = cat(3,clr(1)*one,clr(2)*one,clr(3)*one);

			h = imshow(msk);

			if data.vis(i+1)
				alpha = data.level*alpha(:,:,data.z);
			else
				alpha = 0;
			end
			% alpha = scaledata(alpha,0,1);
			set(h,'AlphaData',alpha);

		end

	end

	function display_map(img)

		if ~isempty(data.map)
			map = data.map(:,:,data.z);
			map(map <= 0) = 0;
			idx = find(map > 0);
			[I,J] =ind2sub(size(map),idx);
			axis ij;
			scatter(J,I,0.01*(map(idx)),'rx','LineWidth',2);
		end

	end

end

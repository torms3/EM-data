function [segm,chann] = generate_segment_channel( fname, channel_data, crop_volume )

	if ~exist('crop_volume','var')
		crop_volume = [];
	end

	% import forward image
	fprintf('Now importing forward image...\n');
	[img] = import_multivolume( fname );
	% crop volume	
	if ~isempty(crop_volume)
		img{1} = adjust_border_effect( img{1}, crop_volume, true );
		img{2} = adjust_border_effect( img{2}, crop_volume, true );
		img{3} = adjust_border_effect( img{3}, crop_volume, true );
	end
	segm = cat(4,img{1},img{2},img{3});
	segm = single(scaledata(segm,0,1));

	% channel
	if exist('channel_data','var')
		[chann] = adjust_border_effect( channel_data, img{1} );
		chann = single(scaledata(chann,0,1));
	else
		chann = [];
	end

end
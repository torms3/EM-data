function [segm,chann] = generate_segment_channel( fname, channel_data )

	% import forward image
	fprintf('Now importing forward image...\n');
	[img] = import_multivolume( fname );
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
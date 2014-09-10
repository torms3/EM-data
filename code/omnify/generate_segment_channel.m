function [segm,chann] = generate_segment_channel( fname, channel_data, load_from_tif )

	if ~exist('load_from_tif','var')
		load_from_tif = true;
	end

	% import forward image
	fprintf('Now importing forward image...\n');
	if load_from_tif
		[img] = load_affinity_from_tif( fname );
	else
		[img] = import_multivolume( fname );
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
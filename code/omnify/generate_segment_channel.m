function [segm,chann] = generate_segment_channel( fname, channel_data, crop_border )

	if ~exist('crop_border','var')
		crop_border = false;
	end

	% import forward image
	fprintf('Now importing forward image...\n');
	[img] = import_multivolume( fname );
	% crop border	
	if crop_border
		img{1} = img{1}(2:end,2:end,:);
		img{2} = img{2}(2:end,2:end,:);
		img{3} = img{3}(2:end,2:end,:);
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
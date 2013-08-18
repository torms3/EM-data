function [segm,chann] = extract_segment_channel( fname, segIdx )

	% import forward image
	fprintf('Now importing forward image...\n');
	[img] = import_forward_image( fname, segIdx );
	segm = cat(4,img{1},img{2},img{3});

	% load raw data
	fprintf('Now loading e2006_e2198_kisuk.mat...\n');
	[dpath] = get_project_data_path();
	load([dpath '/e2006_e2198_kisuk.mat']);
	fprintf('Done!\n\n');

	% channel
	chann = im{segIdx};
	chann = chann(2:end,2:end,2:end); % shift due to affinity graph setup

	% adjusting size difference between forward image and original image stack
	xdiff = floor((size(chann,1) - size(img{1},1))/2);
	ydiff = floor((size(chann,2) - size(img{1},2))/2);
	zdiff = floor((size(chann,3) - size(img{1},3))/2);	
	chann = chann(xdiff+1:end-xdiff,ydiff+1:end-ydiff,zdiff+1:end-zdiff);

end
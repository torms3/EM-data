function [dataset] = generate_e2006_e2198_dataset( fname )

	if( ~exist('fname','var') )	
		dpath = get_project_data_path();
		fname = [dpath '/e2006_e2198_kisuk.mat'];
	end

	% load raw data
	fprintf('Now loading e2006_e2198_kisuk.mat...\n');	
	load(fname);
	fprintf('Done!\n\n');	


	%% Dataset-wise processing
	%
	ndataset = numel(im);
	for i = 1:ndataset

		fprintf('(%d/%d) %dth dataset is now being processed...\n',i,ndataset,i);

		% image
		D{i}.img = im{i}(2:end,2:end,2:end);
		
		% label
		[G] = generate_affinity_graph( seg{i}{:} );
		D{i}.lbl = cat(4,G.x,G.y,G.z);

		% mask
		D{i}.msk = mask{i}{:}(2:end,2:end,2:end);

		% valid index (place holder)
		D{i}.validIdx = [];

	end


	%% Containers.Map
	%
	keys = num2cell(1:ndataset);
	dataset = containers.Map( keys, D );

end
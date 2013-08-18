function [data] = batch_data_generation( segIdx, w )

	% load raw data
	fprintf('Now loading e2006_e2198_kisuk.mat...\n');
	[dpath] = get_project_data_path();
	load([dpath '/e2006_e2198_kisuk.mat']);
	fprintf('Done!\n\n');

	data = cell(numel(segIdx),1);
	for i = 1:numel(segIdx)

		idx = segIdx(i);
		fprintf('(%d/%d) seg #%d is now being processed...\n',i,numel(segIdx),idx);
		fprintf('Input size = %d\n',w);
		[data{i}] = generate_whole_training_input( im{idx}, seg{idx}{:}, bb{idx}{:}, mask{idx}{:}, w, true );

	end

end
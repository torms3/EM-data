function [] = export_multiple_whole_traing_data( dirName, data )

	savePath = '~/Workbench/seung-lab/znn/cpp/kisuk/training';
	mkdir(savePath,dirName);
	
	N = numel(data);
	for i = 1:N

		subname = [savePath '/' dirName '/batch' num2str(i)];
		disp(subname);
		export_whole_training_data( subname, data{i} );

	end

end
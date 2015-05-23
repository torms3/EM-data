function compare_learning( list, fname, w )

	if ~exist('fname','var'); fname = 'test'; end;
	if ~exist('w','var');				  w = 1; end;

	compare('cost');
	compare('CLSE');	

	function compare( errtype )

		figure;
		hold on;
		for i = 1:numel(list)

			cd(list{i}.path);
			
			data = load_info(fname);
			data = smooth_curve(data,w);
			switch errtype
			case 'cost'
				err = data.err;
			case 'CLSE'
				err = data.cls;
			end
			h(i) = plot(data.iter,err);

			lgnd{i} = list{i}.lgnd;

		end
		hold off;
		grid on;

		legend(h,lgnd);
		xlabel('Iteration');

		switch errtype
			case 'cost'
				ylabel('Cost');
				title(['Cost (' fname ')']);
			case 'CLSE'
				ylabel('Classification Error');
				title(['Classification Error (' fname ')']);
			end

	end

end

% Dropout
function compare_dropout()

	idx = 1;

	% VDH-P3
	base = '~/Workbench/torms3/znn-release/experiments/Ashwin/3D_affinity/train23_test1/VDH-P3_w69x5/';
	
	% VDH-P3-DO1
	list{idx}.path = [base 'exp3/iter_90K/network/'];
	list{idx}.lgnd = 'VDH-P3-DO1';
	idx = idx + 1;

	% VDH-P3-DO2
	list{idx}.path = [base 'exp5/iter_90K/network/'];
	list{idx}.lgnd = 'VDH-P3-DO2';
	idx = idx + 1;

	% VDH-P3-DO3
	list{idx}.path = [base 'exp7/iter_90K/network/'];
	list{idx}.lgnd = 'VDH-P3-DO3';
	idx = idx + 1;

	compare_learning(list,'train',71);
	% compare_learning(list,'test',71);

end
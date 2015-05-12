function compare_learning( list, fname, w, from )

	if ~exist('fname','var');fname = 'test';end;
	if ~exist('w','var');							w = 1;end;
	if ~exist('from','var');			 from = 1;end;

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

			lgnd{i} = list{i}.legend;

		end
		hold off;
		grid on;

		x = xlim;
		xlim([from x(2)]);
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
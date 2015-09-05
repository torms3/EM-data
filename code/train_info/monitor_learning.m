function [data] = monitor_learning( method, avg_winidow, start_iter, errshade, errline )

	train_only = false;
	% train_only = true;

	fontsize = get(0,'DefaultAxesFontSize');
 	set(0,'DefaultAxesFontSize',12);

	%% Options
	%
	if ~exist('method','var');		 method = 'moving';end;
	if ~exist('avg_winidow','var');    avg_winidow = 0;end;
	if ~exist('start_iter','var'); 		start_iter = 0;end;
	if ~exist('errshade','var');	  errshade = [0 0];end;
	if ~exist('errline','var');		   errline = false;end;

	% Load train info
	[train] = load_info('train');

	% Load test info
	[test] = load_info('test');

	% [kisuklee] TEMP
	idx = (train.iter == 0);
	train.iter(idx) = [];
	train.err(idx) 	= [];
	train.cls(idx) 	= [];
	idx = (test.iter == 0);
	test.iter(idx) 	= [];
	test.err(idx) 	= [];
	test.cls(idx) 	= [];

	% if strcmp(cost_type,'RMSE')
	% 	train.err = sqrt(train.err);
	% 	test.err  = sqrt(test.err);
	% end

	% train/test checkpoint frequency ratio
	ratio = train.n/test.n;

	% smoothing
	[train] = smooth_curve(train,avg_winidow,method);
	% [test] 	= smooth_curve(test,avg_winidow,method);
	[test] 	= smooth_curve(test,floor(avg_winidow/ratio),method	);
	if( avg_winidow > 0 )
		avgStr = [', Smoothing Window = ' num2str(avg_winidow)];
	else
		avgStr = '';
	end

	% return data
	data.train = train;
	data.test  = test;
	% data.cost  = cost_type;

	% Plot cost
	figure;
	hold on;

		% train
		h(1) = plot(train.iter,train.err,'-k');
		lgnd{1} = 'Train';
		% xlim([train.iter(1) train.iter(end)]);
		if isfield(train,'stderr') & errshade(1)
			stderr = [train.stderr(:) train.stderr(:)];
			shadedErrorBar(train.iter,train.err,stderr,{'-k','LineWidth',1.5},1,errline);
		end

		% test
		if ~train_only
			h(2) = plot(test.iter,test.err,'-r');
			lgnd{2} = 'Test';
			if isfield(test,'stderr') & errshade(2)
				stderr = [test.stderr(:) test.stderr(:)];
				shadedErrorBar(test.iter,test.err,stderr,{'-r','LineWidth',1.5},1,errline);
			end
		end

		xl = xlim;
		xlim([start_iter xl(2)]);
		xlabel('Iteration');
		ylabel('Cost');
		title(['Cost' avgStr]);
		legend(h,lgnd);

	hold off;
	grid on;

	% Plot classification error
	figure;
	hold on;

		% train
		h(1) = plot(train.iter,train.cls,'-k');
		lgnd{1} = 'Train';
		% xlim([train.iter(1) train.iter(end)]);
		if isfield(train,'stdcls') & errshade(1)
			stdcls = [train.stdcls(:) train.stdcls(:)];
			shadedErrorBar(train.iter,train.cls,stdcls,{'-k','LineWidth',1.5},1,errline);
		end

		% test
		if ~train_only
			h(2) = plot(test.iter,test.cls,'-r');
			lgnd{2} = 'Test';
			if isfield(train,'stdcls') & errshade(2)
				stdcls = [test.stdcls(:) test.stdcls(:)];
				shadedErrorBar(test.iter,test.cls,stdcls,{'-r','LineWidth',1.5},1,errline);
			end
		end

		xl = xlim;
		xlim([start_iter xl(2)]);
		xlabel('Iteration');
		ylabel('Classification error');
		title(['Classification Error' avgStr]);
		legend(h,lgnd);

	hold off;
	grid on;

	% revert default font size
  set(0,'DefaultAxesFontSize',fontsize);

end
function compare_affinity_result()

  % batch name
  batchname = {'7nm-512pix (Training)'; 		...
  						 '7nm-notTrained (Training)';	...
               % '7nm-IDSIA (Validation)'};
  						 '7nm-IDSIA (Validation)';		...
  						 '10nm-IDSIA (Generalization)'};

  % index
  idx = 1;

  % Dropout
  header = '~/Workbench/torms3/znn-release/experiments/Ashwin/3D_affinity/train23_test1/VDH-P3_w69x5/';

  % VDH-P3-DO1
  S{idx}.path  = [header 'exp3/iter_90K/output/'];
  S{idx}.lgnd	 = 'VDH-P3-DO1 (90K)';
  S{idx}.batch = [2 3 1 4];
  idx = idx + 1;

  % VDH-P3-DO2
  S{idx}.path  = [header 'exp5/iter_90K/output/'];
  S{idx}.lgnd	 = 'VDH-P3-DO2 (90K)';
  S{idx}.batch = [2 3 1 4];  
  idx = idx + 1;

  % VDH-P3-DO3
  S{idx}.path  = [header 'exp7/iter_90K/output/'];
  S{idx}.lgnd	 = 'VDH-P3-DO3 (90K)';
  S{idx}.batch = [2 3 1 4];  
  idx = idx + 1;

  % % VDH-P3-DO4
  % S{idx}.path  = [header 'exp8/iter_90K/output/'];
  % S{idx}.lgnd	 = 'VDH-P3-DO4 (90K)';
  % S{idx}.batch = [2 3 1 4];  
  % idx = idx + 1;

  % % VDH-P3 (Dropout, 60K)
  % header = '~/Workbench/torms3/znn-release/experiments/Ashwin/3D_affinity/train23_test1/VDH-P3_w69x5/';
  % S{idx}.path  = [header 'exp3/iter_60K/output/'];
  % S{idx}.lgnd  = 'VDH-P3 (Dropout, 60K)';
  % S{idx}.batch = [2 3 1];
  % idx = idx + 1;

  % % VDH-P2 (Dropout, 60K)
  % header = '~/Workbench/torms3/znn-release/experiments/Ashwin/3D_affinity/train23_test1/VeryDeep2H_w65x9/';
  % S{idx}.path  = [header 'dropout/rebalanced/global/eta02_out100/iter_60K/output/'];
  % S{idx}.lgnd  = 'VDH-P2 (Dropout, 60K)';
  % S{idx}.batch = [2 3 1];  
  % idx = idx + 1;

  % % VDH-P2-v2 (Dropout, 60K)
  % header = '~/Workbench/torms3/znn-release/experiments/Ashwin/3D_affinity/train23_test1/VDH-P2_w65x9/';
  % S{idx}.path  = [header 'dropout/rebalanced/global/eta02_out100/iter_60K/output/'];
  % S{idx}.lgnd  = 'VDH-P2-v2 (Dropout, 60K)';
  % S{idx}.batch = [2 3 1];  
  % idx = idx + 1;

  % % VDH-P1 (60K)
  % header = '~/Workbench/torms3/znn-release/experiments/Ashwin/3D_affinity/train23_test1/VDH-P1_w55x9/';
  % S{idx}.path  = [header 'rebalanced/global/eta02_out100/iter_60K/output/'];
  % S{idx}.lgnd  = 'VDH-P1 (60K)';
  % S{idx}.batch = [2 3 1];  
  % idx = idx + 1;

  % % VDH-P1-v2 (Dropout, 60K)
  % header = '~/Workbench/torms3/znn-release/experiments/Ashwin/3D_affinity/train23_test1/VDH-P1-v2_w55x9/';
  % S{idx}.path  = [header 'dropout/rebalanced/global/eta02_out100/iter_60K/output/'];
  % S{idx}.lgnd  = 'VDH-P1-v2 (Dropout, 60K)';
  % S{idx}.batch = [2 3 1];  
  % idx = idx + 1;

  % collect data
  for i = 1:numel(S)  	
  	
  	cd(S{i}.path);
  	
  	batch = S{i}.batch;
  	for j = 1:numel(batch)
  	
  		% load
  		file = dir(['out' num2str(batch(j)) '*.mat']);
  		load(file.name,'result');
  	
  		% metrics
  		S{i}.pixel(j) 	= min(result.x.err + result.y.err + result.z.err)/3;
  		S{i}.rand2D(j)	= min(result.xy.re + result.yz.re + result.zx.re)/3;
  		S{i}.rand3D(j)	= min(result.xyz.re);
  	
  	end
  
  end

  % plot
  plot_comparison;


  function plot_comparison

  	fontsize = get(0,'DefaultAxesFontSize');
  	set(0,'DefaultAxesFontSize',12);

  	
  	%% Pixel classification error
  	%
		data = [];
		lgnd = {};
		for i = 1:numel(S)
			data(:,end+1) = S{i}.pixel(:);
			lgnd{end+1} = S{i}.lgnd;
		end
		
		% plot
		figure;
		h = bar(data,'grouped');
		v = axis;
		axis([v(1) v(2) 0.07 0.13]);
		grid on;
		set(gca,'XTickLabel',batchname,'XTick',1:numel(batchname));
		fix_xticklabels(gca,0.1,{'FontSize',12});
		legend(lgnd,'Location','NorthWest');
		ylabel('Best pixel error');
		title('Affinity Classification Error');

		
		%% 2D Rand error
		%
		data = [];
		for i = 1:numel(S)
			data = [data S{i}.rand2D(:)];
		end

		% plot
		figure;
		h = bar(data,'grouped');
		v = axis;
		axis([v(1) v(2) 0.04 0.13]);
		grid on;
		set(gca,'XTickLabel',batchname,'XTick',1:numel(batchname));
		fix_xticklabels(gca,0.1,{'FontSize',12});
		legend(lgnd,'Location','Best');
		ylabel('Best 2D Rand error');
		title('2D Rand Error');


		% % 3D Rand error
		% data  = [];
		% for i = 1:numel(S)
		% 	data = [data S{i}.rand3D(:)];
		% end
		% figure;
		% h = bar(data,'grouped');
		% v = axis;
		% grid on;
		% set(gca,'XTickLabel',batchname,'XTick',1:numel(batchname));

		% revert default font size
  	set(0,'DefaultAxesFontSize',fontsize);

	end

end


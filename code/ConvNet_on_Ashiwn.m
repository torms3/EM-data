function [] = ConvNet_on_Ashiwn()

	%% 2D pixel error
	%
	% 		IDSIA3		IDSIA3R		Hybrid2		Hybrid2R
	data = [ 9.85 		8.66		8.82		8.25	; ... 
			 		 12.24 		10.93		11.08		10.48	; ...
			 		 11.14 		10.06		10.16		9.59	; ...
		   		];
  figure;
	h = bar(data,'grouped');
	v = axis;
	axis([v(1) v(2) 6 v(4)]);

	group = {'out2 (train)';'out3 (train)';'out1 (test)'};
	set(gca,'XTickLabel',group,'XTick',1:numel(group));
	grid on;
	ylabel('Best pixel error (%)');
	legend_str = {'2D ConvNet (unbalanced)';...
				  '2D Recursive Net (balanced)';...
				  '2D+3D ConvNet (balanced)';...
				  '2D+3D Recursive Net (balanced)'};
	legend(h,legend_str);
	title('IDSIA3-based ConvNets');


	%% 2D Rand error
	%
	% 		IDSIA3		IDSIA3R		Hybrid2		Hybrid2R
	data = [ 0.1804		0.1306		0.1301		0.1133	; ... 
			 		 0.1651		0.1322		0.1276		0.1088	; ...
			 		 0.1786		0.1352		0.1441		0.1192	; ...
		   		];
	figure;
	colormap('hot');
	h = bar(data,'grouped');
	v = axis;
	axis([v(1) v(2) 0.06 0.22]);

	group = {'out2 (train)';'out3 (train)';'out1 (test)'};
	set(gca,'XTickLabel',group,'XTick',1:numel(group));
	grid on;
	ylabel('Best 2D Rand error');
	legend_str = {'2D ConvNet (unbalanced)';...
				  '2D Recursive Net (balanced)';...
				  '2D+3D ConvNet (balanced)';...
				  '2D+3D Recursive Net (balanced)'};
	legend(h,legend_str);
	title('IDSIA3-based ConvNets');

end
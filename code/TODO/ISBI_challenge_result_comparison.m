function [] = ISBI_challenge_result_comparison()

	% ISBI Challenge 2012 Top 10 + ZNN
	errType = {'Rand Error','Warping Error','Pixel Error'};
	nErr = numel(errType);
	teamList = {'IDSIA';'MLL-ETH-1';'MLL-ETH-2';'MIT';'SCI-1';'Harvard';'SCI-2'; ...
				'CellProfiler';'UCL-1';'UCL-2'; ...
				'ZNN-unbal';'ZNN-bal'};
	errList = [ 0.048314096, 0.000434367, 0.060298549; ... % top 1
				% 0.064500546, 0.000555801, 0.083264179; ... % top 2
				% 0.069819563, 0.000524902, 0.079264809; ... % top 3
				% 0.075537461, 0.000645574, 0.065254812; ... % top 4
				0.064000000, 0.000457000, 0.065000000; ... % N1
				0.068000000, 0.000485000, 0.066000000; ... % N2
				0.057000000, 0.000618000, 0.066000000; ... % N3
				0.061000000, 0.000434000, 0.068000000; ... % N4
				% 0.083700043, 0.001601664, 0.134148235; ...
				% 0.084447767, 0.001124446, 0.157146646; ...
				% 0.089458158, 0.001134237, 0.077758118; ...
				% 0.09035629,  0.001512273, 0.100000994; ...
				% 0.100188599, 0.002199173, 0.132557284; ...
				% 0.104156509, 0.001475143, 0.095671823; ...
				0.085677411, 0.000602722, 0.066730732; ...	% ZNN unbalanced
				0.071951923, 0.000534311, 0.064157714; ...	% ZNN unbalanced, 8-avg
				0.085195904, 0.000580469, 0.066624430; ...	% ZNN cls-weighted
				0.071203694, 0.000496164, 0.062734030; ...	% ZNN cls-weighted, 8-avg
				0.093083442, 0.000534058, 0.065831922; ...	% ZNN balanced
				% 0.093083442, 0.000534058, 0.065831922; ...	% ZNN balanced, 8-avg
			];

	errList = [errList(end-4:end,:);errList];
	errList(end-4:end,:) = [];

	figure;
	for i = 1:nErr
		subplot(1,nErr,i);
		hold on;
		barweb(errList(:,i),zeros(size(errList(:,i))),...
			0.8,[],...
			[],[],errType{i},[],'y',...			% teamList,[],'axis');
			{'ZNN-unbal','ZNN-8avg-unbal','ZNN-clsw','ZNN-8avg-clsw',...
			 'ZNN-bal','IDSIA-avg','IDSIA-N1','IDSIA-N2','IDSIA-N3','IDSIA-N4'},...
			[],[]);
		hold off;
	end

	% figure;	
	% hold on;
	% barweb(errList(:,1),zeros(size(errList(:,1))),...
	% 	0.8,[],...
	% 	[],[],errType{1},[],'y',...
	% 	teamList,[],'axis');
	% 	% {'','','','','','','','','','','ZNN'},...
	% 	% [],'axis');
	% hold off;

	% figure;	
	% hold on;
	% barweb(errList(:,2),zeros(size(errList(:,2))),...
	% 	0.8,[],...
	% 	[],[],errType{2},[],'y',...
	% 	teamList,[],'axis');
	% 	% {'','','','','','','','','','','ZNN'},...
	% 	% [],'axis');
	% hold off;

	% figure;	
	% hold on;
	% barweb(errList(:,3),zeros(size(errList(:,3))),...
	% 	0.8,[],...
	% 	[],[],errType{3},[],'y',...
	% 	teamList,[],'axis');
	% 	% {'','','','','','','','','','','ZNN'},...
	% 	% [],'axis');
	% hold off;

end
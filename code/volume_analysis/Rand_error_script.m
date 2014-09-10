function [ret] = Rand_error_script( fname, truth, proposed )
% for the purpose of computing Rand error,
% channel is not necessary.

	%% Argument validation
	%
	bWatershed = false;
	if exist('proposed','var')
		bWatershed = true;
	end

	%% Parameters for watershed
	%	
	% params.Th = 999;
	% params.Tl = 300;
	% params.Ts = 1600;
	% params.Te = 250;
	params.Th = 891;
	params.Tl = 100;
	params.Ts = 1600;
	params.Te = 100;

	% systematically vary the watershed threshold
	threshold = [50 100 150 200 300 350 400];
	% threshold = [885 895 905];
	% threshold = 886:1:894;
	% threshold(threshold == 890) = [];
	% threshold = 803:-1:801;
	% threshold = 903:-1:897;
	% threshold = 890;
	% threshold(threshold == 910) = [];
	% params.Th = 819;
	% threshold = [200 400 600 800 1000];
	% threshold = [1200 1400 1600 1800 2000];
	% threshold = [2200 2400 2600 2800 3000];
	% threshold = [1800 2000 2200 2400 2600 2800 3000];
	% threshold = 200:200:3000;	
	% threshold(threshold == 1600) = [];

	ret.threshold = threshold;
	if( bWatershed )
		for i = 1:numel(threshold)

			% params.Th = threshold(i);
			% params.Tl = threshold(i);
			% params.Ts = threshold(i);
			params.Te = threshold(i);

			% watershed
			create_hdf5_for_omnification( fname, proposed, params );

		end
	else
		% compute and display Rand error
		for i = 1:numel(threshold)

			% params.Th = threshold(i);
			% params.Tl = threshold(i);
			% params.Ts = threshold(i);
			params.Te = threshold(i);

			% compute Rand error
			[ws_fname] = watershed_fname( fname, params );
			[ws_fname] = [ws_fname '.segm.h5'];
			[watershed] = hdf5read(ws_fname,'/main');
			[re] = compute_Rand_error( truth, watershed );
			
			% display Rand error
			disp(['threshold = 0.' num2str(params.Th) ', Rand error = ' num2str(re.err)]);

			% record
			ret.Rand_error(i) = re.err;

		end
	end

end
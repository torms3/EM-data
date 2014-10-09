function [] = watershed( fname, affin, params )

	%% Default parameters for watershed
	%
	if ~exist('params','var')
		params.Th = [999];
		params.Tl = [300];
		params.Ts = [400];
		params.Te = [250];
	end


	%% Watershed segmentation
	%
	for i = 1:numel(params.Th)
		for j = 1:numel(params.Tl)
			for k = 1:numel(params.Ts)
				for l = 1:numel(params.Te)
					
					prms.Th = params.Th(i);
					prms.Tl = params.Tl(j);
					prms.Ts = params.Ts(k);
					prms.Te = params.Te(l);

					create_hdf5_for_omnification( fname, affin, prms );

				end
			end
		end
	end


end
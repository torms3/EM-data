function [ret] = Rand_error_script( fname, truth, params )

	%% Default parameters for watershed
	%
	if ~exist('params','var')
		params.Th = [999];
		params.Tl = [300];
		params.Ts = [1600];
		params.Te = [250];
	end


	%% Compute and display Rand error
	%
	for i = 1:numel(params.Th)
		for j = 1:numel(params.Tl)
			for k = 1:numel(params.Ts)
				for l = 1:numel(params.Te)
					
					prms.Th = params.Th(i);
					prms.Tl = params.Tl(j);
					prms.Ts = params.Ts(k);
					prms.Te = params.Te(l);

					[ws_fname] = watershed_fname( fname, prms );
					[ws_fname] = [ws_fname '.segm.h5'];
					[ws] = hdf5read(ws_fname,'/main');
					[RI] = compute_Rand_error( truth, ws );

					% display Rand error
					fprintf('Th = %.3f, Tl = %.3f, Ts = %d, Te = %.3f, RI = %f\n',...
							prms.Th/1000,prms.Tl/1000,prms.Ts,prms.Te/1000,RI.err);
					% disp(['Th = 0.' num2str(prms.Th) ', '...
					% 	  'Tl = 0.' num2str(prms.Tl) ', '...
					% 	  'Ts = ' 	num2str(prms.Ts) ', '...
					% 	  'Te = 0.' num2str(prms.Te) ', '...
					% 	  'RI = ' 	num2str(RI.err)]);

					% record
					ret.RI(i) 	= RI.err;
					ret.prec(i) = RI.prec;
					ret.rec(i) 	= RI.rec;

				end
			end
		end
	end

end
function [err,prob] = assess_test_result2( fname, data, outIdx, medfilt )

	if( ~exist('outIdx','var'))
		outIdx = 2;
	end
	if( ~exist('medfilt','var'))
		medfilt = true;
	end

	%% Options
	%
	showError = true;
	showOutputImages = false;
	showGroundAffinity = false;
	symm_affin = true;

	% ground truth
	img = data.image;
	lbl = data.label;

	% import forward image
	fprintf('Now importing forward image...\n');
	[ret] = import_forward_image( fname );
	out{1} = exp(ret{1});
	out{2} = exp(ret{2});
	prob = out{outIdx}./(out{1}+out{2});

	% median filtering
	if( medfilt )
		for z = 1:size(prob,3)
			prob(:,:,z) = medfilt2(prob(:,:,z),[4 4]);
		end
	end
	

	%% Adjusting size difference between forward image and ground truth
	% 
	fprintf('Now adjusting size difference...\n');
	szDiff = size(data.label,1) - size(prob,1);
	hSzDiff = floor(szDiff/2);
	img = img(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,:);
	lbl = lbl(hSzDiff+1:end-hSzDiff,hSzDiff+1:end-hSzDiff,:);


	%% Error
	%
	if( showError )
		% compute pixel error
		[err] = compute_pixel_error( prob, lbl );

		% plot precision-recall curve
		plot_affinity_result( err );

		% plot threshold optimization
		plot_threshold_optimization( err );
	else
		err = [];
	end


	% %% Plot output
	% %
	% if( showOutputImages )
	% 	interactive_plot4_test( chann, img{1}, img{2}, img{3}, 'gray' );
	% end
	% if( showGroundAffinity )
	% 	interactive_plot4_test( chann, G.x, G.y, G.z, 'gray' );
	% end

end
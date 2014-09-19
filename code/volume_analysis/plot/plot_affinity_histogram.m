function plot_affinity_histogram( prob )
	
	%% Argument validation
	%
	assert(ndims(prob)==4);		% 4D tensor
	assert(size(prob,4)==3);	% 3D affinity graph

	affin.x = prob(:,:,:,1);
	affin.y = prob(:,:,:,2);
	affin.z = prob(:,:,:,3);

	%% Preprocessing
	%
	prob = scaledata(prob,0,1);

	%% Options
	%
	bFocus 	= true;
	bMulti	= true;
	% cutoff 	= 0.990;
	% cutoff 	= 0.800;
	% szBin 	= 0.001;
	% szBin 	= 0.01;
	% nBins 	= floor((1 - cutoff)/szBin);
	bottom	= 0.75;
	top		= 1.00;
	szBin	= 0.005;
	xvals	= bottom:szBin:top;
	nBins	= 50;

	%% Plot
	%
	figure;	
	if( ~bMulti )

		idx = (prob>=cutoff);
		hist(prob(idx),nBins);
		grid on;
		xlim([cutoff 1]);
		xlabel('affinity');
		title('affinity histogram');

	else
		hold on;

			% overall histogram
			subplot(2,2,1);			
			hist(prob(:),nBins);
			xlabel('affinity');
			grid on;
			title('overall histogram');
			
			% x-affinity
			subplot(2,2,2);
			if( bFocus )
				% idx = (affin.x>=cutoff);
				idx = (affin.x >= bottom) & (affin.x <= top);
				hist(affin.x(idx),xvals);
				xlim([bottom top]);
			else
				hist(affin.x(:));
			end
			xlabel('x-affinity');
			grid on;
			title('x-affinity histogram');
			
			% y-affinity
			subplot(2,2,3);
			if( bFocus )
				% idx = (affin.y>=cutoff);
				idx = (affin.y >= bottom) & (affin.y <= top);
				hist(affin.y(idx),xvals);
				xlim([bottom top]);
			else
				hist(affin.y(:));
			end
			xlabel('y-affinity');
			grid on;
			title('y-affinity histogram');
			
			% z-affinity
			subplot(2,2,4);
			if( bFocus )
				% idx = (affin.z>=cutoff);
				idx = (affin.z >= bottom) & (affin.z <= top);
				hist(affin.z(idx),xvals);
				xlim([bottom top]);
			else
				hist(affin.z(:));
			end
			xlabel('z-affinity');
			grid on;
			title('z-affinity histogram');

		hold off;
	end

end
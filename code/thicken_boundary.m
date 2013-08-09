function [] = thicken_boundary( lbl )

	% boundary map
	bMap = (lbl == 0);
	
	% +x/-x
	aug = bMap;
	aug(1:end-1,:,:) = aug(1:end-1,:,:) | bMap(2:end,:,:);
	aug(2:end,:,:) = aug(2:end,:,:) | bMap(1:end-1,:,:);

	% +y/-y
	aug(:,1:end-1,:) = aug(:,1:end-1,:) | bMap(:,2:end,:);
	aug(:,2:end,:) = aug(:,2:end,:) | bMap(:,1:end-1,:);

	interactive_plot(aug);

end
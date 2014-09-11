function [] = emplay( channel, alphas, z )

	img = channel(:,:,z);
	imshow(img);

	for i = 1:numel(alphas)

		alpha = alphas{i};

		rgb = rand(1,3);
		one = ones(size(img));
		msk = cat(3,rgb(1)*one,rgb(2)*one,rgb(3)*one);

		hold on;
		h = imshow(msk);
		hold off;

		set(h,'AlphaData',alpha(:,:,z));		

	end

end
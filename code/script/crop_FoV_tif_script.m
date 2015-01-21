function [] = crop_FoV_tif_script( w )

	listing = dir('*.tif');
	names = extractfield(listing,'name');
	names = sort(names);

	mkdir('no_mirroring');

	for i = 1:numel(names)
		crop_FoV(names{i});
	end

	function [] = crop_FoV_tif( fname )

		vol = loadtiff(fname);
		sz  = size(vol) - w + [1 1 1];
		vol = adjust_border_effect(vol,sz,true);

		write_tif_image_stack(vol,['no_mirroring/' fname]);

	end

end
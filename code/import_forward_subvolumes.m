function [vol] = import_forward_subvolumes( fname, batchNum, nSubVol )

	fname = [fname '.test_batch' num2str(batchNum)];

	subName = [fname '.sub_vol1'];
	[vol] = import_forward_image( subName );
	nOut = numel(vol);
	for i = 2:nSubVol

		disp([num2str(i) 'th subvolume is now being processed...'])

		subName = [fname '.sub_vol' num2str(i)];
		[next_img] = import_forward_image( subName );

		for j = 1:nOut
			vol{j} = cat(3, vol{j},next_img{j});
		end

	end

end
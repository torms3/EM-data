function generate_input_patches( savePath, img, lbl, w )

	assert( rem(w,2) == 1 );	% w should be odd
	halfW = floor(w/2);

	assert( isequal(size(img),size(lbl)) );
	[r,c,z] = size(img);

	
	%% On-boundary index
	%
	onIdx = (lbl == 0);		% boundary index
	nOnPixels = nnz(onIdx);
	linIdx = find(onIdx);
	[onI,onJ,onK] = ind2sub(size(onIdx),linIdx);
	onRandIdx = randperm(nOnPixels);


	%% Off-boundary index
	%
	offIdx = (lbl ~= 0);		% non-boundary index
	nOffPixels = nnz(offIdx);
	linIdx = find(offIdx);
	[offI,offJ,offK] = ind2sub(size(offIdx),linIdx);
	offRandIdx = randperm(nOffPixels);


	%% Boundary mirroring
	%
	oldImg = img;
	pad = floor(w/2);
	img = padarray( oldImg, [pad pad 0], 0 );
	for i = 1:z

		img(:,:,i) = mirrorImageBoundary( oldImg(:,:,i), pad );

	end
	img = uint8(img*255);
	

	%% Data batch-wise processing
	%
	batchSize = 10000;
	halfBatchSize = floor(batchSize/2);
	onPatches = uint8(zeros(w,w,halfBatchSize));
	offPatches = uint8(zeros(w,w,halfBatchSize));
	patches = uint8(zeros(w,w,batchSize));
	vecPatches = uint8(zeros(w*w,batchSize));
	lblTemplate = uint8([ones(1,halfBatchSize) zeros(1,halfBatchSize)]);
	labels = uint8(ones(1,batchSize));
	nBatch = floor((nOnPixels*2)/batchSize);	
	for i = 1:nBatch

		fprintf('(%d/%d) %d-th batch is now processing...\n',i,nBatch,i);
		
		tic
		
		idxOffset = halfBatchSize*(i - 1);
		for j = 1:halfBatchSize

			k = onRandIdx(idxOffset+j);
			onPatches(:,:,j) = uint8(img(onI(k):onI(k)+w-1,onJ(k):onJ(k)+w-1,onK(k)));

			k = offRandIdx(idxOffset+j);
			offPatches(:,:,j) = uint8(img(offI(k):offI(k)+w-1,offJ(k):offJ(k)+w-1,offK(k)));

		end

		patches(:,:,1:halfBatchSize) = onPatches;
		patches(:,:,halfBatchSize+1:end) = offPatches;
		randIdx = randperm(batchSize);
		patches = patches(:,:,randIdx);
		vecPatches = reshape(patches,w*w,[]);

		labels = lblTemplate(1,randIdx);

		% save as a file
		fileName = sprintf('data_batch_%d.mat',i);
		save([savePath '/' fileName],'vecPatches','labels');

		toc

	end

end
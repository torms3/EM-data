function [ret] = accumulate_fc_feature_maps( FC, w, bias )

	[~,asc.idx1] = sort(abs(w(:,1)));
	[~,asc.idx2] = sort(abs(w(:,2)));
	dsc.idx1 = asc.idx1(end:-1:1);
	dsc.idx2 = asc.idx2(end:-1:1);
	
	asc.FC1 = FC(:,:,asc.idx1);
	asc.FC2 = FC(:,:,asc.idx2);
	dsc.FC1 = FC(:,:,dsc.idx1);
	dsc.FC2 = FC(:,:,dsc.idx2);
	
	asc.w1 = w(asc.idx1,1);
	asc.w2 = w(asc.idx2,2);
	dsc.w1 = w(dsc.idx1,1);
	dsc.w2 = w(dsc.idx2,2);

	nmaps = size(FC,3);

	asc.out1 = zeros(size(FC));
	asc.out2 = zeros(size(FC));
	asc.out  = zeros(size(FC));
	dsc.out1 = zeros(size(FC));
	dsc.out2 = zeros(size(FC));
	dsc.out  = zeros(size(FC));

	asc.out1(:,:,1) = asc.FC1(:,:,1)*asc.w1(1) + bias(1);
	asc.out2(:,:,1) = asc.FC2(:,:,1)*asc.w2(1) + bias(2);
	dsc.out1(:,:,1) = dsc.FC1(:,:,1)*dsc.w1(1) + bias(1);
	dsc.out2(:,:,1) = dsc.FC2(:,:,1)*dsc.w2(1) + bias(2);

	asc.out(:,:,1) = exp(asc.out2(:,:,1))./(exp(asc.out1(:,:,1))+exp(asc.out2(:,:,1)));
	dsc.out(:,:,1) = exp(dsc.out2(:,:,1))./(exp(dsc.out1(:,:,1))+exp(dsc.out2(:,:,1)));

	for i = 2:nmaps

		disp(['Feature map ' num2str(i) ' is being processed...']);
		
		asc.out1(:,:,i) = asc.out1(:,:,i-1) + (asc.FC1(:,:,i).*asc.w1(i));
		asc.out2(:,:,i) = asc.out2(:,:,i-1) + (asc.FC2(:,:,i).*asc.w2(i));
		dsc.out1(:,:,i) = dsc.out1(:,:,i-1) + (dsc.FC1(:,:,i).*dsc.w1(i));
		dsc.out2(:,:,i) = dsc.out2(:,:,i-1) + (dsc.FC2(:,:,i).*dsc.w2(i));

		asc.out(:,:,i) = exp(asc.out2(:,:,i))./(exp(asc.out1(:,:,i))+exp(asc.out2(:,:,i)));
		dsc.out(:,:,i) = exp(dsc.out2(:,:,i))./(exp(dsc.out1(:,:,i))+exp(dsc.out2(:,:,i)));

	end

	ret.asc = asc;
	ret.dsc = dsc;

end
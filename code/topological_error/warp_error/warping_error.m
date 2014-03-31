function [warping_error, warped_labels, nonsimple_classify]=warping_error(label, proposal, mask, binary_threshold, radius, fg_conn)

if(~exist('mask') | isempty(mask))
	mask=ones(size(label))>0;
end

if(~exist('binary_threshold') | isempty(binary_threshold))
	binary_threshold=0.5;
end

if(~exist('fg_conn') | isempty(fg_conn))
	fg_conn=6;
end

if(~exist('radius') | isempty(radius))
	radius=Inf;
end

if radius==Inf
	radius=0;
end

if(ndims(label)==2)

	label_2d3d=zeros([size(label,1) size(label,2) 3]); label_2d3d(:,:,2)=label;
	proposal_2d3d=zeros([size(label,1) size(label,2) 3]); proposal_2d3d(:,:,2)=proposal;
	mask_2d3d=zeros([size(label,2) size(label,2) 3]); mask_2d3d(:,:,2)=mask;
	
	
	warped_labels_2d3d=simple_point_warp_3d(label_2d3d, proposal_2d3d, mask_2d3d, binary_threshold);
	warped_labels=warped_labels_2d3d(:,:,2);
	error_mask=((proposal>binary_threshold)~=(warped_labels~=0)).*mask;
	
	nonsimple_classify=non_simple_2d_classify(warped_labels, error_mask);
	
elseif(ndims(label)==3)

	warped_labels=simple_point_warp_3d_mex(uint32(label), single(proposal), mask, single(binary_threshold), uint32(fg_conn));
	display('Finished warping');
	error_mask=((proposal>binary_threshold)~=(warped_labels~=0)).*mask;
	display('Starting nonsimple classify');
	nonsimple_classify=non_simple_3d_classify_mex(uint32(warped_labels), error_mask>0, uint32(radius), uint32(fg_conn));
	
end

warping_error=nnz(error_mask)/nnz(mask);

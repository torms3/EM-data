function [ret] = watershed_fname( fname, params )

	%% Argument validation
	%
	assert(exist('fname','var')~=0);
	assert(exist('params','var')~=0);
	assert(isstruct(params));
	assert(isfield(params,'Th'));
	assert(isfield(params,'Tl'));
	assert(isfield(params,'Ts'));
	assert(isfield(params,'Te'));


	%% generate parameterized watershed file name
	%
	ret = fname;
	ret = [ret '.Th-' num2str(params.Th)];
    ret = [ret '.Tl-' num2str(params.Tl)];
    ret = [ret '.Ts-' num2str(params.Ts)];
    ret = [ret '.Te-' num2str(params.Te)];

end
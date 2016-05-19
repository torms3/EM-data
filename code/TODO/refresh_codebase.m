function [] = refresh_codebase()

	cur = pwd;
	root = get_project_root_path();
	cd([root '/code/']);
	addpath_recurse;
	cd(cur);

end
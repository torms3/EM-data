function [dpath] = get_project_data_path()

	root  = get_project_root_path;
	dpath = [root '/data'];

end
function pkg_folder = locate(pkg_name, quiet)
%% locate the folder of the specified package
if ~exist('quiet', 'var')
    quiet = false;
end
% load the information of the installed packages
installed_jsonpath = fullfile(fi.home_dir, 'pkgmanage', 'installed_matlab.json');
if exist(installed_jsonpath, 'file')
    installed = loadjson(installed_jsonpath);
    if isfield(installed, pkg_name)
        pkg = eval(sprintf('installed.%s', pkg_name));
        pkg_folder = pkg.path;
        if ~quiet
            fprintf('%s:\n\tpath:%s\n', pkg.name, pkg_folder);
        end
    else
        fprintf('The package has not been installed yet. \n');
        pkg_folder = [];
    end
else
    fprintf('The package has not been installed yet. \n');
    pkg_folder = [];
    return;
end


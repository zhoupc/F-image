function success = remove(pkg_name)
%% install packages

% load the information of the installed packages
installed_jsonpath = fullfile(fi.home_dir, 'pkgmanage', 'installed_matlab.json');
if exist(installed_jsonpath, 'file')
    installed = loadjson(installed_jsonpath);
    if isfield(installed, pkg_name)
        pkg = eval(sprintf('installed.%s', pkg_name));
        try
            rmdir(pkg.path, 's');
            success = true;
            fprintf('%s:\n\tremoved\n\tpath:%s\n', pkg.name, pkg.path(length(fi.home_dir)+1:end));
            installed = rmfield(installed, pkg_name);
            savejson('', installed, 'filename', installed_jsonpath);
        catch
            fprintf('The package folder was not removed correctly. Here is the package info\n');
            fprintf('%s:\n\tpath:%s\n', pkg.name, pkg.path(length(fi.home_dir)+1:end));
            success = false;
        end
    else
        fprintf('The package has not been installed.\n');
        success = true;
    end
    
else
    fprintf('The package has not been installed.\n');
    success = true;
end


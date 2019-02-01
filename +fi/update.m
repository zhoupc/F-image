function success = update(pkg_name)
%% update packages

pkg_name = lower(pkg_name);
% find the corresponding json file
json_file = fullfile(fi.home_dir, 'pkgmanage', 'pkginfo', ...
    [pkg_name, '_matlab.json']);
if ~exist(json_file, 'file')
    fprintf('the package has not been supported yet\n');
    success = false;
    return;
end

% load the information of the installed packages
installed_jsonpath = fullfile(fi.home_dir, 'pkgmanage', 'installed_matlab.json');
if exist(installed_jsonpath, 'file')
    installed = loadjson(installed_jsonpath);
else
    installed = struct();
end

% if installed, then update; if not, then install
if isfield(installed, pkg_name)
    % load json file and install
    pkg = loadjson(json_file);
    switch lower(pkg.repository.type)
        case 'git'
            tmp_path = fullfile(fi.home_dir, 'packages', pkg.name);
            temp = cd();
            try
                cd(tmp_path);   % switch to the package folder
                system('git pull');  % pull the current package
                success = true;
                installed.(pkg_name).date = date();
                savejson('', installed, 'filename', installed_jsonpath);
                fprintf('%s:\nupdated.\n\tpath:%s\n', pkg.name, tmp_path(length(fi.home_dir)+1:end));
            catch
                success = false;
                fprintf('%s:\n\tfailed to update.\n\tpath:%s\n', pkg.name, tmp_path);
                fprintf('suggestions: You probably modified the package locally. Please resolve the conflicts first.\n'); 
            end
            cd(temp);       % switch back to the previous working directory
            % get the commit information
        case 'zip'
            tmp_path = fullfile(fi.home_dir, 'packages', pkg.name);
            % remove
            fi.remove(pkg_name);
            % install
            fi.install(pkg_name);
            
            fprintf('%s:\n\tupdated.\n\tpath:%s\n', pkg.name, tmp_path(length(fi.home_dir)+1:end));
        otherwise
            sprintf('the package is not supported yet.');
    end
else
    fprintf('The package has not been installed yet. F-image will install it now.\n');
    try
        fi.install(pkg_name);
        success = true;
    catch
        success = false;
    end
    return;
end

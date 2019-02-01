function success = install(pkg_name)
%% install packages
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
    if isfield(installed, pkg_name)
        temp = installed.(pkg_name);
        fprintf('%s:\n\tinstalled.\n\tpath:%s\n', temp.name, temp.path(length(fi.home_dir)+1:end));
        success = true;
        return;
    end
else
    installed = struct();
end

% load json file and install
pkg = loadjson(json_file);
switch lower(pkg.repository.type)
    case 'git'
        tmp_path = fullfile(fi.home_dir, 'packages', pkg.name);
        tmp_str = sprintf('git clone %s %s',...
            pkg.repository.url, tmp_path);
        if ~exist(tmp_path, 'dir')
            system(tmp_str);    % install
        end
        % get the commit information
        
        % add the package to the installed pacakges
        pkg.path = tmp_path;
        pkg.date = date();
        eval(sprintf('installed.%s = pkg;', pkg_name));
        savejson('', installed, 'filename', installed_jsonpath);
        fprintf('%s:\n\tinstalled.\n\tpath:%s\n', pkg.name, pkg.path(length(fi.home_dir)+1:end));
        success = true;
    case 'zip'
        tmp_path = fullfile(fi.home_dir, 'packages', pkg.name);
        if ~exist(tmp_path, 'dir')
            % check whether the pakcage is platform dependent
            if pkg.repository.platform_dependent
                if ismac
                    url_zip = pkg.repository.url_mac;
                elseif isunix
                    url_zip = pkg.repository.url_unix;
                elseif ispc
                    url_zip = pkg.repository.url_pc;
                else
                    url_zip = pkg.respository.url;
                end
            else
                url_zip = pkg.repository.url;
            end
            % check whether the link is good for downloading directly
            if strcmpi(url_zip(end-3:end), '.zip')
                fprintf('%s:\n\tDownloading and Installing...\n', pkg.name);
                unzip(url_zip, tmp_path);
            else
                fprintf('You need to download the zip file to your computer from \n%s\n\n', url_zip);
                tmp_ans = input('choose a way of selecting the downloaded file - GUI (1) / path (0): ');
                if tmp_ans==1
                    [fname, fpath] = uigetfile('*.zip');
                    url_zip = fullfile(fpath, fname);
                else
                    while ~exist(url_zip, 'file')
                        url_zip = input('file path: ', 's');
                    end
                end
                fprintf('%s:\n\tInstalling...\n', pkg.name);
                unzip(url_zip, tmp_path);
            end
        end
        % add the package to the installed pacakges
        pkg.path = tmp_path;
        pkg.date = date();
        eval(sprintf('installed.%s = pkg;', pkg_name));
        savejson('', installed, 'filename', installed_jsonpath);
        fprintf('%s:\n\tinstalled.\n\tpath:%s\n', pkg.name, pkg.path(length(fi.home_dir)+1:end));
        success = true;
    otherwise
        sprintf('the package is not supported yet.');
end
function supported = list_supported(obj)
%% install packages

% load the information of the installed packages
installed_jsonpath = fullfile(obj.home_dir, 'pkgmanage', 'installed_matlab.json');

if exist(installed_jsonpath, 'file')
    installed = loadjson(installed_jsonpath);
else
    fprintf('no packages were installed\n');
    installed = struct();
end

% find all supported packages
json_files = dir(fullfile(obj.home_dir, 'pkgmanage', 'pkginfo'));
supported = cell(length(json_files)-2); 
for m=1:length(json_files)
    tmp_name = json_files(m).name;
    idx = regexp(tmp_name, '_matlab.json');
    if isempty(idx)
        continue;
    end
    pkg_name = tmp_name(1:(idx-1));
    supported{m} = pkg_name; 
    if isfield(installed, pkg_name)
        pkg = eval(sprintf('installed.%s', pkg_name));
        fprintf('%s:\n\tinstalled.\n\tpath:%s\n', pkg.name, pkg.path(length(obj.home_dir)+1:end));
    else
        tmp_json = loadjson(fullfile(json_files(m).folder, json_files(m).name)); 
        fprintf('%s:\n\tnot installed.\n\tdescription: %s\n', pkg_name, tmp_json.description);
    end
end
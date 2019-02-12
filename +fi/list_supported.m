function supported = list_supported(quiet)
%% list all supported packages

if ~exist('quiet', 'var') || isempty(quiet)
    quiet = false;
end

% load the information of the installed packages
installed_jsonpath = fullfile(fi.home_dir, 'pkgmanage', 'installed_matlab.json');

if exist(installed_jsonpath, 'file')
    installed = loadjson(installed_jsonpath);
else
    fprintf('no packages were installed\n');
    installed = struct();
end

%% create a markdown file for listing all supported packages
fp = fopen(fullfile(fi.home_dir, 'supported_packages.md'), 'w');
fprintf(fp, '## supported packages [%s]\n', date());
fprintf(fp, '|package name | short name| descriptions| references | added by|\n');
fprintf(fp, '|---|---|---|---|---|\n');

%% find all supported packages
json_files = dir(fullfile(fi.home_dir, 'pkgmanage', 'pkginfo'));
supported = cell(length(json_files), 1);
k_added = 0;


%%
for m=1:length(json_files)
    tmp_name = json_files(m).name;
    idx = regexp(tmp_name, '_matlab.json');
    if isempty(idx)
        continue;
    end
    tmp_folder = json_files(m).folder;
    
    pkg_name = tmp_name(1:(idx-1));
    k_added = k_added + 1;
    supported{k_added} = pkg_name;
    if ~quiet
        if isfield(installed, pkg_name)
            pkg = eval(sprintf('installed.%s', pkg_name));
            fprintf('%s:\n\tinstalled.\n\tpath:%s\n', pkg.name, pkg.path(length(fi.home_dir)+1:end));
        else
            tmp_json = loadjson(fullfile(json_files(m).folder, json_files(m).name));
            fprintf('%s:\n\tnot installed.\n\tdescription: %s\n', pkg_name, tmp_json.description);
        end
    end
    
    % write to markdown file
    pkg = loadjson(fullfile(tmp_folder, tmp_name));
    fprintf(fp, '|%s|%s|[%s](%s)|%s|%s|\n', pkg.name, pkg_name,...
        pkg.description, pkg.repository.url, pkg.references, pkg.added_by);
end
supported = supported(1:k_added);
fclose(fp);
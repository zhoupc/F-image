function fix_pkginfo(pkg_name, only_fix_missing_values)
%% install packages

if ~exist('only_fix_missing_values', 'var')
    only_fix_missing_values = false;
end

%% load a template file

% load the information of the installed packages
template_jsonpath = fullfile(fi.home_dir, 'pkgmanage', 'pkginfo', 'template.json');

template = loadjson(template_jsonpath);

%% find all supported packages
if ~exist('pkg_name', 'var') || isempty(pkg_name)
    json_files = dir(fullfile(fi.home_dir, 'pkgmanage', 'pkginfo'));
else
    json_files.name = sprintf('%s_matlab.json', pkg_name);
    json_files.folder = fullfile(fi.home_dir, 'pkgmanage', 'pkginfo');
end
%%
for m=1:length(json_files)
    tmp_name = json_files(m).name;
    idx = regexp(tmp_name, '_matlab.json', 'once');
    if isempty(idx)
        continue;
    end
    tmp_folder = json_files(m).folder;
    tmp_file = fullfile(tmp_folder, tmp_name);
    
    % load the json file
    pkg = loadjson(tmp_file);
    fprintf('%s:\n', pkg.name);
    [pkg, k_changed] = check_pkginfo(pkg, template, 1, only_fix_missing_values);
    
    if k_changed==0
        fprintf('\tcompleted\n');
    else
        fprintf('\tfixed %d fields\n', k_changed);
    end
    savejson('', pkg, 'filename', tmp_file);
end
end

function [pkg, k_changed] = check_pkginfo(pkg, template, level, only_fix_missing_values)
required_fields = fieldnames(template);
k_fields = length(required_fields);
k_changed = 0;

for n_field=1:k_fields  % go through all fields
    tmp_key = required_fields{n_field};
    if ~isfield(pkg, tmp_key) % fix missing values
        fprintf('%s%s: %s\n', char(ones(1,4*level)*32), tmp_key, template.(tmp_key));
        pkg.(tmp_key) = input(char(ones(1,4*level+2)*32), 's');
    elseif ~only_fix_missing_values  % update exisitng values
        if ischar(pkg.(tmp_key))
            fprintf('%s%s: %s\n', char(ones(1,4*level)*32), tmp_key, pkg.(tmp_key));
            if ischar(template.(tmp_key))
                temp = input(char(ones(1,4*level+2)*32), 's');
            else
                temp = input(char(ones(1,4*level+2)*32));
                
            end
            if ~isempty(temp)
                k_changed = k_changed +1;
                pkg.(tmp_key) = temp;
            end
        elseif isstruct(pkg.(tmp_key)) % struct input
            fprintf('%s%s: \n', char(ones(1,4*level)*32), tmp_key);
            
            [pkg.(tmp_key), temp] = check_pkginfo(pkg.(tmp_key), template.(tmp_key), ...
                level +1, only_fix_missing_values);
            k_changed = k_changed + temp;
        end
    end
end
end
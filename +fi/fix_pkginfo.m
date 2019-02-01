function fix_pkginfo(pkg_name)
%% install packages

%% load a template file

% load the information of the installed packages
template_jsonpath = fullfile(fi.home_dir, 'pkgmanage', 'pkginfo', 'template.json');

template = loadjson(template_jsonpath);

required_fileds = fieldnames(template);
k_fields = length(required_fileds);

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
    k_changed = 0; 
    for n_field=1:k_fields
        tmp_key = required_fileds{n_field};
        if ~isfield(pkg, tmp_key)
            fprintf('    %s: \n', tmp_key);
            pkg.(tmp_key) = input('    ', 's');
            %         else
            %             if ischar(pkg.(tmp_key))
            %                 fprintf('\t%s: %s\n', tmp_key, pkg.(tmp_key));
            %             else
            %                 fprintf('\t%s:\n', tmp_key);
            %                 disp( pkg.(tmp_key));
            %             end
            k_changed = k_changed +1; 
        end
    end
    if k_changed==0
        fprintf('\tcompleted\n'); 
    else
        fprintf('\tfixed %d fields\n', k_changed); 
    end
    savejson('', pkg, 'filename', tmp_file);
end

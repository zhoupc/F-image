function add_pkginfo(pkg_name)
%% install packages

%% load a template file

% load the information of the installed packages
template_jsonpath = fullfile(fi.home_dir, 'pkgmanage', 'pkginfo', 'template.json');

pkg = loadjson(template_jsonpath);

required_fields = fieldnames(pkg);
k_fields = length(required_fields);

%% find all supported packages
json_file = fullfile(fi.home_dir, 'pkgmanage', 'pkginfo', sprintf('%s_matlab.json', pkg_name));
if exist(json_file, 'file')
    fprintf('There is alaready a packaged named as %s. Please rename your new package.\n', pkg_name);
end

%% manually input package info
for n_field=1:k_fields
    tmp_key = required_fields{n_field};
    
    if ischar(pkg.(tmp_key))
        fprintf('%s: %s\n', tmp_key, pkg.(tmp_key));
        pkg.(tmp_key) = input('    ', 's');
    elseif isstruct(pkg.(tmp_key))
        fprintf('%s: \n', tmp_key); 
        tmp_template = pkg.(tmp_key);
        tmp_fields = fieldnames(tmp_template);
        for kk=1:length(tmp_fields)
            tmp_str = tmp_fields{kk};
            fprintf('\t%s: %s\n', tmp_str, tmp_template.(tmp_str));
            
            if ischar(tmp_template.(tmp_str))
                pkg.(tmp_key).(tmp_str) = input('            ', 's');
            else
                pkg.(tmp_key).(tmp_str) = input('            '); 
            end
        end
    end
end
savejson('', pkg, 'filename', json_file);

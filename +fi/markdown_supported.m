function supported = markdown_supported()
%% create a markdown file for listing all supported packages 

% find all supported packages
json_files = dir(fullfile(fi.home_dir, 'pkgmanage', 'pkginfo'));
supported = cell(length(json_files), 1); 
k_added = 0; 
for m=1:length(json_files)
    tmp_name = json_files(m).name;
    idx = regexp(tmp_name, '_matlab.json');
    if isempty(idx)
        continue;
    end
    pkg_name = tmp_name(1:(idx-1));
    k_added = k_added + 1; 
    supported{k_added} = pkg_name; 
    
    % write package name
    
    % write short name
    
    % write descriptions 
    
    % write references 
    
    % write added by 
end
supported = supported(1:k_added); 
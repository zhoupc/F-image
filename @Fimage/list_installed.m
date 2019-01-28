function installed = list_installed(obj)
%% install packages

% load the information of the installed packages
installed_jsonpath = fullfile(obj.home_dir, 'pkgmanage', 'installed_matlab.json');
if exist(installed_jsonpath, 'file')
    installed = loadjson(installed_jsonpath);
    pkgs = fieldnames(installed); 
    for m=1:length(pkgs)
        pkg = eval(sprintf('installed.%s', pkgs{m})); 
        fprintf('%s:\n\tpath:%s\n', pkg.name, pkg.path(length(obj.home_dir)+1:end));
    end
else
    fprintf('no packages were installed\n'); 
    installed = []; 
    return; 
end


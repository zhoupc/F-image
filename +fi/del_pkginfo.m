function del_pkginfo(pkg_name)
%% remove a supported package

fi.remove(pkg_name);
json_file = fullfile(fi.home_dir, 'pkgmanage', 'pkginfo', sprintf('%s_matlab.json', pkg_name));

if exist(json_file, 'file')
    delete(json_file);
    fprintf('%s:\n', pkg_name);
    fprintf('\tpackage info deleted\n');
else
    fprintf('The package %s does not exist\n', pkg_name);
end
%%
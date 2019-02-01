function json_file = pkginfo(pkg_name)
%% edit package json info

pkg_name = lower(pkg_name);
% find the corresponding json file
json_file = fullfile(fi.home_dir, 'pkgmanage', 'pkginfo', ...
    [pkg_name, '_matlab.json']);
if ~exist(json_file, 'file')
    fprintf('the package has not been supported yet\n');
    json_file = '';
    return;
else
    temp = fileread(json_file);
    disp(temp);
end


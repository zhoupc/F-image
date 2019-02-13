function success = push_github(pkg_name)
%% push changes of the selected package to github
% get the current folder
tmp_folder = pwd();

try
    if ~exist('pkg_name', 'var') || isempty(pkg_name)
        pkg_name = 'fimage';
    end
    if strcmpi(pkg_name, 'fimage')
        % update the list of all supported packages
        quiet = true;
        fi.list_supported(quiet);
        pkg_path = fi.home_dir;
    else
        quiet = true;
        pkg_path = fi.locate(pkg_name, quiet);
    end
    
    % git add; git commit; git push
    cd(pkg_path);
    system('git add --all');
    temp = input('commit info: ', 's');
    system(sprintf('git commit -m ''%s''', temp));
    system('git push');
    success = true;
catch
    success = false;
end

% switch back to the previous folder
cd(tmp_folder);
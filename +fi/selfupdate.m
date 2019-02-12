function success = selfupdate()
%% update F-image

try
    cd(fi.home_dir);
    system('git pull');
    fprintf('F-image:\nupdated.\n\tpath:%s\n', fi.home_dir());
    success = true;
catch
    success = false;
end

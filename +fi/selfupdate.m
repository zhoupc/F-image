function success = selfupdate()
%% update F-image

try
    cd(fi.home_dir);
    system('git pull');
    fprintf('F-image:\nupdated.\n\tpath:%s\n', fi.home_dir());
catch
    tmp_folder = fi.home_dir; 
    unzip('https://github.com/zhoupc/F-image/archive/master.zip');  % not git installed
    movefile('F-image-master', tmp_folder)
end
success = true; 
function success = selfupdate()
%% update F-image

try
    cd(fi.home_dir);
    system('git pull');
    fprintf('F-image:\nupdated.\n\tpath:%s\n', fi.home_dir());
<<<<<<< HEAD
catch
    tmp_folder = fi.home_dir; 
    unzip('https://github.com/zhoupc/F-image/archive/master.zip');  % not git installed
    movefile('F-image-master', tmp_folder)
end
success = true; 
=======
    success = true;
catch
    success = false;
end
>>>>>>> 2913a7810d46f77f0da2e1b13ec800880e0fbddd

% update the list of all supported packages 
quiet = true; 
fi.list_supported(quiet); 

% get the current folder 
tmp_folder = pwd(); 

% git add; git commit; git push 
cd(fi.home_dir); 
system('git add --all'); 
temp = input('commit info: ', 's'); 
system(sprintf('git commit -m ''%s''', temp)); 
system('git push');

% switch back to the previous folder 
cd(tmp_folder); 
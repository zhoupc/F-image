fi.list_supported(); 
system('git add --all'); 
temp = input('commit info: ', 's'); 
system(sprintf('git commit -m ''%s''', temp)); 
system('git push'); 
fimage_dir = fileparts(mfilename('fullpath'));

if ~exist('fimage_loaded', 'var') || ~fimage_loaded
    addpath(fimage_dir);   
    addpath(fullfile(fimage_dir, 'packages', 'jsonlab')); 
    fimage_loaded = true; % package loaded 
end

try
    savepath();
catch 
    fprintf('You can manually add F-image to the MATLAB path. see \nhttps://www.mathworks.com/help/matlab/matlab_env/add-remove-or-reorder-folders-on-the-search-path.html\n'); 
end
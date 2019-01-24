fimage_dir = fileparts(mfilename('fullpath'));

if ~exist('fimage_loaded', 'var') || ~fimage_loaded
    addpath(fimage_dir);   
    addpath(fullfile(fimage_dir, 'packages', 'jsonlab')); 
    fimage_loaded = true; % package loaded 
end


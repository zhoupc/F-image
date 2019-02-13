function usepkg(pkg_names)
%% use packages
if ischar(pkg_names)
    pkg_names = {pkg_names};
end
npkg = length(pkg_names);

% load the information of the installed packages
installed_jsonpath = fullfile(fi.home_dir, 'pkgmanage', 'installed_matlab.json');
if exist(installed_jsonpath, 'file')
    installed = loadjson(installed_jsonpath);
else
    installed = struct();
end

try
    fi_loaded = evalin('base', 'fi_loaded');
catch
    fi_loaded = struct();
end
for m=1:npkg
    pkg_name = lower(pkg_names{m});
    % check the installation of the package
    if ~isfield(installed, pkg_name)
        fi.install(pkg_name);
        installed = loadjson(installed_jsonpath);
    end
    
    % check whether the package has been loaded
    if isfield(fi_loaded, pkg_name) && fi_loaded.(pkg_name)
        continue;
    end
    % add to path
    switch pkg_name
        % adding the folder path directly
        case {'normcorre', 'segself', 'yaml', 'suite2p','export_fig', 'polygon2voxel'}
            tmp_path = installed.(pkg_name).path;
            evalin('base', sprintf('addpath(''%s'');', tmp_path));
            
            % adding the folder and some subdirectories
        case 'utils'
            tmp_path = installed.(pkg_name).path;
            evalin('base', sprintf('addpath(''%s'');', tmp_path));
            evalin('base', sprintf('addpath(genpath_exclude(''%s'', ''.git''));',tmp_path));
        case 'min1pipe'
            tmp_path = installed.(pkg_name).path;
            evalin('base', sprintf('addpath(''%s'');', tmp_path));
            evalin('base', sprintf('addpath(genpath(''%s''));',tmp_path));
        case 'imagecn'
            tmp_path = installed.(pkg_name).path;
            evalin('base', sprintf('addpath(genpath(''%s''));', ...
                fullfile(tmp_path, 'ImageCN')));
        case 'nwb'
            tmp_path = installed.(pkg_name).path;
            evalin('base', sprintf('addpath(''%s'');', tmp_path));
            if ~exist(fullfile(tmp_path, 'namespaces'), 'dir')
                generateCore('schema/core/nwb.namespace.yaml');
            end
        case {'blit'}
            tmp_path = fullfile(installed.(pkg_name).path, 'bradley');
            evalin('base', sprintf('addpath(''%s'');', tmp_path));
            % other cases
            % run ***_setup.m
        case {'cnmfe', 'oasis', 'cvx', 'monia', 'ease', 'idl'}
            tmp_path = fullfile(installed.(pkg_name).path, sprintf('%s_setup.m', pkg_name));
            evalin('base', sprintf('run(''%s'');', tmp_path));
            
        otherwise
            fprintf('the package configuration has not customized yet. \nBy default, F-image only add the package path to MATLAB searching path.\n');
            
            tmp_path = installed.(pkg_name).path;
            evalin('base', sprintf('addpath(''%s'');', tmp_path));
            
    end
    evalin('base', sprintf('fi_loaded.%s = true;', pkg_name));
    fprintf('%s:\n\tloaded\n', installed.(pkg_name).name);
    
end
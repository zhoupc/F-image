classdef Fimage < handle 
    %% properties 
    properties
        % F-image path 
        home_dir = []; 
        
        % home directory 
        % supported packages 
        
        % installed packages 
        installed_packages = []; 
        
    end 
    
    
    %% methods 
    methods 
        % constructor 
        function obj = Fimage(varargin)
            obj.home_dir = fileparts(which('fimage_setup')); 
            % load some default packages 
%             obj.load('JSONlab'); 
            
            % installed package 
            
        end 
        
        % add package info 
        success = add_package(obj, pkg_name); 
        
        % install package 
        success = install(obj, pkg_name); 
        
        % install package
        success = remove(obj, pkg_name);
        
        % load package
        success = usepkg(obj, pkg_name)
        
        % update packages 
        success = update(obj, pkg_name); 
        
        % list package information 
        installed = list_installed(obj); 
        
        % list supported information 
        supported = list_supported(obj); 
        
        % go to the package folder 
        pkg_folder = locate(obj, pkg_name); 
        
        % update package information 
        function update_pkginfo(obj, pkg_name)
            
        end 
    end 
end 
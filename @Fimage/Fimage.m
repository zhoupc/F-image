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
        
        % install package 
        success = install(obj, pkg_name); 
        
        % load package 
        success = usepkg(obj, pkg_name)
        
        % update package information 
        function update_pkginfo(obj, pkg_name)
            
        end 
    end 
end 
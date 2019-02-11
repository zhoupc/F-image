# F-image
F-image is a package management system used to install and manage software packages written for functional image analysis.

## why F-image?
There are many independently developed toolboxes for processing functional imaging data. F-image can automatically install and load the selected packages for specific tasks. It makes reusing functions between packages easier. 

**Example**
```matlab 
fi.install('cnmfe');   # install CNMF-E 
fi.usepkg('cnmfe');    # use CNMF-E functions in your code. 
```

## Goals
* **simplify** the steps of installing and using packages of functional image analysis (mainly calcium/voltage imaging for now). 
  
* **community** curated list of functional imaging analysis toolboxes. 
 
* **standardize** data communications between packages. A customized pipeline for processing data contains multiple steps, and we use F-image to ensure seamless communications. 
  
* **share** customized pipelines for processing one type of data. You can just tell what packages to be included and F-image will handle the rest. 
  
* **reduce** the effort of developing your packages by reusing other packages. All you need to do for calling functions in other packages is 
  ```matlab
  fi.install(pkg_name); 
  fi.usepkg(pkg_name); 
  ```
  
## Installation
Open MATLAB and set the current working directly to the place you want to install F-image, then run the following command 
```matlab 
try
    system('git clone https://github.com/zhoupc/F-image.git'); % with git
catch
    unzip('https://github.com/zhoupc/F-image/archive/master.zip');  % not git installed
    movefile('F-image-master', 'F-image')
end
cd F-image;
fimage_setup; 
```

## How to use 
Here we use [CNMF-E](https://github.com/zhoupc/CNMF_E) as an example to show how F-image manages packages. 

```matlab 
>> pkg_name = 'cnmfe'; 
```

* list all supported packages ([currently supported packages](https://github.com/zhoupc/F-image/blob/master/supported_packages.md))
    ```matlab 
    >> fi.list_supported(); 
    ```
* install a package 
    ```matlab 
    >> fi.install(pkg_name); 
    ```
* use a package 
    ```matlab
    >> fi.usepkg(pkg_name); 
    ```
* remove a package 
    ```matlab 
    >> fi.remove(pkg_name);
    ```
* update a package 
    ```matlab
    >> fi.update(pkg_name);
    ```
* get the package path 
  ```matlab 
  >> pkg_path = fi.locate(pkg_name); 
  ```
* show package information 
    ```matlab
    >> json_path = fi.pkginfo(pkg_name); 
    ```
* add a new package info 
    ```matlab
    >> fi.add_pkginfo(pkg_name); 
    ```
* fix errors in the package info 
    ```matlab
    >> fi.fix_pkginfo(pkg_name, only_fix_missing_values); % only_fix_missing_vlaues (default: true) is a boolean value
    ```
* list all installed packages 
    ```matlab
    >> fi.list_installed(); 
    ```

* show the path of F-image 
    ```matlab
    >> fi.home_dir(); 
    ```
* push changes to the github repo 
  ```matlab
  >> fi.push_github(); 
  ```
* update F-image 
    ```matlab
    >> fi.selfupdate(); 
    ```

## Add a new package
You need two steps to add a package to F-image
1. create a json file **pkgname_matlab.json** (see [template.json](https://github.com/zhoupc/F-image/blob/master/pkgmanage/pkginfo/template.json))  and save it to the folder **F-image/pkgname/pkginfo**. You can also provide these info in the command window, 
    ```matlab
    >> fi.add_pkginfo(pkg_name); 
    ```
    Here are some [example json files](https://github.com/zhoupc/F-image/tree/master/pkgmanage/pkginfo). 

    The package won't be installed until you run

    ```matlab 
    >> fi.install(pkg_name) 
    ```


2. configure the way of using the package, which usually simply add the package path to the MATLAB searching paths (default option). If you need some special configurations, modify the file **+fi/usepkg.m**, where you can find example configurations.  
    ```matlab 
    >> edit fi.usepkg   
    ```

    
## Copyright 
[Pengcheng Zhou](https://zhoupc.github.io) @Columbia University, 2019
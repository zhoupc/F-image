# F-image
F-image is a package management system used to install and manage software packages written for functional image analysis.

## why F-image?
There are many independently developed toolboxes for processing functional imaging data. Some functions can be reused by other packages. F-image can automatically install and load the selected packages for specific tasks. All the packages were maintained by F-image to save your time. 

**Example**
```matlab 
fi = Fimage(); 
fi.install('cnmfe');   # install CNMF-E 
fi.usepkg('cnmfe');    # use CNMF-E functions in your code. 
```

## Goals
* **simplify** the step of installing and using packages of functional image analysis (mainly calcium/voltage imaging for now). 
  
* **share** customized pipeline for processing one type of data. A complete pipeline usually calls multiple packages. It can simply tell F-image which packages to be installed and used. 
  
* **reduce** the effort of developing your packages by reusing other packages. All you need to do is running `fi.install(pkg_name); fi.usepkg(pkg_name)` 
* **community** curated toolboxes for reproducible researches. 
  
## Installation
Open MATLAB and set the current working directly to the place you want to install F-image, then run the following command 
```matlab 
try
    system('git clone https://github.com/zhoupc/F-image.git');
catch
    unzip('https://github.com/zhoupc/F-image/archive/master.zip');
    movefile('F-image-master', 'F-image')
end
cd F-image;
fimage_setup; 
```

## How to use 
Here we use [CNMF-E](https://github.com/zhoupc/CNMF_E) as an example to show how F-image manage packages. 
```matlab 
>> pkg_name = 'cnmfe'; 
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
* list all installed packages 
    ```matlab
    >> fi.list_installed(); 
    ```

* list all supported packages 
    ```matlab 
    >> fi.list_supported(); 
    ```

## Supported packages 
```matlab
fi = Fimage(); 
fi.list_supported(); 
```
[**currently supported packages** (01/19/2019)](https://github.com/zhoupc/F-image/blob/master/supported_packages.md)

## Add a new package
All you need to do is adding a json file **pkgname_matlab.json** to the folder **F-image/pkgname/pkginfo**. The package won't be installed until you run `fi.install(pkg_name)`. [Example json files](https://github.com/zhoupc/F-image/tree/master/pkgmanage/pkginfo). 

Here is a template for writing json file
```json 
{
  "name": "The package name",
  "version": "package version",
  "description": "package description",
  "repository": {
    "type": "git/zip",
    "url": "*.git link or *.zip link", 
    "platform_dependent": false, 
    "url_mac": "link for mac OS", 
    "url_unix": "link for linux/unix system",
    "url_pc": "link for windows PC"
  },
  "author": {
    "name": "who developed the package", 
    "email": ""
    }, 
  "license": "package license",
  "references": "package reference; use Harvard style; use ; to separate multiple references", 
  "added_by": "your name"
}
```
There is an extra step for configuring the way of using package, which usually does the job of adding the package path to the MATLAB searching paths. You can do so by editing the file **usepkg.m**
```matlab 
>> edit Fimage/usepkg.m       % Fimage\usepkg.m for Windows computer 
```

**Once you added the support to one package, please update the README file as well and send us a pull request.**


## Copyright 
[Pengcheng Zhou](zhoupc.github.io), Columbia University, 2019
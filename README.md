# F-image
F-image is a package management system used to install and manage software packages written for functional image analysis.

## why F-image?
There are many independently developed toolboxes for processing functional imaging data. Some functions can be reused by other packages. F-image can automatically install and load the selected packages for specific tasks. All the packages were maintained by F-image to save your time. 

see example below 
```matlab 
fi = Fimage(); 
fi.install('cnmfe');   # install CNMF-E 
fi.usepkg('cnmfe');    # use CNMF-E functions in your code. 
```

## Goals
* **simplify** the step of installing and using packages for processing functional imaging data (mainly calcium/voltage imaging for now). 
  
* **share** customized pipeline for processing one type of data. A complete pipeline usually calls multiple packages. It can simply tell F-image which packages to be installed and used. 
  
* **reduce** the development effort by reusing other packages. All you need to do is running `fi.install(pkg_name); fi.usepkg(pkg_name)` 
* **community** maintained toolboxes for reproducible researches. 
  
## Installation
Open MATLAB and set the current working directly to the place you want to install F-image, then run the following command 
```matlab 
try
    system('git clone https://github.com/zhoupc/F-image.git .');
catch
    unzip('https://github.com/zhoupc/F-image/archive/master.zip');
end
cd F-image;
fimage_setup; 
```

## How to use 
The first step of using F-image is to create a class object by running 

```matlab 
>> fi = Fimage(); 
```

Then you can do many things relating to the specific packages. Here we use [CNMF-E](https://github.com/zhoupc/CNMF_E) as an example. 
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
    >> fi.remove(pkg_name)
    ```
* update a package 
    ```matlab
    >> fi.update(pkg_name)
    ```
* get the package path 
  ```matlab 
  >> pkg_path = fi.locate(pkg_name)
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
**currently supported packages** (01/19/2019)

|package name   | short name  |description| reference|added by |
|---|---|---|---|---|
| CNMF-E  | cnmfe  | [Constrained Nonnegative Matrix Factorization for microEndoscopic data. 'E' also suggests 'extension'. It is built on top of CNMF with supports to 1 photon data.](https://github.com/zhoupc/CNMF_E)| Zhou, P., Resendez, S.L., Rodriguez-Romaguera, J., Jimenez, J.C., Neufeld, S.Q., Giovannucci, A., Friedrich, J., Pnevmatikakis, E.A., Stuber, G.D., Hen, R. and Kheirbek, M.A., 2018. Efficient and accurate extraction of in vivo calcium signals from microendoscopic video data. ELife, 7, p.e28728.|Pengcheng Zhou|
|OASIS|oasis|[Fast online deconvolution of calcium imaging data](https://github.com/zhoupc/OASIS_matlab)|Friedrich, J., Zhou, P. and Paninski, L., 2017. Fast online deconvolution of calcium imaging data. PLoS computational biology, 13(3), p.e1005423.|Pengcheng Zhou|
||||

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
  "license": "package license"
}
```
There is an extra step for configuring the way of using package, which usually does the job of adding the package path to the MATLAB searching paths. You can do so by editing the file **usepkg.m**
```matlab 
>> edit Fimage/usepkg.m       % Fimage\usepkg.m for Windows computer 
```

**Once you added the support to one package, please update the README file as well and send us a pull request.**


## Copyright 
[Pengcheng Zhou](zhoupc.github.io), Columbia University, 2019
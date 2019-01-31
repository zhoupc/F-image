try
    system('git clone https://github.com/zhoupc/F-image.git .');
catch
    unzip('https://github.com/zhoupc/F-image/archive/master.zip');
end
cd F-image;
fimage_setup; 
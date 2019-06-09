%直方图均衡化处理
imgDataPath = 'C:\Users\kiking\Desktop\train_1\';
imgDataDir  = dir(imgDataPath);             % 遍历所有文件
for i = 1:length(imgDataDir)
    if(isequal(imgDataDir(i).name,'.')||... % 去除系统自带的两个隐文件夹
       isequal(imgDataDir(i).name,'..')||...
       ~imgDataDir(i).isdir)                % 去除遍历中不是文件夹的
           continue;
    end
    imgDir = dir([imgDataPath imgDataDir(i).name '\*.jpg']); 
    for j =1:length(imgDir)                 % 遍历所有图片
        %img = imread([imgDataPath imgDataDir(i).name '\' imgDir(j).name]);
        %imgeq = histeq(img);
        %imwrite(imgeq,[imgDataPath imgDataDir(i).name '\' imgDir(j).name]);
        %[X, MAP] = imread([imgDataPath imgDataDir(i).name '\' imgDir(j).name]);
        %RGB = ind2rgb(X,MAP);
        RGB = imread([imgDataPath imgDataDir(i).name '\' imgDir(j).name]);
        LAB = rgb2lab(RGB);
        L = LAB(:,:,1)/100;
        L = adapthisteq(L,'NumTiles',[8 8],'ClipLimit',0.005);
        LAB(:,:,1) = L*100;
        J = lab2rgb(LAB);
        imwrite(J,[imgDataPath imgDataDir(i).name '\' imgDir(j).name]);
        %figure
        %imshowpair(RGB,J,'montage')
        %title('Original (left) and Contrast Enhanced (right) Image')
    end
end
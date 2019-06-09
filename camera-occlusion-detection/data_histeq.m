%直方图均衡化处理
imgDataPath = 'a\';
imgDataDir  = dir(imgDataPath);             % 遍历所有文件
for i = 1:length(imgDataDir)
    if(isequal(imgDataDir(i).name,'.')||... % 去除系统自带的两个隐文件夹
       isequal(imgDataDir(i).name,'..')||...
       ~imgDataDir(i).isdir)                % 去除遍历中不是文件夹的
           continue;
    end
    imgDir = dir([imgDataPath imgDataDir(i).name '\*.jpg']); 
    for j =1:length(imgDir)                 % 遍历所有图片
        img = imread([imgDataPath imgDataDir(i).name '\' imgDir(j).name]);%gpuArray
        imgeq = histeq(img);
        imwrite(imgeq,[imgDataPath imgDataDir(i).name '\' imgDir(j).name]);
    end
end
%直方图均衡化处理
imgDataPath = 'C:\Users\kiking\Desktop\357\';
imgDataDir  = dir(imgDataPath);             % 遍历所有文件
for i = 1:length(imgDataDir)
    if(isequal(imgDataDir(i).name,'.')||... % 去除系统自带的两个隐文件夹
       isequal(imgDataDir(i).name,'..')||...
       ~imgDataDir(i).isdir)                % 去除遍历中不是文件夹的
           continue;
    end
    imgDir = dir([imgDataPath imgDataDir(i).name '\*.jpg']); 
    for j =1:length(imgDir)                 % 遍历所有图片
        img = imread([imgDataPath imgDataDir(i).name '\' imgDir(j).name]);
        %imgeq = histeq(img);
        imgdouble = double(img);
        [m n]=size(imgdouble);

        Fe=1;   %控制参数
        Fd=128;

       xmax=max(max(imgdouble));
       u=(1+(xmax-imgdouble)/Fd).^(-Fe);     %空间域变换到模糊域

       %也可以多次迭代 
       for ii=1:m                       %模糊域增强算子
          for jj=1:n
             if u(ii,jj)<0.5
               u(ii,jj)=2*u(ii,jj)^2; 
             else
              u(ii,jj)=1-2*(1-u(ii,jj))^2;
             end
          end
       end

       imgmohu = xmax-Fd.*(u.^(-1/Fe)-1);    %模糊域变换回空间域
       imwrite(uint8(imgmohu),[imgDataPath imgDataDir(i).name '\' imgDir(j).name]);
    end
end

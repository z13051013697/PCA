function [imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson, nPerson, bTest)
% 200幅人脸图像转换为向量形式，进而生成对应的矩阵样本（向量化操作）
% 读入ORL人脸库的指定数目的人脸前五张(用于训练，后五张用于测试)，像素大小为112*92
%
% 输入：nFacesPerPerson --- 每个人需要读入的样本数，默认值为 5
%       nPerson --- 需要读入的人数，默认为全部 40 个人
%       bTest --- bool型的参数。默认为0，表示读入训练样本（前5张）；如果为1，表示读入测试样本（后5张）
%
% 输出：FaceContainer --- 向量化人脸容器，(nFacesPerPerson*nPerson) * 10304 的 2 维矩阵，每行对应一个人脸向量
%       faceLabel    --- 个体人脸标号 1—40号

if nargin==0 %default value
    nFacesPerPerson=5;%前5张用于训练
    nPerson=40;%要读入的人数（每人共10张，前5张用于训练）
    bTest = 0;
elseif nargin < 3
    bTest = 0;
end

imgFindDim=imread('Data/ORL/S1/1.pgm');%为了获得图片尺寸先读入一张
[imgRow,imgCol]=size(imgFindDim);%112*92


FaceContainer = zeros(nFacesPerPerson*nPerson, imgRow*imgCol);%200*10304
%FaceContainer =[];
faceLabel = zeros(nFacesPerPerson*nPerson, 1);%200*1

% 读入训练数据
for i=1:nPerson
    if mod(i,10)==0
        i
    end
    i1=mod(i,10); % 个位
    i0=char(i/10);%取十位上的数，i0可能取值：0,1,2,3,4
    strPath='Data/ORL/S';
    if( i0~=0 )
        strPath=strcat(strPath,'0'+i0);%strcat()不能连接两位数，如'0'+12，所以要把nPerson的个位与十位分开来连接
    end
    strPath=strcat(strPath,'0'+i1);
    strPath=strcat(strPath,'/');
    tempStrPath=strPath;
    for j=1:nFacesPerPerson
        strPath=tempStrPath;
        
        if bTest == 0 % 读入训练数据
            strPath = strcat(strPath, '0'+j);
        else
            strPath = strcat(strPath, num2str(j+5));
        end
        
        strPath=strcat(strPath,'.pgm');
        img=imread(strPath);
       
        %把读入的图像按列存储为行向量放入向量化人脸容器faceContainer的对应行中
        FaceContainer((i-1)*nFacesPerPerson+j, :) = img(:)';%img转置
        %FaceContainer =[FaceContainer ;img(:)'];
        faceLabel((i-1)*nFacesPerPerson+j) = i;
    end % j
end % i

% 保存人脸样本FaceContainer矩阵到FaceMat.mat文件中去
if bTest == 0
save('Mat/FaceMat.mat', 'FaceContainer','faceLabel')
elseif bTest == 1
end







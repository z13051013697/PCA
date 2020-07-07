function [imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson, nPerson, bTest)
% 200������ͼ��ת��Ϊ������ʽ���������ɶ�Ӧ�ľ���������������������
% ����ORL�������ָ����Ŀ������ǰ����(����ѵ�������������ڲ���)�����ش�СΪ112*92
%
% ���룺nFacesPerPerson --- ÿ������Ҫ�������������Ĭ��ֵΪ 5
%       nPerson --- ��Ҫ�����������Ĭ��Ϊȫ�� 40 ����
%       bTest --- bool�͵Ĳ�����Ĭ��Ϊ0����ʾ����ѵ��������ǰ5�ţ������Ϊ1����ʾ���������������5�ţ�
%
% �����FaceContainer --- ����������������(nFacesPerPerson*nPerson) * 10304 �� 2 ά����ÿ�ж�Ӧһ����������
%       faceLabel    --- ����������� 1��40��

if nargin==0 %default value
    nFacesPerPerson=5;%ǰ5������ѵ��
    nPerson=40;%Ҫ�����������ÿ�˹�10�ţ�ǰ5������ѵ����
    bTest = 0;
elseif nargin < 3
    bTest = 0;
end

imgFindDim=imread('Data/ORL/S1/1.pgm');%Ϊ�˻��ͼƬ�ߴ��ȶ���һ��
[imgRow,imgCol]=size(imgFindDim);%112*92


FaceContainer = zeros(nFacesPerPerson*nPerson, imgRow*imgCol);%200*10304
%FaceContainer =[];
faceLabel = zeros(nFacesPerPerson*nPerson, 1);%200*1

% ����ѵ������
for i=1:nPerson
    if mod(i,10)==0
        i
    end
    i1=mod(i,10); % ��λ
    i0=char(i/10);%ȡʮλ�ϵ�����i0����ȡֵ��0,1,2,3,4
    strPath='Data/ORL/S';
    if( i0~=0 )
        strPath=strcat(strPath,'0'+i0);%strcat()����������λ������'0'+12������Ҫ��nPerson�ĸ�λ��ʮλ�ֿ�������
    end
    strPath=strcat(strPath,'0'+i1);
    strPath=strcat(strPath,'/');
    tempStrPath=strPath;
    for j=1:nFacesPerPerson
        strPath=tempStrPath;
        
        if bTest == 0 % ����ѵ������
            strPath = strcat(strPath, '0'+j);
        else
            strPath = strcat(strPath, num2str(j+5));
        end
        
        strPath=strcat(strPath,'.pgm');
        img=imread(strPath);
       
        %�Ѷ����ͼ���д洢Ϊ������������������������faceContainer�Ķ�Ӧ����
        FaceContainer((i-1)*nFacesPerPerson+j, :) = img(:)';%imgת��
        %FaceContainer =[FaceContainer ;img(:)'];
        faceLabel((i-1)*nFacesPerPerson+j) = i;
    end % j
end % i

% ������������FaceContainer����FaceMat.mat�ļ���ȥ
if bTest == 0
save('Mat/FaceMat.mat', 'FaceContainer','faceLabel')
elseif bTest == 1
end







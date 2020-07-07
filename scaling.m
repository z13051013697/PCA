function [SVFM, lowVec, upVec] = scaling(VecFeaMat, bTest, lRealBVec, uRealBVec)
% PCA��ά֮��������������ݵĹ�񻯣���Χ[-1,+1]
% Input:  VecFeaMat --- ��Ҫscaling�� m*n ά���ݾ���ÿ��һ��������������������Ϊά��
%         bTest ---  =1��˵���Ƕ��ڲ�����������scaling����ʱ�����ṩ lRealBVec �� uRealBVec
%                       ��ֵ���˶�ֵӦ�����ڶ�ѵ������ scaling ʱ�õ���
%                    =0��Ĭ��ֵ����ѵ���������� scaling
%         lRealBVec --- nά��������ѵ������ scaling ʱ�õ��ĸ�ά��ʵ��������Ϣ
%         uRealBVec --- nά��������ѵ������ scaling ʱ�õ��ĸ�ά��ʵ��������Ϣ
%         source ---0����1,0��ʾmyPCA��1��ʾTDPCA
%
% output: SVFM --- VecFeaMat�� scaling �汾
%         lowVec --- ��ά����������(ֻ�ڶ�ѵ������scalingʱ�����壬bTest = 0)
%         upVec --- ��ά����������(ֻ�ڶ�ѵ������scalingʱ�����壬bTest = 0)
%         
% ѵ����[SVFM, lowVec, upVec] = scaling(VecFeaMat),��(FastSCORE)
% ���ԣ�[SVFM] = scaling(VecFeaMat, 1, lRealBVec, uRealBVec)
%**************************************************************************
if nargin < 2
    bTest = 0;
end

% ����Ŀ�귶Χ[-1, 1]
lTargB = -1;
uTargB = 1;


[m , n] = size(VecFeaMat);

SVFM = zeros(m, n);

if bTest
    if nargin < 4
        error('ѵ��ʱ����Ҫ��������');
    end
    
    if nargout > 1
        error('����ʱ��ֻ��һ�������');
    end

    for iCol = 1:n
        if uRealBVec(iCol) == lRealBVec(iCol)
            SVFM(:, iCol) = uRealBVec(iCol);
            SVFM(:, iCol) = 0;
        else
            SVFM(:, iCol) = lTargB  +  ( VecFeaMat(:, iCol) - lRealBVec(iCol) ) / ( uRealBVec(iCol)-lRealBVec(iCol) ) * (uTargB-lTargB); % �������ݵ�scaling
        end
    end
else
    upVec = zeros(1, n);
    lowVec = zeros(1, n);


    for iCol = 1:n
        lowVec(iCol) = min( VecFeaMat(:, iCol) );
        upVec(iCol) = max( VecFeaMat(:, iCol) );
        if upVec(iCol) == lowVec(iCol)
            SVFM(:, iCol) = upVec(iCol);
            SVFM(:, iCol) = 0;
        else
            SVFM(:, iCol) = lTargB  +  ( VecFeaMat(:, iCol) - lowVec(iCol) ) / ( upVec(iCol)-lowVec(iCol) ) * (uTargB-lTargB); % ѵ�����ݵ�scaling
        end
    end
    save('Mat/scaling.mat','SVFM', 'lowVec', 'upVec');
end


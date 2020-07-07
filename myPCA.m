function [ FastSCORE , FastCOEFF ] = myPCA( SampleMatrix , KDim )
tic;
[r c] = size(SampleMatrix);
% ������ֵ
meanVec = mean(SampleMatrix);%1*c
Z = (SampleMatrix-repmat(meanVec, r, 1));
covMatT = Z * Z';
% ���� covMatT ��ǰ KDim �����������ͱ���ֵ
[FastCOEFF D] = eigs(covMatT, KDim);%FastCOEFF����������
FastCOEFF = Z' * FastCOEFF;%10304*KDim
for i=1:KDim
    FastCOEFF(:,i)=FastCOEFF(:,i)/norm(FastCOEFF(:,i));
end
% ���Ա任��ͶӰ����ά�� k ά
FastSCORE = Z * FastCOEFF;%200*KDim
toc;
% ����任���� FastCOEFF �ͱ任ԭ�� meanVec
save('Mat/fastPCA.mat', 'FastCOEFF', 'meanVec','FastSCORE');



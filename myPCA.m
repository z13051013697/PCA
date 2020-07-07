function [ FastSCORE , FastCOEFF ] = myPCA( SampleMatrix , KDim )
tic;
[r c] = size(SampleMatrix);
% 样本均值
meanVec = mean(SampleMatrix);%1*c
Z = (SampleMatrix-repmat(meanVec, r, 1));
covMatT = Z * Z';
% 计算 covMatT 的前 KDim 个本征向量和本征值
[FastCOEFF D] = eigs(covMatT, KDim);%FastCOEFF本征向量，
FastCOEFF = Z' * FastCOEFF;%10304*KDim
for i=1:KDim
    FastCOEFF(:,i)=FastCOEFF(:,i)/norm(FastCOEFF(:,i));
end
% 线性变换（投影）降维至 k 维
FastSCORE = Z * FastCOEFF;%200*KDim
toc;
% 保存变换矩阵 FastCOEFF 和变换原点 meanVec
save('Mat/fastPCA.mat', 'FastCOEFF', 'meanVec','FastSCORE');



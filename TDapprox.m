function [ xApprox ] = TDapprox( originalSample, k )
% 用 k 个主成分分量来近似（重建）样本 originalSample, k<=nDim
%
% 输入：originalSample --- 原特征空间中的样本，被近似的对象（人脸原始图）
%       k --- 近似（重建）使用的主成分分量数目（降为k维）
%
% 输出：xApprox --- 样本的近似（重建）

% 读入 TDPCA 变换矩阵 和 平均脸
load('Mat/TDPCA5.mat');

xApprox = meanDataVector;% 行向量

for dimNum = 1:k
    xApprox=xApprox+reshape(((reshape(originalSample,112,92)-meanData)*eigvectors(:,dimNum))*eigvectors(:,dimNum)',1,10304);
end


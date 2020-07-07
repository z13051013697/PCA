function [ xApprox ] = approx( originalSample, k )
% �� k �����ɷַ��������ƣ��ؽ������� originalSample
%
% ���룺originalSample --- ԭ�����ռ��е������������ƵĶ�������ԭʼͼ��
%       k --- ���ƣ��ؽ���ʹ�õ����ɷַ�����Ŀ����Ϊkά��
%
% �����xApprox --- �����Ľ��ƣ��ؽ���

% ���� PCA �任���� FastCOEFF �� ƽ���� meanVec
load Mat/fastPCA.mat

nLen = length(originalSample);

xApprox = meanVec;% ������

for dimNum = 1:k
    xApprox=xApprox+((originalSample-meanVec)*FastCOEFF(:,dimNum))*FastCOEFF(:,dimNum)';
end


function [ xApprox ] = TDapprox( originalSample, k )
% �� k �����ɷַ��������ƣ��ؽ������� originalSample, k<=nDim
%
% ���룺originalSample --- ԭ�����ռ��е������������ƵĶ�������ԭʼͼ��
%       k --- ���ƣ��ؽ���ʹ�õ����ɷַ�����Ŀ����Ϊkά��
%
% �����xApprox --- �����Ľ��ƣ��ؽ���

% ���� TDPCA �任���� �� ƽ����
load('Mat/TDPCA5.mat');

xApprox = meanDataVector;% ������

for dimNum = 1:k
    xApprox=xApprox+reshape(((reshape(originalSample,112,92)-meanData)*eigvectors(:,dimNum))*eigvectors(:,dimNum)',1,10304);
end


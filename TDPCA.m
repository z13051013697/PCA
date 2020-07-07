
function [eigvectors, eigvalues, meanData, newTrainData, newTestData] = TDPCA(trainData, testData, height, width, nDim)


if nargin ~= 5
    error('usage: TDPCA(trainData, testData, height, width, numvecs)');
end;
tic;
[nSample,nFeature] = size(trainData);%nSam = 10, nFea = 10304

fprintf(1,'Computing average matrix...\n');
meanDataVector = mean(trainData);% 1*10304
meanData = reshape(meanDataVector,height,width);% 112*92平均脸

fprintf(1,'Calculating matrix differences from avg and 2DPCA covariance matrix L...\n');
L = zeros(width,width);%92*92 ,以列为单位
ddata = zeros(nSample,nFeature);%200*10304
for i = 1:nSample
    ddata(i,:) = double(trainData(i,:))-meanDataVector;%个体差异脸 中心化样本矩阵，%1*10304
    dummyMat = reshape(ddata(i,:),height,width);% 112*92
    L = L + dummyMat'*dummyMat;%92*92 ，协方差矩阵运算
end;
L = L/nSample;
L = (L + L')/2;


fprintf(1,'Calculating eigenvectors of L...\n');
[eigvectors,eigvalues] = eig(L);

fprintf(1,'Sorting eigenvectors according to eigenvalues...\n');
[eigvectors,eigvalues] = TDSortem(eigvectors,eigvalues);%eigvalues为降序排列
eigvalues = diag(eigvalues);%对角矩阵化

fprintf(1,'Normalize Vectors to unit length, kill vectors corr. to tiny evalues...\n');
num_good = 0;
for i = 1:size(eigvectors,2)%1:nDim
    eigvectors(:,i) = eigvectors(:,i)/norm(eigvectors(:,i));%本征向量每一列都分别归一化
    if eigvalues(i) < 0.00001   % 基本不会发生
        % Set the vector to the 0 vector; set the value to 0.
        eigvalues(i) = 0;
        eigvectors(:,i) = zeros(size(eigvectors,1),1);%本征值为0则相应列向量置为0
    else
        num_good = num_good + 1;
    end;
end;
if (nDim > num_good)
    fprintf(1,'Warning: numvecs is %d; only %d exist.\n',nDim,num_good);
    nDim = num_good;
end;
eigvectors = eigvectors(:,1:nDim);
% 到这里为止，处理时间和myPCA相差无几，0.06s~0.075s

if nargout == 5
fprintf(1,'Feature extraction and calculating new training and testing data...\n');
%trainData
newTrainData = zeros(nSample,height*nDim);% 200,112*nDim
for i = 1:nSample
    dummyMat = reshape(ddata(i,:),height,width);% 112*92，ddata是1*10304
    newTrainData(i,:) = reshape(dummyMat*eigvectors,1,height*nDim);% 表征人脸特征的数据，同FastSCORE，用这个做scaling之后去SVM训练
end

%testData
nTestSample = size(testData,1);
newTestData = zeros(nTestSample,height*nDim);
tdata = zeros(size(testData));
for i = 1:nTestSample
    tdata(i,:) = double(testData(i,:))-meanDataVector; % 1*10304
    dummyMat = reshape(tdata(i,:),height,width); % 112*92
    newTestData(i,:) = reshape(dummyMat*eigvectors,1,height*nDim);% 表征人脸特征的数据，同FastSCORE，用这个做scaling之后去SVM分类
end;
toc;
disp('2DPCA计算结束');


elseif nargout ~= 5
fprintf(1,'Feature extraction and  new training and testing data ignored...\n');
toc;
disp('2DPCA计算结束');
end


if nargout == 5
save('Mat/TDPCA5.mat','eigvectors', 'eigvalues', 'meanData','meanDataVector', 'newTrainData', 'newTestData');
elseif nargout == 3
    save('Mat/TDPCA3.mat','eigvectors', 'eigvalues', 'meanData');
end

% nDim = 20的情况下grid.py计算得到的参数值c=128,gamma=0.00012207,最佳参数值
% nDim = 5,测试集中错误识别个数为18个,对于测试集200个人脸样本的识别率为91%
% nDim = 4,测试集中错误识别个数为19个,对于测试集200个人脸样本的识别率为90.5%
% nDim = 3,测试集中错误识别个数为20个,对于测试集200个人脸样本的识别率为90%
% nDim = 8，测试集中错误识别个数为21个,对于测试集200个人脸样本的识别率为89.5%
% nDim = 6,测试集中错误识别个数为21个,对于测试集200个人脸样本的识别率为89.5%
% nDim = 2,测试集中错误识别个数为25个,对于测试集200个人脸样本的识别率为87.5%
% nDim = 10,测试集中错误识别个数为27个,对于测试集200个人脸样本的识别率为86.5%
% nDim = 12,测试集中错误识别个数为30个,对于测试集200个人脸样本的识别率为85%
% nDim = 16,测试集中错误识别个数为31个,对于测试集200个人脸样本的识别率为84.5%
% nDim = 1,测试集中错误识别个数为33个,对于测试集200个人脸样本的识别率为83.5%
% nDim = 32,测试集中错误识别个数为48个,对于测试集200个人脸样本的识别率为76%




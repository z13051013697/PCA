
function [eigvectors, eigvalues, meanData, newTrainData, newTestData] = TDPCA(trainData, testData, height, width, nDim)


if nargin ~= 5
    error('usage: TDPCA(trainData, testData, height, width, numvecs)');
end;
tic;
[nSample,nFeature] = size(trainData);%nSam = 10, nFea = 10304

fprintf(1,'Computing average matrix...\n');
meanDataVector = mean(trainData);% 1*10304
meanData = reshape(meanDataVector,height,width);% 112*92ƽ����

fprintf(1,'Calculating matrix differences from avg and 2DPCA covariance matrix L...\n');
L = zeros(width,width);%92*92 ,����Ϊ��λ
ddata = zeros(nSample,nFeature);%200*10304
for i = 1:nSample
    ddata(i,:) = double(trainData(i,:))-meanDataVector;%��������� ���Ļ���������%1*10304
    dummyMat = reshape(ddata(i,:),height,width);% 112*92
    L = L + dummyMat'*dummyMat;%92*92 ��Э�����������
end;
L = L/nSample;
L = (L + L')/2;


fprintf(1,'Calculating eigenvectors of L...\n');
[eigvectors,eigvalues] = eig(L);

fprintf(1,'Sorting eigenvectors according to eigenvalues...\n');
[eigvectors,eigvalues] = TDSortem(eigvectors,eigvalues);%eigvaluesΪ��������
eigvalues = diag(eigvalues);%�ԽǾ���

fprintf(1,'Normalize Vectors to unit length, kill vectors corr. to tiny evalues...\n');
num_good = 0;
for i = 1:size(eigvectors,2)%1:nDim
    eigvectors(:,i) = eigvectors(:,i)/norm(eigvectors(:,i));%��������ÿһ�ж��ֱ��һ��
    if eigvalues(i) < 0.00001   % �������ᷢ��
        % Set the vector to the 0 vector; set the value to 0.
        eigvalues(i) = 0;
        eigvectors(:,i) = zeros(size(eigvectors,1),1);%����ֵΪ0����Ӧ��������Ϊ0
    else
        num_good = num_good + 1;
    end;
end;
if (nDim > num_good)
    fprintf(1,'Warning: numvecs is %d; only %d exist.\n',nDim,num_good);
    nDim = num_good;
end;
eigvectors = eigvectors(:,1:nDim);
% ������Ϊֹ������ʱ���myPCA����޼���0.06s~0.075s

if nargout == 5
fprintf(1,'Feature extraction and calculating new training and testing data...\n');
%trainData
newTrainData = zeros(nSample,height*nDim);% 200,112*nDim
for i = 1:nSample
    dummyMat = reshape(ddata(i,:),height,width);% 112*92��ddata��1*10304
    newTrainData(i,:) = reshape(dummyMat*eigvectors,1,height*nDim);% �����������������ݣ�ͬFastSCORE���������scaling֮��ȥSVMѵ��
end

%testData
nTestSample = size(testData,1);
newTestData = zeros(nTestSample,height*nDim);
tdata = zeros(size(testData));
for i = 1:nTestSample
    tdata(i,:) = double(testData(i,:))-meanDataVector; % 1*10304
    dummyMat = reshape(tdata(i,:),height,width); % 112*92
    newTestData(i,:) = reshape(dummyMat*eigvectors,1,height*nDim);% �����������������ݣ�ͬFastSCORE���������scaling֮��ȥSVM����
end;
toc;
disp('2DPCA�������');


elseif nargout ~= 5
fprintf(1,'Feature extraction and  new training and testing data ignored...\n');
toc;
disp('2DPCA�������');
end


if nargout == 5
save('Mat/TDPCA5.mat','eigvectors', 'eigvalues', 'meanData','meanDataVector', 'newTrainData', 'newTestData');
elseif nargout == 3
    save('Mat/TDPCA3.mat','eigvectors', 'eigvalues', 'meanData');
end

% nDim = 20�������grid.py����õ��Ĳ���ֵc=128,gamma=0.00012207,��Ѳ���ֵ
% nDim = 5,���Լ��д���ʶ�����Ϊ18��,���ڲ��Լ�200������������ʶ����Ϊ91%
% nDim = 4,���Լ��д���ʶ�����Ϊ19��,���ڲ��Լ�200������������ʶ����Ϊ90.5%
% nDim = 3,���Լ��д���ʶ�����Ϊ20��,���ڲ��Լ�200������������ʶ����Ϊ90%
% nDim = 8�����Լ��д���ʶ�����Ϊ21��,���ڲ��Լ�200������������ʶ����Ϊ89.5%
% nDim = 6,���Լ��д���ʶ�����Ϊ21��,���ڲ��Լ�200������������ʶ����Ϊ89.5%
% nDim = 2,���Լ��д���ʶ�����Ϊ25��,���ڲ��Լ�200������������ʶ����Ϊ87.5%
% nDim = 10,���Լ��д���ʶ�����Ϊ27��,���ڲ��Լ�200������������ʶ����Ϊ86.5%
% nDim = 12,���Լ��д���ʶ�����Ϊ30��,���ڲ��Լ�200������������ʶ����Ϊ85%
% nDim = 16,���Լ��д���ʶ�����Ϊ31��,���ڲ��Լ�200������������ʶ����Ϊ84.5%
% nDim = 1,���Լ��д���ʶ�����Ϊ33��,���ڲ��Լ�200������������ʶ����Ϊ83.5%
% nDim = 32,���Լ��д���ʶ�����Ϊ48��,���ڲ��Լ�200������������ʶ����Ϊ76%




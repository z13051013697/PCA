function test()
% 测试myPCA算法对于整个测试集的识别率
%
% 输出：accuracy --- 对于测试集合的识别率


display(' ');
display(' ');
display('测试开始...');
 h_waitbar = waitbar(0.23,'计算中，请稍后...');

nFacesPerPerson = 5;
nPerson = 40;
bTest = 1;
tic;
% 读入测试集合
display('读入测试集合...');
[imgRow,imgCol,TestFace,testLabel] = ReadFaces(nFacesPerPerson, nPerson, bTest);
display('..............................');

% 读入相关训练结果
display('载入训练参数...');
load('Mat/fastPCA.mat');
load('Mat/scaling.mat');
load('Mat/FaceMat.mat');
load('Mat/multiSVMparams.mat');
display('..............................');

% PCA降维
display('PCA降维处理...');
[m n] = size(TestFace);% 200*10304

TestFace = (TestFace-repmat(meanVec, m, 1))*FastCOEFF; % 经过pca变换降维
TestFace = scaling(TestFace,1,lowVec, upVec);
display('..............................');

% 多类 SVM 分类
display('测试集识别中...');
classes = multiSVMClassify(TestFace);
display('..............................');
toc;
% 计算识别率
nError = sum(classes ~= testLabel);
display(['测试集中错误识别个数为',num2str(nError),'个']);
accuracy = 1 - nError/length(testLabel);
display(['对于测试集',num2str(nFacesPerPerson* nPerson),'个人脸样本的识别率为', num2str(accuracy*100), '%']);
msgbox(['总体测试识别率为：',num2str(accuracy*100), '%。']);
close(h_waitbar);



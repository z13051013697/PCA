function TDtest()
% 测试TDPCA算法对于整个测试集的识别率
%
% 输出：accuracy --- 对于测试集合的识别率

display(' ');
display(' ');
display('TDPCA测试开始...');
h_waitbar = waitbar(0.23,'计算中，请稍后...');

nFacesPerPerson = 5;
nPerson = 40;
bTest = 1;
tic;
% 读入测试集合
display('TDPCA载入训练参数...');
load('Mat/FaceMat.mat');
load('Mat/scaling.mat');
load('Mat/TDmultiSVMparams.mat');
load('Mat/TDTestFaces.mat');
display('..............................');

newTestData = scaling(newTestData,1,lowVec, upVec);
% 多类 SVM 分类
display('TDPCA测试集识别中...');
classes = multiSVMClassify(newTestData,multiSVMStruct);
display('..............................');
toc;
% 计算识别率
display('识别工作完成，开始计算识别率....');
nError = sum(classes ~= faceLabel);
display(['测试集中错误识别个数为',num2str(nError),'个']);
accuracy = 1 - nError/length(faceLabel);
display(['对于测试集',num2str(nFacesPerPerson* nPerson),'个人脸样本的识别率为', num2str(accuracy*100), '%']);
msgbox(['总体测试识别率为：',num2str(accuracy*100), '%。']);
if ~isempty(h_waitbar)
close(h_waitbar);
end
end


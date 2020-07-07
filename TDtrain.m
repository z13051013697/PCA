function TDtrain(nPerson,nFacesPerPerson,kDim )
%  整个训练过程，包括读入图像，TDPCA降维和多分类SVM训练

global imgRow;
global imgCol;

if nargin == 0
    nPerson = 40;
    nFacesPerPerson = 5;
    kDim = 20;
end

display('TDPCA读入人脸图像数据库...');

[imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson, nPerson, 0);
[imgRowTest,imgColTest,FaceContainerTest,faceLabelTest]=ReadFaces(nFacesPerPerson, nPerson, 1);
display('***********人脸读入完成，开始TDPCA计算*************');

[eigvectors, eigvalues, meanData, newTrainData, newTestData] = TDPCA(FaceContainer, FaceContainerTest, imgRow,imgCol, kDim);
save('Mat/TDTestFaces.mat','newTestData');
display('*************TDPCA人脸特征数据归一化处理*************');
[SVFM, lowVec, upVec] = scaling(newTrainData);

display('*************一对一投票策略的SVM分类器训练*************');
nSampPerClass = nFacesPerPerson*ones(nPerson,1);
multiSVMStruct = multiSVMTrain(SVFM, nSampPerClass, nPerson, 128, 0.00012207,1);

msgbox('2DPCA样本训练完成');
end


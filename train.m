function  train(nPerson,nFacesPerPerson,kDim )
%  整个训练过程，包括读入图像，PCA降维和多分类SVM训练   
global imgRow;
global imgCol;

display('读入人脸图像数据库...');

[imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson, nPerson, 0);
display('***********人脸读入完成，开始PCA降维*************');

[ FastSCORE , FastCOEFF ] = myPCA( FaceContainer , kDim );

display('*************人脸特征数据归一化处理*************');
[SVFM, lowVec, upVec] = scaling(FastSCORE);

display('*************一对一投票策略的SVM分类器训练*************');
nSampPerClass = nFacesPerPerson*ones(nPerson,1);
multiSVMStruct = multiSVMTrain(SVFM, nSampPerClass, nPerson, 128, 0.0078125,0);
msgbox('PCA样本训练完成');
end


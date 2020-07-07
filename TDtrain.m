function TDtrain(nPerson,nFacesPerPerson,kDim )
%  ����ѵ�����̣���������ͼ��TDPCA��ά�Ͷ����SVMѵ��

global imgRow;
global imgCol;

if nargin == 0
    nPerson = 40;
    nFacesPerPerson = 5;
    kDim = 20;
end

display('TDPCA��������ͼ�����ݿ�...');

[imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson, nPerson, 0);
[imgRowTest,imgColTest,FaceContainerTest,faceLabelTest]=ReadFaces(nFacesPerPerson, nPerson, 1);
display('***********����������ɣ���ʼTDPCA����*************');

[eigvectors, eigvalues, meanData, newTrainData, newTestData] = TDPCA(FaceContainer, FaceContainerTest, imgRow,imgCol, kDim);
save('Mat/TDTestFaces.mat','newTestData');
display('*************TDPCA�����������ݹ�һ������*************');
[SVFM, lowVec, upVec] = scaling(newTrainData);

display('*************һ��һͶƱ���Ե�SVM������ѵ��*************');
nSampPerClass = nFacesPerPerson*ones(nPerson,1);
multiSVMStruct = multiSVMTrain(SVFM, nSampPerClass, nPerson, 128, 0.00012207,1);

msgbox('2DPCA����ѵ�����');
end


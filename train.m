function  train(nPerson,nFacesPerPerson,kDim )
%  ����ѵ�����̣���������ͼ��PCA��ά�Ͷ����SVMѵ��   
global imgRow;
global imgCol;

display('��������ͼ�����ݿ�...');

[imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson, nPerson, 0);
display('***********����������ɣ���ʼPCA��ά*************');

[ FastSCORE , FastCOEFF ] = myPCA( FaceContainer , kDim );

display('*************�����������ݹ�һ������*************');
[SVFM, lowVec, upVec] = scaling(FastSCORE);

display('*************һ��һͶƱ���Ե�SVM������ѵ��*************');
nSampPerClass = nFacesPerPerson*ones(nPerson,1);
multiSVMStruct = multiSVMTrain(SVFM, nSampPerClass, nPerson, 128, 0.0078125,0);
msgbox('PCA����ѵ�����');
end


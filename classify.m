function result = classify( facePath,nType)
% ʶ��һ���������
% facePath:����ͼ��·��
% nClass:�������
% nType:����myPCA����TDPCA 0Ϊǰ�ߣ�1Ϊ����
% ����result = classify( 'H:\������\ORL\s22\4.pgm');

display('��ʼʶ�������...');
load('Mat/scaling.mat');
load('Mat/FaceMat.mat');
tic;
if nType == 0
load('Mat/fastPCA.mat');
load('Mat/multiSVMparams.mat');
elseif nType == 1
    load('Mat/TDPCA5.mat');
    load('Mat/TDmultiSVMparams.mat');
end
display('�����������...');

if nType == 0
testFace = ReadAFace(facePath);
testFace = double(testFace);
testFace = (testFace- meanVec ) * FastCOEFF;% ����û�е�һ��
testFace = scaling(testFace,1,lowVec, upVec);
elseif nType == 1
    testFace = ReadAFace(facePath);
    testFace = double(testFace);
    testFace = (reshape(testFace,112,92)- meanData ) * eigvectors;
    testFace = reshape(testFace,1,112*size(eigvectors,2));
    testFace = scaling(testFace,1,lowVec, upVec);
end
display('�������ݴ������...��ʼʶ��...');
result = multiSVMClassify(testFace, multiSVMStruct);
toc;
display('ʶ�������...');
display(['���Ϊ��' num2str(result), '��']);

end


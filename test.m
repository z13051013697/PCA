function test()
% ����myPCA�㷨�����������Լ���ʶ����
%
% �����accuracy --- ���ڲ��Լ��ϵ�ʶ����


display(' ');
display(' ');
display('���Կ�ʼ...');
 h_waitbar = waitbar(0.23,'�����У����Ժ�...');

nFacesPerPerson = 5;
nPerson = 40;
bTest = 1;
tic;
% ������Լ���
display('������Լ���...');
[imgRow,imgCol,TestFace,testLabel] = ReadFaces(nFacesPerPerson, nPerson, bTest);
display('..............................');

% �������ѵ�����
display('����ѵ������...');
load('Mat/fastPCA.mat');
load('Mat/scaling.mat');
load('Mat/FaceMat.mat');
load('Mat/multiSVMparams.mat');
display('..............................');

% PCA��ά
display('PCA��ά����...');
[m n] = size(TestFace);% 200*10304

TestFace = (TestFace-repmat(meanVec, m, 1))*FastCOEFF; % ����pca�任��ά
TestFace = scaling(TestFace,1,lowVec, upVec);
display('..............................');

% ���� SVM ����
display('���Լ�ʶ����...');
classes = multiSVMClassify(TestFace);
display('..............................');
toc;
% ����ʶ����
nError = sum(classes ~= testLabel);
display(['���Լ��д���ʶ�����Ϊ',num2str(nError),'��']);
accuracy = 1 - nError/length(testLabel);
display(['���ڲ��Լ�',num2str(nFacesPerPerson* nPerson),'������������ʶ����Ϊ', num2str(accuracy*100), '%']);
msgbox(['�������ʶ����Ϊ��',num2str(accuracy*100), '%��']);
close(h_waitbar);



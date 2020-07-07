function TDtest()
% ����TDPCA�㷨�����������Լ���ʶ����
%
% �����accuracy --- ���ڲ��Լ��ϵ�ʶ����

display(' ');
display(' ');
display('TDPCA���Կ�ʼ...');
h_waitbar = waitbar(0.23,'�����У����Ժ�...');

nFacesPerPerson = 5;
nPerson = 40;
bTest = 1;
tic;
% ������Լ���
display('TDPCA����ѵ������...');
load('Mat/FaceMat.mat');
load('Mat/scaling.mat');
load('Mat/TDmultiSVMparams.mat');
load('Mat/TDTestFaces.mat');
display('..............................');

newTestData = scaling(newTestData,1,lowVec, upVec);
% ���� SVM ����
display('TDPCA���Լ�ʶ����...');
classes = multiSVMClassify(newTestData,multiSVMStruct);
display('..............................');
toc;
% ����ʶ����
display('ʶ������ɣ���ʼ����ʶ����....');
nError = sum(classes ~= faceLabel);
display(['���Լ��д���ʶ�����Ϊ',num2str(nError),'��']);
accuracy = 1 - nError/length(faceLabel);
display(['���ڲ��Լ�',num2str(nFacesPerPerson* nPerson),'������������ʶ����Ϊ', num2str(accuracy*100), '%']);
msgbox(['�������ʶ����Ϊ��',num2str(accuracy*100), '%��']);
if ~isempty(h_waitbar)
close(h_waitbar);
end
end


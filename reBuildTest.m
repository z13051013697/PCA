% �������ɷַ�������ĳһ���������ؽ�
% myPCA��TDPCA֮�������л�
load Mat/FaceMat.mat

x = FaceContainer(1,:);                               %ѡ��ԭʼ����
displayImage(x,112,92);                                %��ʾ����ԭͼ
%[FastSCORE,FastCOEFF] = myPCA(FaceContainer , 200);
[eigvectors, eigvalues, meanData, newTrainData, newTestData] = TDPCA(FaceContainer,FaceContainer, 112, 92, 92);
xApprox = TDapprox(x , 20);              % TDapprox  vs  approx                
displayImage(xApprox,112,92);
xApprox = TDapprox(x , 30);                              
displayImage(xApprox,112,92);
xApprox = TDapprox(x , 50);                              
displayImage(xApprox,112,92);
xApprox = TDapprox(x , 80);
displayImage(xApprox,112,92);
xApprox = TDapprox(x , 92);                             
displayImage(xApprox,112,92);
disp('������Ʋ����С��');
distance = norm(xApprox - x)
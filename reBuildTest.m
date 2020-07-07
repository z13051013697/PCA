% 基于主成分分量进行某一个人脸的重建
% myPCA和TDPCA之间随意切换
load Mat/FaceMat.mat

x = FaceContainer(1,:);                               %选择原始人脸
displayImage(x,112,92);                                %显示人脸原图
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
disp('计算近似差异大小：');
distance = norm(xApprox - x)
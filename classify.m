function result = classify( facePath,nType)
% 识别一张人脸类别
% facePath:人脸图像路径
% nClass:所属类别
% nType:采用myPCA还是TDPCA 0为前者，1为后者
% 例如result = classify( 'H:\人脸库\ORL\s22\4.pgm');

display('开始识别此人脸...');
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
display('参数载入完成...');

if nType == 0
testFace = ReadAFace(facePath);
testFace = double(testFace);
testFace = (testFace- meanVec ) * FastCOEFF;% 书上没有的一句
testFace = scaling(testFace,1,lowVec, upVec);
elseif nType == 1
    testFace = ReadAFace(facePath);
    testFace = double(testFace);
    testFace = (reshape(testFace,112,92)- meanData ) * eigvectors;
    testFace = reshape(testFace,1,112*size(eigvectors,2));
    testFace = scaling(testFace,1,lowVec, upVec);
end
display('人脸数据处理完成...开始识别...');
result = multiSVMClassify(testFace, multiSVMStruct);
toc;
display('识别工作完成...');
display(['类别为：' num2str(result), '类']);

end


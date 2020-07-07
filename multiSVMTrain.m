function multiSVMStruct = multiSVMTrain(SVFM, nSampPerClass, nClass, C, gamma,source)

% 采用1对1投票策略将 SVM 推广至多类问题的训练过程，将多类SVM训练结果保存至multiSVMStruct中
%
% 输入:--SVFM:每行是一个样本人脸（规格化后的）
%     --nClass:人数，即类别数
%     --nSampPerClass:nClass*1维的向量，记录每类的样本数目，如 nSampPerClass(iClass)
%     给出了第iClass类的样本数目，nSampPerClass =每类的样本数目*ones(nClass,1);
%     --C:错误代价系数，默认为 Inf
%     --gamma:径向基核函数的参数 gamma，默认值为1
%     --source:PCA算法模型数据来源选择，默认0为myPCA，1为TDPCA
%
% 输出:--multiSVMStruct:一个包含多类SVM训练结果的结构体，1x1


tic;
%开始训练，需要计算每两类间的分类超平面，共(nClass-1)*nClass/2个
fprintf(1,'开始训练，需要计算每两类间的分类超平面，共%d个...\n',(nClass-1)*nClass/2);
for ii=1:(nClass-1)
    if mod(ii,10)==0||ii==39
        ii
    end
    for jj=(ii+1):nClass
        clear X;
        clear Y;
        startPosII = sum( nSampPerClass(1:ii-1) ) + 1;
        endPosII = startPosII + nSampPerClass(ii) - 1;
        X(1:nSampPerClass(ii), :) = SVFM(startPosII:endPosII, :);
            
        startPosJJ = sum( nSampPerClass(1:jj-1) ) + 1;
        endPosJJ = startPosJJ + nSampPerClass(jj) - 1;
        X(nSampPerClass(ii)+1:nSampPerClass(ii)+nSampPerClass(jj), :) = SVFM(startPosJJ:endPosJJ, :);
        
        
        % 设定两两分类时的类标签
        Y = ones(nSampPerClass(ii) + nSampPerClass(jj), 1);
        Y(nSampPerClass(ii)+1:nSampPerClass(ii)+nSampPerClass(jj)) = 0;
        
        % 第ii个人和第jj个人两两分类时的分类器结构信息
        CASVMStruct{ii}{jj}= svmtrain( X, Y, 'Kernel_Function', @(X,Y) kfun_rbf(X,Y,gamma), 'boxconstraint', C );
     end
end

% 已学得的分类结果
fprintf(1,'记录已学得的分类结果\n');
multiSVMStruct.nClass = nClass;
multiSVMStruct.CASVMStruct = CASVMStruct;
toc;
% 保存参数
display('*************保存SVM训练结果*************');
if source == 0
save('Mat/multiSVMparams.mat','multiSVMStruct', 'C', 'gamma');
elseif source == 1
    save('Mat/TDmultiSVMparams.mat','multiSVMStruct', 'C', 'gamma');
end
toc;






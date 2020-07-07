function multiSVMStruct = multiSVMTrain(SVFM, nSampPerClass, nClass, C, gamma,source)

% ����1��1ͶƱ���Խ� SVM �ƹ������������ѵ�����̣�������SVMѵ�����������multiSVMStruct��
%
% ����:--SVFM:ÿ����һ��������������񻯺�ģ�
%     --nClass:�������������
%     --nSampPerClass:nClass*1ά����������¼ÿ���������Ŀ���� nSampPerClass(iClass)
%     �����˵�iClass���������Ŀ��nSampPerClass =ÿ���������Ŀ*ones(nClass,1);
%     --C:�������ϵ����Ĭ��Ϊ Inf
%     --gamma:������˺����Ĳ��� gamma��Ĭ��ֵΪ1
%     --source:PCA�㷨ģ��������Դѡ��Ĭ��0ΪmyPCA��1ΪTDPCA
%
% ���:--multiSVMStruct:һ����������SVMѵ������Ľṹ�壬1x1


tic;
%��ʼѵ������Ҫ����ÿ�����ķ��೬ƽ�棬��(nClass-1)*nClass/2��
fprintf(1,'��ʼѵ������Ҫ����ÿ�����ķ��೬ƽ�棬��%d��...\n',(nClass-1)*nClass/2);
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
        
        
        % �趨��������ʱ�����ǩ
        Y = ones(nSampPerClass(ii) + nSampPerClass(jj), 1);
        Y(nSampPerClass(ii)+1:nSampPerClass(ii)+nSampPerClass(jj)) = 0;
        
        % ��ii���˺͵�jj������������ʱ�ķ������ṹ��Ϣ
        CASVMStruct{ii}{jj}= svmtrain( X, Y, 'Kernel_Function', @(X,Y) kfun_rbf(X,Y,gamma), 'boxconstraint', C );
     end
end

% ��ѧ�õķ�����
fprintf(1,'��¼��ѧ�õķ�����\n');
multiSVMStruct.nClass = nClass;
multiSVMStruct.CASVMStruct = CASVMStruct;
toc;
% �������
display('*************����SVMѵ�����*************');
if source == 0
save('Mat/multiSVMparams.mat','multiSVMStruct', 'C', 'gamma');
elseif source == 1
    save('Mat/TDmultiSVMparams.mat','multiSVMStruct', 'C', 'gamma');
end
toc;






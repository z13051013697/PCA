function class = multiSVMClassify(TestFace, multiSVMStruct)
% 采用1对1投票策略将 SVM 推广至多类问题的分类过程
% 输入:--TestFace:测试样本集。m*n 的2维矩阵，每行一个测试样本
%     --multiSVMStruct:多类SVM的训练结果，由函数 multiSVMTrain 返回，默认是从Mat/multiSVMTrain.mat文件中读取
%
% 输出:--class: m*1 列向量，对应 TestFace 的类标签


% 读入训练结果
if nargin < 2
    t = dir('Mat/multiSVMparams.mat');
    if isempty(t)
        error('没有找到训练结果文件，请在分类以前首先进行训练！');
    end
    load('Mat/multiSVMparams.mat');
end

nClass = multiSVMStruct.nClass; % 读入类别数
CASVMStruct = multiSVMStruct.CASVMStruct; % 读入两两类之间的分类器信息



%%%%%%%%%%%%%%%%%%%%%%%% 投票策略解决多类问题 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m = size(TestFace, 1);
Voting = zeros(m, nClass); % m个测试样本，每个样本nPerson 个类别的投票箱

for iIndex = 1:nClass-1
    for jIndex = iIndex+1:nClass
        classes = svmclassify(CASVMStruct{iIndex}{jIndex}, TestFace);

        % 投票
        Voting(:, iIndex) = Voting(:, iIndex) + (classes == 1);
        Voting(:, jIndex) = Voting(:, jIndex) + (classes == 0);
                
    end % for jClass
end % for iClass



% final decision by voting result
[vecMaxVal, class] = max( Voting, [], 2 );
save('Mat/class.mat','class');
%display(sprintf('TestFace对应的类别是:%d',class));



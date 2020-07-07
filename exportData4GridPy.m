function exportData4GridPy(strMat, strLibSVM)
%**************************************************************************
% 数据集格式化为grid.py所要求的形式，文本文件：
% <类别标签>  <特征索引1>：<特征值1>  <特征索引2>：<特征值2>...<特征索引n>：<特征值n>
% ...
% ...
% 以参数 strMat 指定的文件中的数据导出能够被 LibSVM 使用的格式，生成的文件名由
% 参数 strLibSVM 指定
%
% 输入：strMat --- 源文件名（包括路径），'.mat'文件，myPCA默认为trainDataGrid_Py，
% 其中包含scaling后的训练数据SVFM 和类标签 faceLabel，该文件可在训练 SVM 过程中生成
%       strLibSVM --- 目标文件名，'.txt'文件，myPCA为'trainDataGrid_Py.txt'
%                                           TDPCA为‘TDtrainDataGrid_Py.txt’

if nargin < 1
    strMat = '../Mat/trainDataGrid_Py.mat';
    strLibSVM = 'trainDataGrid_Py.txt';
elseif nargin < 2
    strLibSVM = 'trainDataGrid_Py.txt';
end
disp('建立目标输出文件...');
[fid, fMsg ] = fopen(strLibSVM, 'w'); % 建立目标输出文件
if fid == -1
    disp(fMsg );
    return
end

strNewLine = [13 10]; % 换行
strBlank = ' ';
    
load(strMat)

[nSamp, nDim] = size( SVFM );

disp('生成grid.py数据集...');
for iSamp = 1:nSamp
    fwrite(fid, num2str(faceLabel(iSamp)), 'char');
    if mod(iSamp,10) == 0
        iSamp
    end
    for iDim = 1:nDim
        fwrite(fid, strBlank, 'char');
        fwrite(fid, [num2str(iDim) ':'], 'char');
        fwrite(fid, num2str(SVFM(iSamp, iDim)), 'char');        
    end
    
    fwrite(fid, strNewLine, 'char');
end

fclose(fid);
disp('grid.py数据集准备完毕');




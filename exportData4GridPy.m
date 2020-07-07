function exportData4GridPy(strMat, strLibSVM)
%**************************************************************************
% ���ݼ���ʽ��Ϊgrid.py��Ҫ�����ʽ���ı��ļ���
% <����ǩ>  <��������1>��<����ֵ1>  <��������2>��<����ֵ2>...<��������n>��<����ֵn>
% ...
% ...
% �Բ��� strMat ָ�����ļ��е����ݵ����ܹ��� LibSVM ʹ�õĸ�ʽ�����ɵ��ļ�����
% ���� strLibSVM ָ��
%
% ���룺strMat --- Դ�ļ���������·������'.mat'�ļ���myPCAĬ��ΪtrainDataGrid_Py��
% ���а���scaling���ѵ������SVFM �����ǩ faceLabel�����ļ�����ѵ�� SVM ����������
%       strLibSVM --- Ŀ���ļ�����'.txt'�ļ���myPCAΪ'trainDataGrid_Py.txt'
%                                           TDPCAΪ��TDtrainDataGrid_Py.txt��

if nargin < 1
    strMat = '../Mat/trainDataGrid_Py.mat';
    strLibSVM = 'trainDataGrid_Py.txt';
elseif nargin < 2
    strLibSVM = 'trainDataGrid_Py.txt';
end
disp('����Ŀ������ļ�...');
[fid, fMsg ] = fopen(strLibSVM, 'w'); % ����Ŀ������ļ�
if fid == -1
    disp(fMsg );
    return
end

strNewLine = [13 10]; % ����
strBlank = ' ';
    
load(strMat)

[nSamp, nDim] = size( SVFM );

disp('����grid.py���ݼ�...');
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
disp('grid.py���ݼ�׼�����');




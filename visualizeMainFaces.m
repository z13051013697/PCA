function visualizeMainFaces(E)
% 显示主成分分量（主成分脸，即变换空间中的基向量e1,e2,e3,e4...en），以imgRow * imgCol的分辨率来显示出来
%
% 输入：E --- 矩阵，每一列是一个主成分分量，维数和主成分维数一致


[size1 size2] = size(E);
global imgRow; % 112
global imgCol; % 92
row = imgRow
col = imgCol

 if size2 ~= 20
   display('********显示 不为20 个主成分********');
 end

figure
img = zeros(row, col);
%colormap(gray);
for faceNum = 1:10         %20个主成分
    img(:) = E(:, faceNum);
    subplot(4, 5, faceNum);
    imshow(img, []);
end




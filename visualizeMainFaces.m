function visualizeMainFaces(E)
% ��ʾ���ɷַ��������ɷ��������任�ռ��еĻ�����e1,e2,e3,e4...en������imgRow * imgCol�ķֱ�������ʾ����
%
% ���룺E --- ����ÿһ����һ�����ɷַ�����ά�������ɷ�ά��һ��


[size1 size2] = size(E);
global imgRow; % 112
global imgCol; % 92
row = imgRow
col = imgCol

 if size2 ~= 20
   display('********��ʾ ��Ϊ20 �����ɷ�********');
 end

figure
img = zeros(row, col);
%colormap(gray);
for faceNum = 1:10         %20�����ɷ�
    img(:) = E(:, faceNum);
    subplot(4, 5, faceNum);
    imshow(img, []);
end




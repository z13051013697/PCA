% GUIRecgFaceImage.m
if isempty(filepath)|filepath == 0;
    msgbox('路径错误，或者未选择人脸图片！');
else
    h_waitbar = waitbar(0.23,'计算中，请稍后...');
nClass = classify(filepath,0);
msgbox( ['所属类别为:',num2str(nClass)] );
close(h_waitbar);
axes(h_axes2);
f = imread(['Data/ORL/S',num2str(nClass),'/1.pgm']); % 打开该人的第1幅图像
imshow(f);
filepath = 0;
end
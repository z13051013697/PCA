% GUIRecgFaceImage.m
if isempty(filepath)|filepath == 0;
    msgbox('·�����󣬻���δѡ������ͼƬ��');
else
    h_waitbar = waitbar(0.23,'�����У����Ժ�...');
nClass = classify(filepath,0);
msgbox( ['�������Ϊ:',num2str(nClass)] );
close(h_waitbar);
axes(h_axes2);
f = imread(['Data/ORL/S',num2str(nClass),'/1.pgm']); % �򿪸��˵ĵ�1��ͼ��
imshow(f);
filepath = 0;
end
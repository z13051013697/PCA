% GUIOpenFaceImage.m

global filepath;
[filename, pathname] = uigetfile({'*.pgm;*.jpg;*tif', '(*.pgm), (*.jpg), (*.tif)'; ...
   '*.*', 'All Files(*.*)' }, '选择一张用于测试的人脸');
if filename~=0
    filepath = [pathname,filename];
    axes(h_axes1);
    imshow(imread(filepath));
end

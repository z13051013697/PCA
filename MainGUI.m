close all;clear all;
% FR_GUI.m
global h_axes1;
global h_axes2;
val_choice=1;

h_f = figure('name', 'PCA和2DPCA人脸识别');

%两个编辑框，C和Gamma
h_textC = uicontrol(h_f, 'style', 'text', 'Units', 'normalized', 'string', '系数C：', 'position',...
    [0.05 0.55 0.1 0.05],'BackgroundColor', [.8 .8 .8],'FontSize', 10);
h_editC = uicontrol(h_f, 'style', 'edit', 'Units', 'normalized', 'position', [0.05 0.5 0.15 0.05],...
     'FontSize', 10,'BackgroundColor', [.5 .8 .5],'callback', 'C = str2num(get(h_editC, ''string''))');
h_textGamma = uicontrol(h_f, 'style', 'text', 'Units', 'normalized', 'string', 'Gamma：', 'position',...
    [0.05 0.45 0.1 0.05],'BackgroundColor', [.8 .8 .8],'FontSize', 10);
h_editGamma = uicontrol(h_f, 'style', 'edit', 'Units', 'normalized', 'position', [0.05 0.4 0.15 0.05],...
   'FontSize', 10,'BackgroundColor', [.5 .8 .5], 'callback', 'Gamma = str2num(get(h_editGamma, ''string''))');


% 取得参数 C 和 gamma 的当前值，即最近一次训练所使用的值
t = dir('Mat/params.mat');
if isempty(t)
    % 没有找到参数文件
    C = Inf;
    gamma = 1;
else
    load Mat/params.mat;
end

set(h_editC, 'string', num2str(C));
set(h_editGamma, 'string', num2str(gamma));

%显示图像的区域
h_axes1 = axes('parent', h_f, 'position', [0.25 0.2 0.32 0.6], 'visible', 'on');
h_axes2 = axes('parent', h_f, 'position', [0.62 0.2 0.32 0.6], 'visible', 'on');

%指示文字
h_textTargetFace = uicontrol(h_f, 'style', 'text', 'Units', 'normalized', 'string', '目标识别脸', 'position',...
    [0.30 0.05 0.2 0.04],'BackgroundColor', [.6 .6 .8],'FontSize', 12);
h_textResultFace = uicontrol(h_f, 'style', 'text', 'Units', 'normalized', 'string', '识别类别脸', 'position',...
    [0.66 0.05 0.2 0.04],'BackgroundColor', [.6 .6 .8],'FontSize', 12);


%四个按钮
h_btnOpen = uicontrol(h_f, 'style', 'pushbutton', 'string', '打开人脸', 'Units', 'normalized',...
     'FontSize', 11,'position', [0.05 0.3 0.15 0.07], 'callback', 'GUIOpenFaceImage');
h_btnRecg = uicontrol(h_f, 'style', 'pushbutton', 'string', 'PCA识别', 'Units', 'normalized',...
     'FontSize', 11,'position', [0.05 0.2 0.15 0.07], 'callback', 'GUIRecgFaceImage');
 h_btnRecg = uicontrol(h_f, 'style', 'pushbutton', 'string', '2DPCA识别', 'Units', 'normalized',...
     'FontSize', 11,'position', [0.05 0.1 0.15 0.07], 'callback', 'GUIRecgFaceImage_2DPCA');
h_btnTrain_1 = uicontrol(h_f, 'style', 'pushbutton', 'string', 'PCA训练', 'Units', 'normalized',...
     'FontSize', 12,'position', [0.32 0.83 0.18 0.1], 'callback', 'train(40, 5, 20)');
 h_btnTrain_2 = uicontrol(h_f, 'style', 'pushbutton', 'string', '2D-PCA训练', 'Units', 'normalized',...
     'FontSize', 12,'position', [0.67 0.83 0.18 0.1], 'callback', 'TDtrain(40, 5, 5)');
h_btnTest1 = uicontrol(h_f, 'style', 'pushbutton', 'string', '2DPCA识别率', 'Units', 'normalized',...
   'FontSize', 12, 'position', [0.03 0.83 0.2 0.1], 'callback', 'TDtest');
h_btnTest2 = uicontrol(h_f, 'style', 'pushbutton', 'string', 'PCA识别率', 'Units', 'normalized',...
   'FontSize', 12, 'position', [0.03 0.7 0.18 0.1], 'callback', 'test');



close all;clear all;
% FR_GUI.m
global h_axes1;
global h_axes2;
val_choice=1;

h_f = figure('name', 'PCA��2DPCA����ʶ��');

%�����༭��C��Gamma
h_textC = uicontrol(h_f, 'style', 'text', 'Units', 'normalized', 'string', 'ϵ��C��', 'position',...
    [0.05 0.55 0.1 0.05],'BackgroundColor', [.8 .8 .8],'FontSize', 10);
h_editC = uicontrol(h_f, 'style', 'edit', 'Units', 'normalized', 'position', [0.05 0.5 0.15 0.05],...
     'FontSize', 10,'BackgroundColor', [.5 .8 .5],'callback', 'C = str2num(get(h_editC, ''string''))');
h_textGamma = uicontrol(h_f, 'style', 'text', 'Units', 'normalized', 'string', 'Gamma��', 'position',...
    [0.05 0.45 0.1 0.05],'BackgroundColor', [.8 .8 .8],'FontSize', 10);
h_editGamma = uicontrol(h_f, 'style', 'edit', 'Units', 'normalized', 'position', [0.05 0.4 0.15 0.05],...
   'FontSize', 10,'BackgroundColor', [.5 .8 .5], 'callback', 'Gamma = str2num(get(h_editGamma, ''string''))');


% ȡ�ò��� C �� gamma �ĵ�ǰֵ�������һ��ѵ����ʹ�õ�ֵ
t = dir('Mat/params.mat');
if isempty(t)
    % û���ҵ������ļ�
    C = Inf;
    gamma = 1;
else
    load Mat/params.mat;
end

set(h_editC, 'string', num2str(C));
set(h_editGamma, 'string', num2str(gamma));

%��ʾͼ�������
h_axes1 = axes('parent', h_f, 'position', [0.25 0.2 0.32 0.6], 'visible', 'on');
h_axes2 = axes('parent', h_f, 'position', [0.62 0.2 0.32 0.6], 'visible', 'on');

%ָʾ����
h_textTargetFace = uicontrol(h_f, 'style', 'text', 'Units', 'normalized', 'string', 'Ŀ��ʶ����', 'position',...
    [0.30 0.05 0.2 0.04],'BackgroundColor', [.6 .6 .8],'FontSize', 12);
h_textResultFace = uicontrol(h_f, 'style', 'text', 'Units', 'normalized', 'string', 'ʶ�������', 'position',...
    [0.66 0.05 0.2 0.04],'BackgroundColor', [.6 .6 .8],'FontSize', 12);


%�ĸ���ť
h_btnOpen = uicontrol(h_f, 'style', 'pushbutton', 'string', '������', 'Units', 'normalized',...
     'FontSize', 11,'position', [0.05 0.3 0.15 0.07], 'callback', 'GUIOpenFaceImage');
h_btnRecg = uicontrol(h_f, 'style', 'pushbutton', 'string', 'PCAʶ��', 'Units', 'normalized',...
     'FontSize', 11,'position', [0.05 0.2 0.15 0.07], 'callback', 'GUIRecgFaceImage');
 h_btnRecg = uicontrol(h_f, 'style', 'pushbutton', 'string', '2DPCAʶ��', 'Units', 'normalized',...
     'FontSize', 11,'position', [0.05 0.1 0.15 0.07], 'callback', 'GUIRecgFaceImage_2DPCA');
h_btnTrain_1 = uicontrol(h_f, 'style', 'pushbutton', 'string', 'PCAѵ��', 'Units', 'normalized',...
     'FontSize', 12,'position', [0.32 0.83 0.18 0.1], 'callback', 'train(40, 5, 20)');
 h_btnTrain_2 = uicontrol(h_f, 'style', 'pushbutton', 'string', '2D-PCAѵ��', 'Units', 'normalized',...
     'FontSize', 12,'position', [0.67 0.83 0.18 0.1], 'callback', 'TDtrain(40, 5, 5)');
h_btnTest1 = uicontrol(h_f, 'style', 'pushbutton', 'string', '2DPCAʶ����', 'Units', 'normalized',...
   'FontSize', 12, 'position', [0.03 0.83 0.2 0.1], 'callback', 'TDtest');
h_btnTest2 = uicontrol(h_f, 'style', 'pushbutton', 'string', 'PCAʶ����', 'Units', 'normalized',...
   'FontSize', 12, 'position', [0.03 0.7 0.18 0.1], 'callback', 'test');



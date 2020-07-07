function h_btnTrain_Callback(hObject, eventdata, handles)
    switch get(handles.h_menuPCA,'Value')
    case 1
        train(40, 5, 20);
    case 2
        TDtrain(40,5,5);
    end
end
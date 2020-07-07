 function menucall(menu,event)
        % Called when user activates popup menu 
        val = get(menu,'Value');
        if val ==1
            display('选择了ORL人脸库');
            msg = msgbox('选择了ORL人脸库');
        elseif val == 2
            display('选择了FERET人脸库');
        elseif val == 3
            display('选择了PIE人脸库');
        elseif val == 4
            display('选择了自定义人脸库');
        end
    end

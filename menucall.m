 function menucall(menu,event)
        % Called when user activates popup menu 
        val = get(menu,'Value');
        if val ==1
            display('ѡ����ORL������');
            msg = msgbox('ѡ����ORL������');
        elseif val == 2
            display('ѡ����FERET������');
        elseif val == 3
            display('ѡ����PIE������');
        elseif val == 4
            display('ѡ�����Զ���������');
        end
    end

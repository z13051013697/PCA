function menucallPCA(menu,event)
        % Called when user activates popup menu 
        val = get(menu,'Value');
        if val ==1
            display('ѡ����PCA�㷨');
        elseif val == 2
            display('ѡ����2D-PCA�㷨');
        end
    end


function menucallPCA(menu,event)
        % Called when user activates popup menu 
        val = get(menu,'Value');
        if val ==1
            display('选择了PCA算法');
        elseif val == 2
            display('选择了2D-PCA算法');
        end
    end


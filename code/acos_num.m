% returns interior angle of triangle at this point
function theta = acos_num(cos_x)
    
    options = optimoptions('fsolve', 'Display', 'none', 'TolFun',eps);
    theta = fsolve(@(x) cos(x) - cos_x, pi/2, options);
    
    if theta < 0
        fprintf('acos_num < 0\n')
    end
    
    if theta > pi
        fprintf('acos_num > 0\n')
    end
    
end


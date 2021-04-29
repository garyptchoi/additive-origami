% returns interior angle of triangle at this point
function theta = asin_num(sin_x)
    
    options = optimoptions('fsolve','Display','none','TolFun',eps);
    theta = fsolve(@(x) sin(x) - sin_x, (sin_x+1)/2*pi-pi/2, options);
    
    if theta < -pi/2
        fprintf('acos_num < -pi/2\n')
    end
    
    if theta > pi/2
        fprintf('asin_num > pi/2\n')
    end
    
end


% returns interior angle of triangle at this point
function theta = atan2_num(y, x)
    
    norm_xy = norm([x y]);
    if -x <= y && y <= x
        theta = mod(asin_num(y/norm_xy), 2*pi);
    elseif y >= x && y >= -x
        theta = acos_num(x/norm_xy);
    elseif x <= y && y <= -x
        theta = pi - asin_num(y/norm_xy);
    else % y <= x && y <= -x
        theta = 2*pi - acos_num(x/norm_xy);
    end
    
end


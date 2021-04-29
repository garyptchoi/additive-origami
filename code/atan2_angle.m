function angle = atan2_angle(center, a, b, N)
% assumes cross(n, cross(a-center,b-center)) = 0
        
    A = normalize_these(a - center);
    B = normalize_these(b - center);        
    
    if length(A) < 3
        A = [A 0];
    end
    
    if length(B) < 3
        B = [B 0];
    end
    
    if nargin < 4
        N = cross(A,B);
    end
    N = N/norm(N);

    x = dot(A, B);
    y = dot(N, cross(A, B));
    
    angle = atan2_num(y, x);    

end


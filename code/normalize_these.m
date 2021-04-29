function rays = normalize_these(rays)

    for i = 1:size(rays,1)
        rays(i,:) = rays(i,:)/norm(rays(i,:));
    end
    
end


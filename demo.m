addpath(genpath('pattern'));
addpath(genpath('code'));

%% load a pattern

% choose one
name = 'peaks_coarse'; % a coarse version of F4A
% name = 'peaks_coarse2'; % another coarse version of F4A
% name = 'F4A'; % dense, take long time to read
% name = 'F4B';
% name = 'F4C';
% name = 'F4D';
% name = 'F4E';
% name = 'F4F';

% read the flat and folded states
[flat_points, flat_quads] = read_OBJ([name, '_flat.obj']);
[fold_points, fold_quads] = read_OBJ([name, '_fold.obj']);

%% plot the states

% flat 
plot_mesh(flat_points, flat_quads);
view([0,90]);

% folded
plot_mesh(fold_points, fold_quads);
view([0,30]);

%% Check planarity residuals at the folded state

num_quads = size(fold_quads,1);
planarity_residuals = zeros(num_quads,1);
for i = 1:num_quads
    
    quad = fold_quads(i,:);
    
    o = fold_points(quad(1),:);
    a = fold_points(quad(2),:);
    b = fold_points(quad(3),:);
    c = fold_points(quad(4),:);
    
    A = normalize_these(a - o);
    B = normalize_these(b - o);
    C = normalize_these(c - o);

    planarity_residuals(i) = dot(cross(A,B), C);

end

fprintf('max(abs planarity residuals) = %g\n', max(abs(planarity_residuals)));
fprintf('min(abs planarity residuals) = %g\n', min(abs(planarity_residuals)));

%% Check angle sum residuals at the folded state

rings = make_rings(fold_quads);
num_rings = size(rings,1);
angle_residuals = zeros(num_rings,1);
self_intersection_check = zeros(num_rings,1);
for i = 1:num_rings
   
    ring = rings(i,:);
    
    o = fold_points(ring(1),:);
    a = fold_points(ring(2),:);
    b = fold_points(ring(3),:);
    c = fold_points(ring(4),:);
    d = fold_points(ring(5),:);
    
    theta1 = atan2_angle(o, a, b);
    theta2 = atan2_angle(o, b, c);
    theta3 = atan2_angle(o, c, d);
    theta4 = atan2_angle(o, d, a);
    
    angle_residuals(i) = 2*pi - theta1 - theta2 - theta3 - theta4;
    
end

fprintf('max(abs angle sum residuals) = %g\n', max(abs(angle_residuals)));
fprintf('min(abs angle sum residuals) = %g\n', min(abs(angle_residuals)));






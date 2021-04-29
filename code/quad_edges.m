% edges: # edges x 2, unique edges in a quad mesh
% quad_adjs: # quad pairs x 2, quad adjacencies
% bound_nodes: # bound nodes x 1, all node indices on the boundary
function [edges, quad_adjs, interior_edges, boundary_edges] = quad_edges(quads)    

    % number of quads
    num_quads = size(quads,1);

    % make edges
    edges = [quads(:,[1 2]) (1:num_quads)'; ...
             quads(:,[2 3]) (1:num_quads)'; ...
             quads(:,[3 4]) (1:num_quads)'; ...
             quads(:,[4 1]) (1:num_quads)'];
    
    % first node in each edge should be smaller or equal
    edges(edges(:,1) > edges(:,2),[1 2]) = edges(edges(:,1) > edges(:,2),[2 1]);

    % sort edges and edge_points
    edges = sortrows(edges);
    
    % look at the difference between consecutive rows to find duplicates
    diff_edges = diff(edges);
    diff_edges = logical(cat(1,diff_edges(:,1) == 0 & diff_edges(:,2) == 0,0));

    % make boolean vector of all corresponding duplicate edge locations
    other_diff_edges = [false; diff_edges];
    other_diff_edges(end) = [];

    % you can combine diff_edges and other_diff_edges to identify boundaries
    interior_edges = logical(diff_edges + other_diff_edges);
    boundary_edges = edges(~interior_edges,:);
    interior_edges = edges(interior_edges,:);
    
    
    
    % boundary nodes are all of the nodes in boundary_edges
    bound_nodes = sort(unique(boundary_edges(:,[1 2])));
    
    % rearrange edges with interior edges first and boundary edges second
    % (recompute difference info)
    edges = [boundary_edges; interior_edges];
    diff_edges = diff(edges);
    diff_edges = logical(cat(1,diff_edges(:,1) == 0 & diff_edges(:,2) == 0,0));
    other_diff_edges = [false; diff_edges];
    other_diff_edges(end) = [];  
    
    % make list of quad adjacencies
    quad_adjs = [edges(diff_edges,3) edges(other_diff_edges,3)];
    
    % delete the redundant edges
    edges(diff_edges,:) = [];
    
    % remove the quad info from edges
    edges(:,3) = [];
    
    % keep only the unique interior_edges
    interior_edges = interior_edges(1:2:end, [1 2]);
    boundary_edges = boundary_edges(:,[1 2]);
    
end


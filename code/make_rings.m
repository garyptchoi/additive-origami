function rings = make_rings(quads)

    % get interior nodes
    [~,~,~,bound_edges] = quad_edges(quads);
    bound_nodes = unique(bound_edges);
    interior_nodes = 1:max(max(quads));
    interior_nodes(bound_nodes) = [];
    
    % build 1-rings
    rings = zeros(length(interior_nodes),5);

    % there will be a ring around every interior node
    for i = 1:length(interior_nodes)
        
        % get this node index
        this_node = interior_nodes(i);

        % get the quads at this node
        these_quads = quads(logical(sum(quads == this_node,2)),:);
        
        % order the quads into a 1-ring
        for j = 1:2            
            if length(intersect(these_quads(j,:), these_quads(j+1,:))) == 1
                these_quads([j+1 j+2],:) = these_quads([j+2 j+1],:);
            end            
        end
               
        % build the 1-ring
        this_ring = this_node;
        these_quads = these_quads';
        these_quads(these_quads == this_node) = [];
        these_quads = reshape(these_quads, 3, 4)';
        for j = 1:3
            this_ring = [this_ring intersect(these_quads(j,:), these_quads(j+1,:))];            
        end
        this_ring = [this_ring intersect(these_quads(1,:), these_quads(4,:))];
        
        % add this_ring to the rings
        rings(i,:) = this_ring;        

    end

    
end


function plot_mesh(points, faces)

    figure;
    patch('Faces',faces,'Vertices',points,'FaceColor',[153 255 153]/255,'EdgeColor','k', 'LineWidth',1);
    ax = gca;
    ax.Clipping = 'off';
    axis equal tight off
    
end
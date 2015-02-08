disp( 'Retrieving 2D Hela dataset from the Murphy Lab website' );
get_2D_hela_images();

disp( 'Retrieving subcellular location features for the 2D Hela collection' );
data = get_2D_hela_features();

indices = find(ismember(data.labels,'tubul'));
features = data.features(size(data.features,1)-length(indices)+1:end,:);

[sorted, indices, distances, numpc, pcntexplained] = typic( features );

directory = [ pwd filesep 'data' filesep 'images' filesep 'Microtubules' ];
files = dir( [ directory filesep '*.png' ] );

index = indices(1);
filename = files(index).name;
disp( [ 'The most typical image ' files(index).name ] );
img = imread( [directory filesep filename] );
imshow( img, [] );
title( [ 'The most typical image in the 2D ' ...
    'Hela microtubule dataset is ' files(index).name ] );
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
saveas(gcf,[pwd filesep 'typic_demo.png']);
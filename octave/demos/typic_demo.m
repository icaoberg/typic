function results = typic_demo()
% TYPIC_DEMO Typic demo that downloads

% Copyright (C) 2015 Ivan E. Cao-Berg
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published
% by the Free Software Foundation; either version 2 of the License,
% or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
% 02110-1301, USA.
%
% For additional information visit http://github.com/icaoberg or
% https://bitbucket.org/icaoberg

filename = which( 'typic_demo' );
[path,filename,extension] = fileparts( filename );
cd( path );

disp( 'Retrieving 2D Hela dataset from the Murphy Lab website' );
get_2D_hela_images();

disp( 'Loading subcellular location features for the 2D Hela collection' );
load( ['..' filesep 'data' filesep ...
    'HeLa10Class2DFeatures19990526.mat'] );

indices = find(ismember(data.labels,'tubul'));
features = data.features(size(data.features,1)-length(indices)+1:end,:);

tic
[sorted, indices, distances, numpc, pcntexplained ] = typic( features );
disp( 'TyPic runnig time' );
toc

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

delete( '*.tgz' );
rmdir( [ pwd filesep 'data' ], 's' );

results.features = features;
results.typic.sorted = sorted;
results.typic.indices = indices;
results.typic.distances = indices;
results.typic.number_of_principal_components = numpc;

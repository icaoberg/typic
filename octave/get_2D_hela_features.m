function data = get_2D_hela_features()

disp( 'Retrieving the 2D Hela SLF16 feature set' );
disp( 'Copyright (C) Murphy Lab' );
disp( 'Carnegie Mellon University' );

web_address = 'http://murphylab.web.cmu.edu/data/';
filename = 'HeLa10Class2DFeatures180.mat';
url = [ web_address filename ];

disp([ 'Downloading ' url ]);
if ~exist([ pwd filesep filename ])
    urlwrite( url, filename );
end

disp( ['Loading ' filename ] );
data = load([ pwd filesep filename ]);
end
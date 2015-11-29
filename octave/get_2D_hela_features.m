function data = get_2D_hela_features()
% GET_2D_HELA_FEATURES Loads The SLF4 features used in the ISMB and 
% Bioinformatics papers below.
%
% This function does not download the original CSV file. It uses an
% included mat file to allow compatibility between Matlab and Octave.
%
% Fluorescence microscope images of HeLa cells using ten different labels
%
% DAPI to label DNA
% a monoclonal antibody against an Endoplasmic Reticulum (ER) antigen
% a monoclonal antibody against giantin, a Golgi protein
% a monoclonal antibody against gpp130, a Golgi protein
% a monoclonal antibody against human LAMP2 (primarily found in lysosomes)
% a monoclonal antibody against an outer membrane protein of mitochondria
% a monoclonal antibody against nucleolin
% a monoclonal antibody against transferrin receptor (primarily found in the plasma membranes and endosomes)
% rhodamine-conjugated phalloidin, which labels F-actin
% a monoclonal antibody against beta-tubulin
%
% These images were used in our image classification and image set comparison projects,
% and have been referenced in the following publications:
%
% R. F. Murphy, M. V. Boland and M. Velliste (2000). Towards a Systematics for Protein
% Subcellular Location: Quantitative Description of Protein Localization Patterns
% and Automated Analysis of Fluorescence Microscope Images. Proc Int Conf Intell Syst
% Mol Biol (ISMB 2000) 8: 251-259.
%
% M. V. Boland and R. F. Murphy (2001). A Neural Network Classifier Capable
% of Recognizing the Patterns of all Major Subcellular Structures in
% Fluorescence Microscope Images of HeLa Cells. Bioinformatics 17:1213-1223.
%
% E.J.S. Roques and R.F. Murphy (2002). Objective evaluation of differences
% in protein subcellular distribution. Traffic 3: 61-65.
%
% K. Huang and R.F. Murphy (2004). Boosting accuracy of automated
% classification of fluorescence microscope images for location
% proteomics. BMC Bioinformatics 5:78.
%
% See also GET_2D_HELA_IMAGES

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

disp( 'Retrieving the 2D Hela SLF16 feature set' );
disp( 'Copyright (C) Murphy Lab' );
disp( 'Carnegie Mellon University' );

try
    filename = [ pwd filesep 'data' ...
        filesep 'HeLa10Class2DFeatures19990526.mat' ];
    load( filename );
    return
catch err
    disp( ['Unable to load filename: ' filename ] );
    data = [];
    getReport( err )
end
end
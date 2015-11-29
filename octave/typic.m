function [sorted, indices, distances, numpc, pcntexplained] = ...
    typic( features, param )
% [SCORES,INDICES,DISTANCES, NUMPC, PCNTEXPLAINED] =
%      ML_TYPICFM(features,FEATSELECTION,NUMPC,PCNTEXPLAINED,ROBUSTCOVAR);
% features   is the input feature matrix (columns=features, rows=images)
% FEATSELECTION identifies the method to be used for selecting a feature subset
%                'none'     - use all features calculated
%                'princomp' - calculate principal components and use in
%                              place of the features
% NUMPC         specifies how many principal components to use. (-1
%                to use PCNTEXPLAINED)
% PCNTEXPLAINED specifies the minimum percentage of variance to account for
% ROBUSTCOVAR   identified whether robust estimation of the
%                covariance matrix is to be used ('true' or 'false') outputs
% SCORES        scores of the images to rank    
% INDICES       contains the rankings of each image, with the most
%                typical image having the first (lowest) rank
% DISTANCES     contains the Mahalanobis distances of each image from the mean

if nargin == 1
    param = [];
    featselection = 'none';
    numpc = 20;
    pcntexplained = 100;
end

[numfiles, numfeat] = size(features);
numpc = floor(numpc);

switch featselection
 case 'none'
    featurematrix = double(features);
    numvars = numfeat;
    pcntexplained = 100;
 case 'princomp'
    % Convert the features to zscores ((x-xmean)/std) so that the
    %  principal components are not dominated by features with large
    %  absolute values
    zfv = zscore(double(features));
    % Now calculate principal components.  "pcs" will contain the pcs
    % themselves and variances will contain the amount of variance
    % explained by each pc
    [weights, pcs, variances, t2] = princomp(zfv);
    pcntvar = 100 * variances / sum(variances);
    if numpc<=0
	numvars = 0;
	currentTotal = 0;
	while(currentTotal < pcntexplained)
	    numvars = numvars +1;
	    currentTotal = currentTotal + pcntvar(numvars);
	end
	pcntexplained = currentTotal;
    else 
	numvars = numpc;
	if (numvars > size(features, 2))
	    error(['Number of principal components requested is greater' ...
		   ' than the number of features calculated.']);
	end
	pcntexplained = sum(pcntvar(1:numvars));
    end
    % Make the feature matrix contain just the desired pcs
    featurematrix = pcs(:,1:numvars);
 otherwise
    error ('TypIC 2.0 - Invalid feature selection method specified!');
end

[distances, redcov, errortype] = mahalanobis( featurematrix, featurematrix );
 
[sorted,indices] = sort(distances);
numpc = numvars;


 

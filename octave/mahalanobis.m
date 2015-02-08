function [distances, reduced_covariance, errortype] = mahalanobis( y, x )
% MAHALANOBIS Mahalanobis distance with correction for zero variance variables.

% Copyright (C) 2006-2015 Murphy Lab
% Carnegie Mellon University
%
% 2/8/2015 I. Cao-Berg Optimized method
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
% For additional information visit http://murphylab.web.cmu.edu or
% send email to murphy@cmu.edu

if nargin ~= 2
    error( 'Wrong number of input arguments' )
end

if isempty( y )
    error( 'Input argument Y cannot be empty' );
end

if isempty( x )
    error( 'Input argument X cannot be empty' );
end

if size(x,2) ~= size(y,2)
    error( ['Input arguments X and Y must have the same ' ...
        'number of features, i.e. they must have the same number of ' ...
        'columns'] );
end

[rx,cx] = size(x);
[ry,cy] = size(y);

if cx ~= cy
    error('Requires the inputs to have the same number of columns.');
end

if (rx>1)
    varX = var(x);
else
    varX = zeros(1,cx);
end;
if (ry>1)
    varY = var(y);
else
    varY = zeros(1,cy);
end;

% if all of the values for this variable in sample X are the same
% we can't compute Mahalanobis distance so don't include that variable
% in the calculation
reduced_x = x(:,find(varX>0));
reduced_y = y(:,find(varX>0));
j = size(reduced_x,2);

if size(x,1) < size(reduced_x,2)
    warning( ['The number of rows of X must exceed the ' ...
        'number of columns with non-zero variance.']);
    distances = repmat(NaN,ry,1);
    reduced_covariance = NaN;
    errortype = NaN;
    return
end

if (j>0)
    if (j==1)
        reduced_covariance=std(reduced_x);
        distances = ((reduced_y-mean(reduced_x))./reduced_covariance(1)).^2;
    else
        distances = mahal(reduced_y,reduced_x);
        reduced_covariance=cov(reduced_x);
    end
else
    distances = zeros(ry,1);
    reduced_covariance = zeros(j);
end

% ignoring a zero variance variable will only be accurate if all of the
% values for that variable in Y are also the same as the value in X,
% so check to see if any of the points have an infinite distance
%
% use a flag so that the warning is only printed once
errortype = 0;
for i=1:cx
    if(varX(i)==0 && varY(i)>0)
        if(errortype==0)
            %        warning('Infinite Mahalanobis distance(s) due to zero variance.');
            errortype=Inf;
        end
        for k=1:ry
            % check for points in Y where there is zero variance in a variable in X but
            % where the value for that variable is not the same as the value for X
            if(y(k,i)~=x(1,i))
                distances(k) = Inf;
            end;
        end;
    end;
end;




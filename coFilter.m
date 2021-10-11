function fim = coFilter( im2filter, im2collect, pab, f_smooth )
% COFILTER co-occurrence filter 
%   
% Syntax:
%   fim = coFilter( im2filter, im2collect, pab, f_smooth )
%
% Input: 
%   im2filter: the image to be filtered
%   im2collect: collect co-occurrence statistics from this image        
%   pab: co-occurrence statistics                                           [default: 256]
%   f_cooc: spatial filter for collecting co-occurrence                     [default: Gaussian]
%
% Output: 
%   fim: filtered image
%

%   Distributed as part of the "Co-occurrence Filter" paper:
%   It is an academic code, distributed under the GNU GPL license:
%   http://www.gnu.org/copyleft/gpl.html
%  
%  
%   Version: 1.0
%   Date: March 27th, 2017
%   Roy Josef Jevnisek: Roy.J.Jevnisek@gmail.com


%% Default Parameters:
if( isa( im2filter , 'uint8' ) ), im2filter = double( im2filter ); end
if( size( im2filter, 3 ) == 3 * size( pab, 3 ) ); pab = repmat( pab, [1, 1, 3] ); end
if( size( im2filter, 3 ) == 3 * size( im2collect, 3 ) ); im2collect = repmat( im2collect, [1, 1, 3] ); end
if( nargin < 4 ), f_smooth = fspecial( 'gaussian', 15, 2*sqrt(15)+1 ); end


%% Processing Parameters:
sz = size( im2filter ); if( length(sz) == 2 ), sz(3) = 1; end
nBins = size( pab, 1 );
fim = zeros( sz );


%% Smooth Per Channel:
for iChannel = 1:sz(3)

    % Current channel:
    cim = im2filter( :, :, iChannel );
    mvals = double( im2collect( :, :, iChannel ) );
    
    % Per level results:
    W = zeros( sz(1), sz(2), nBins );
    S = zeros( sz(1), sz(2), nBins );    
        
    % Per level smoothing:
    m = mat2cell( pab( :, :, iChannel ), ones( nBins, 1 )  );
        
    for iLevel = 0:( nBins - 1 )
    
        wpl = reshape( m{ iLevel + 1 }( mvals + 1 ), sz(1:2) );            	% weight per level
        
        W( :, :, iLevel + 1 ) = ...
            double( mvals == iLevel ) .* ...
            imfilter( wpl, f_smooth, 'symmetric' );                        
        
        S( :, :, iLevel + 1 ) = ...
            double( mvals == iLevel ) .* ...
            imfilter( wpl .* cim, f_smooth, 'symmetric' );
    
    end
        
    fim( :, :, iChannel ) = sum( S, 3 )./ (  sum( W, 3 ) + eps );
    
end

end
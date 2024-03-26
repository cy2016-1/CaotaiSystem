function [layer_out] = function_dense(layer_in, weights, bias)
% layer_in : data from previous layer  , IH*IW*NI
% weights  : weights of this conv_layer, NO*(IH*IW*NI)
% bias     : bias of this conv_layer   , NO*1
% layer_out: data goes to next layer   , NO*1
%% convert input image to colum
layer_in = permute(layer_in,[3 2 1]);
img2col = layer_in(:);
%% convert colum to output
layer_out = weights * img2col + bias;

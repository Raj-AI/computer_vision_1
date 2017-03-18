function [features] = get_features(cell_of_structs, density, colorspace)
%GET_FEATURES Collects all features of given sampling density and
%colorspace
%
%   FEATURES = GET_FEATURES(CELL_OF_STRUCTS, DENSITY, COLORSPACE)
%   Aggregates features from a cell of structs
%
% Inputs:
%   CELL_OF_STRUCTS: a cell of structs generated by %LOAD_DATA_FROM_FOLDER
%   DENSITY: feature sampling type: 'dense' or 'key' 
%   COLORSPACE: a number between 1-5 denoting colorspace {grayscale, RGB, rgb, HSV, opp}
%
% Outputs:
%   FEATURES: an NxP matrix with features, where P=128 the dimensionality
%   of SIFT descriptors, and N is the total number of descriptors across
%   all images in cell_of_structs
%See Also:
%LOAD_DATA_FROM_FOLDER
%EXTRACT_DESCRIPTORS


    % Size of features matrix
    N = 0;
    P = 128;
    
    % estimate N by looping through all images and aggregating their
    % number of descriptors
    for i=1:length(cell_of_structs)
        img = cell_of_structs{i};
        feats = getfield(img, density);
        N = N + size(feats{c}, 2);
    end
    
    % init huge matrix
    features = zeros(N,P);
    
    j = 1; % pointer for writing
    for i=1:length(cell_of_structs)
        img = cell_of_structs{i}; % get image
        tmp = getfield(img, density); % get cell of colorspaces, given density
        feats = tmp{colorspace}; % get colorspace
        features(j:j+size(feats,2),:) = feats; % set features
        j = j+ size(feats,2) + 1; % update pointer
    end
end
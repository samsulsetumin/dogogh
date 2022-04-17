clc; clear; close all;

%% PRE-PROCESSING
% Get the dataset

%% VIEWED CUHK Test
% dsP = imageDatastore('PreprocessedDatasets\photos');
% dsS = imageDatastore('PreprocessedDatasets\sketches');

% CUFS from http://mmlab.ie.cuhk.edu.hk/archive/facesketch.html
dsP = imageDatastore('photos');
dsS = imageDatastore('sketches');
   
%% FEATURE EXTRACTION
disp('Extracting features ...');

% Number of images
nImage = length(dsS.Files);

featuresS = []; featuresP = [];
count = 0;

for i = 1:nImage
    count = count + 1;

    disp(['Extracting feature: ' num2str(i)]);

    % For sketch
    targetImageS = imread(dsS.Files{i});
    [~, ~, chnls] = size(targetImageS);
    if chnls == 3, targetImageS = rgb2gray(targetImageS); end
%         figure, imshow(uint8(targetImageS));

    % For photo
    targetImageP = imread(dsP.Files{i});
    [~, ~, chnls] = size(targetImageP);
    if chnls == 3, targetImageP = rgb2gray(targetImageP); end
%         figure, imshow(uint8(targetImageP));

    %% DoGOGH
    featuresS(count,:) = extractDoGOGHFeatures(targetImageS);
    featuresP(count,:) = extractDoGOGHFeatures(targetImageP);

end           

%% MATCHING
disp('Matching and plotting ...');

rankLimit = 10;
markers = {'-+','-o','-*','-.','-x','-s','-d','-^','-v','->','-<','-p','-h'};

D = pdist2(featuresS, featuresP, 'L1');

[ranks, results] = evaluateCMC(D);

plotCMC(ranks(1,1:rankLimit), results(1,1:rankLimit), 'Results', markers{1}, 1);

disp('Done.');


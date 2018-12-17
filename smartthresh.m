% SMARTTHRESH Thresholding of blood vessel channel
% 
% vesthresh = smartthresh(vessels, minimumvesseldiameter, maximumvesseldiameter)
%
% This function thresholds a blood vessel image in order to maximize the
% recognition of dim vessels, minimizing the recognition of non-vessel
% artifacts in imaging and producing an accurate estimate of vessel
% diameter. Inputs required:
%
% vessels  - is a matrix with the raw fluorescence values from blood vessel
% channel
% 
% minimumvesseldiameter - scalar. Gaussian with this stdev is applied to 
% the whole image. "2" works well.
% 
% maximumvesseldiameter - scalar. Used for normalizing contrast and
% subtracting background. "10" used for most analysis. Results are not very
% sensitive to this value. Larger numbers require longer computation times.
 

function vesthresh = smartthresh(vessels, minimumvesseldiameter, maximumvesseldiameter,organtype)
tic
vessels2 = im2mat(stretch(vessels, 1, 99.9, 0, 255));
tissueboundary =(vessels2<10)&(vessels2>5);
tissueboundary = imdilate(tissueboundary, strel('disk',2));

a = mat2im(vessels);
a = a/max(a);

a = a/(0.2+gaussf(a,10*maximumvesseldiameter));
a = mat2im(log(double(a)+0.1));




%%
% Three techniques to determine thresholds
% Metric1 - Use LoG filter to find vessel regions
metric1 = -1*laplace(exp(a),minimumvesseldiameter);

% Metric2 - Use Unsharp mask (subtract out all features larger than max
% diameter
metric2 = gaussf(a,minimumvesseldiameter)-gaussf(a,maximumvesseldiameter);
metric2 = metric2 + abs(metric2);

% Metric3 - Use Gradient magnitude
metric3 = gradmag(a,minimumvesseldiameter);

% Take thresholds of each technique (+0 is to transform data type)
imgmet1 = threshold(metric1)+0; 
imgmet2 = threshold(metric2)+0;
imgmet3 = closing(threshold(metric3),minimumvesseldiameter*2)+0;
% Gradient magnitude tends to have holes which need to be closed.

%%

%Final threshold is positive if >2 of the image metrics are positive
seg_vessels = (imgmet1+imgmet2+imgmet3)>1.5;
seg_vessels(tissueboundary)= false;

%Cleans up the thresholded regions and removes small regions
erves = erosion(seg_vessels,minimumvesseldiameter*2);
switch organtype
    case 'Tumour'
        vesthresh2 = label(erves,inf,5000,1E10);
        vesthresh = closing(vesthresh2>0,minimumvesseldiameter);
    case 'Liver'
        vesthresh = closing(seg_vessels,minimumvesseldiameter);
       
end

toc



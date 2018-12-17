%% Tissue trim uses a 3D image of cell nuclei to define boudaries of the tissue sample and remove tissue edges. 


function [particles_cropped, nucthresh] = tissuetrim(nuclei, particles, trim_radius)

%trim_radius of 30 works well for most images with zoom = 0.36 downsampled
%to 2um resolution in x,y,z

proj_xy = opening(nuclei(:,:,round(size(nuclei,3)/2)),30);
proj_yz = opening(nuclei(:,round(size(nuclei,2)/2),:),30);
proj_xz = opening(nuclei(round(size(nuclei,1)/2),:,:),30);



[~, nucthresholds(1)] = threshold(proj_xy, 'triangle');
[~, nucthresholds(2)] = threshold(proj_yz, 'triangle');
[~, nucthresholds(3)] = threshold(proj_xz, 'triangle');

nucthresh = nuclei>min(nucthresholds);
nucthresh = fillholes(nucthresh);
if trim_radius>2
nucthresh = im2mat(berosion(nucthresh,trim_radius));
end
particles_cropped = particles;
particles_cropped(~nucthresh)=0;
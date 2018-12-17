%%Function to analyze NP distribution in macrophages from 3D images.
%%Requires 3D optical images of nuclei, blood vessels, macrophages and
%%nanoparticles, the pixel size in um, a results directory and a filename
%%for the output .csv file. 


function NP_macro_dist_analysis(nuclei,vessels,macrophages,nanoparticles,px_size_um,results_dir,organtype,filename)
shortfile = filename;
display(['Processing ' shortfile])
tic

%% The nuclei channel is used to define the boundaries of the tissue, the particle channel is trimmed to exclude artifacts on and beyond the tissue edges
[partcrop, nucthresh] = tissuetrim(nuclei, nanoparticles, 30);

%%Thresholding vessels based on organ type
switch organtype
    case 'Tumour'
        vesthresh = smartthresh(vessels, 2, 10,'Tumour');
    case 'Liver'
        vesthresh = smartthresh(vessels, 2, 10,'Liver');
end

%%Allows for conversion from pixel size to um
z_physsize = px_size_um;

%% Crop images based on tissue outline from nuclei channel - removes scattering and autoflourescent artifacts from the edge of the tissue
nucthresh = nucthresh >0;

nuclei_crop = nuclei.*uint16(nucthresh);
macrophage_crop = macrophages.*uint16(nucthresh);
vesthresh_crop = vesthresh.*uint16(nucthresh);
particles_crop = partcrop;
    
    
%%Local and global intensity normalization
    macros = single(macrophage_crop);
    nuclei2 = single(nuclei_crop);
    particles = single(particles_crop);
    
    macro_local = macros./(0.2*max(macros(:))+(im2mat(gaussf(macros,size(macros,1)/10))));
    dapi_local = nuclei2./(0.2*max(nuclei2(:))+(im2mat(gaussf(nuclei2,size(macros,1)/10))));
    part_local = particles./(0.2*max(particles(:))+(im2mat(gaussf(particles,size(macros,1)/10))));
    
%%Macrophage thresholding and identifying macrophage areas with
%%nanoparticles
    T = adaptthresh(macro_local,0.25);
    mac_thresh = imbinarize(macro_local,T);
    mac_thresh_crop = mac_thresh.*nucthresh;
    mac_bin = mac_thresh_crop>0;
    NP_in_mac = single(mac_bin).*(part_local);
    NP_in_mac_s = NP_in_mac;
    
%%Distance transformation from binary vessel image    
    posdistimg = im2mat(dt(~vesthresh_crop));
    negdistimg = im2mat(dt(erosion(vesthresh_crop,2)>0));
    
    distimg = posdistimg - negdistimg;
    clear posdistimg negdistimg
    
    
%% Linear version of the entire image (for histogram sorting)
    linear_dist = round(single(distimg(:)));
    linear_all = cat(2, ones(size(linear_dist)), (part_local(:)), (dapi_local(:)), (macro_local(:)), (NP_in_mac_s(:)));
    
    
    part_vs_dist_raw = zeros(261,6);
    pixeldistances = -10:1:250;
    for i = 1: size(pixeldistances,2)
        temp_locations = linear_dist==pixeldistances(i);
        part_vs_dist_raw(i,:) = [pixeldistances(i)*z_physsize sum(linear_all(temp_locations,:),1)];
    end
    part_vs_dist = part_vs_dist_raw;
    
    %Convert into concentration (divide by volume)
    part_vs_dist(:,3) = part_vs_dist(:,3)./part_vs_dist(:,2);
    part_vs_dist(:,4) = part_vs_dist(:,4)./part_vs_dist(:,2);
    part_vs_dist(:,5) = part_vs_dist(:,5)./part_vs_dist(:,2);
    par_vs_dist(:,6) = part_vs_dist(:,6)./part_vs_dist(:,2);
    
    %Normalize relative to max
    part_vs_dist(:,3) = part_vs_dist(:,3)./max(part_vs_dist(:,3));
    part_vs_dist(:,4) = part_vs_dist(:,4)./max(part_vs_dist(:,4));
    part_vs_dist(:,5) = part_vs_dist(:,5)./max(part_vs_dist(:,5));
    part_vs_dist(:,6) = part_vs_dist(:,6)./max(part_vs_dist(:,6));    
    
     plot(part_vs_dist(:,1), part_vs_dist(:,3),'-r');
     hold on
     plot(part_vs_dist(:,1), part_vs_dist(:,4),'-b');
     plot(part_vs_dist(:,1), part_vs_dist(:,6),'-g');
    
    cd(results_dir)
    
    distances_um = part_vs_dist(:,1);
    total_num_of_pixels = part_vs_dist(:,2);
    particle_conc = part_vs_dist(:,3);
    dapi_conc = part_vs_dist(:,4);
    mac_conc = part_vs_dist(:,5);
    NP_per_mac_conc = part_vs_dist(:,6);
    
T = table(distances_um, total_num_of_pixels, particle_conc, dapi_conc, mac_conc, NP_per_mac_conc);

histofilename = strcat(shortfile, '_NP_macro_dist_analysis.csv');

writetable(T,histofilename);
    

toc
end






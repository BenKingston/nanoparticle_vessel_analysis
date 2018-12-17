# Macrophage_loc_nanoparticle
MATLAB code for Ouyang et al. - Dose determines nanoparticle delivery. Quantification of nanoparticle concentration in macrophages as a function of distance from blood vessels from 3D light-sheet microscopy images. 

The NP_macro_dist_analysis.m function requires 3D optical images (multipage tiff files or similar) of nuclei, blood vessels, macrophages and nanoparticles, the pixel size in um, a results directory and a filename for the output .csv file.

tissuetrim.m is used to define tissue boundaries and remove the outer ~30 um of tissue in order to exclude light scattering and autoflourescent artifacts at the tissue edge. smartthresh.m is used to segment blood vessels. Both tissuetrim.m and smartthresh.m are required to run the NP_Macro_dist_analysis.m function. Example tumour an liver images can be found in the Example_data folder. 




This software license is the 2-clause BSD license plus  a third clause that prohibits redistribution and use for commercial purposes without further permission.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

Redistributions and use for commercial purposes are not permitted without the written permission. For purposes of this license, commercial purposes are the incorporation of the software into anything for which you will charge fees or other compensation or use of the software to perform a commercial service for a third party.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

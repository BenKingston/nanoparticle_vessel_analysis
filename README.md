# Nanoparticle intensity vs distance from blood vessels
MATLAB code for Ouyang et al. (2020) - A dose threshold to enhance nanoparticle tumour delivery. Quantification of nanoparticle concentration as a function of distance from blood vessels from 3D light-sheet microscopy images. 

NP_macro_dist_analysis.m function requires 3D optical images (multipage tiff files or similar) of segmented blood vessels and nanoparticles, the pixel size in um, a results directory and a filename for the output .csv file. 

In this work blood vessels were segmented using Ilasik (https://www.ilastik.org/ or https://github.com/ilastik). 

ilastik: interactive machine learning for (bio)image analysis
Stuart Berg, Dominik Kutra, Thorben Kroeger, Christoph N. Straehle, Bernhard X. Kausler, Carsten Haubold, Martin Schiegg, Janez Ales, Thorsten Beier, Markus Rudy, Kemal Eren, Jaime I Cervantes, Buote Xu, Fynn Beuttenmueller, Adrian Wolny, Chong Zhang, Ullrich Koethe, Fred A. Hamprecht & Anna Kreshuk
in: Nature Methods, (2019)









This software license is the 2-clause BSD license plus  a third clause that prohibits redistribution and use for commercial purposes without further permission from the authors of this work (Ouyang et al).

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

Redistributions and use for commercial purposes are not permitted without the written permission of the authors of this work (Ouyang et al). For purposes of this license, commercial purposes are the incorporation of the software into anything for which you will charge fees or other compensation or use of the software to perform a commercial service for a third party.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

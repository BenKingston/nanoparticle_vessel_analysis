function FinalImage = imreadfast(FileTif)    

InfoImage=imfinfo(FileTif);
mImage=InfoImage(1).Width;
nImage=InfoImage(1).Height;
NumberImages=length(InfoImage);
FinalImage=zeros(nImage,mImage,NumberImages,'uint16');
FileID = tifflib('open',FileTif,'r');
rps = tifflib('getField',FileID,Tiff.TagID.RowsPerStrip);
rps = min(rps,nImage);
 
for i=1:NumberImages
   tifflib('setDirectory',FileID,i-1);
   % Go through each strip of data.
   
   for r = 1:rps:nImage
      row_inds = r:min(nImage,r+rps-1);
%       row_inds = row_inds(row_inds<=nImage);
      stripNum = tifflib('computeStrip',FileID,r);
      FinalImage(row_inds,:,i) = tifflib('readEncodedStrip',FileID,stripNum-1);
   end
end
tifflib('close',FileID);
% toc
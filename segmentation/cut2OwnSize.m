function a = cut2OwnSize(image,box)
im=imcrop(image,box);

l=bwlabel(im);
l(l>0)=1;
boxs=regionprops(l,'BoundingBox');

a=boxs.BoundingBox;
end
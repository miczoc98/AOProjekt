classdef Segmentizer
    %SEGMENTIZER Summary of this class goes here
    %   Detailed explanation goes here
    
    
    methods
        function letters = getLetterBoxes(~, image)
            im = ~imbinarize(rgb2gray(image));
           
            letters = regionprops(logical(im), 'Image');
        end
    end
end


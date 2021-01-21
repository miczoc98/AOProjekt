classdef Binarizer
    properties
        activeLayers = ActiveLayers();
        threshold = 0.5;
    end
    
    methods
        function binarized = binarize(this, image)
            binarized = zeros(size(image, 1,2));
            
            if this.activeLayers.R == true
                r = imbinarize(image(:,:,1), this.threshold);
                binarized = binarized|r;
            end
            if this.activeLayers.G == true
                g = imbinarize(image(:,:,2), this.threshold);
                binarized = binarized|g;
            end
            if this.activeLayers.B == true
                b = imbinarize(image(:,:,3), this.threshold);
                binarized = binarized|b;
            end
            
            binarized = ~binarized;
        end
    end
end
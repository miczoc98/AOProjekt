classdef Binarizer    
    properties
        mode = 'manual';
        isColorInversionOn = false;
        activeLayers = ActiveLayers();
        threshold = 0.5;
    end
    
    methods
        function binarized = binarize(this, image)
            switch this.mode
                case 'manual'
                    binarized = manualBinarize(this, image);
                case 'auto'
                    binarized = autoBinarize(this, image);
                case 'dynamic'
                    binarized = dynamicBinarize(this, image);
            end
        end
        
        function binarized = manualBinarize(this, image)
            binarized = zeros(size(image, 1, 2));
            
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
            
            if this.isColorInversionOn
                binarized = ~binarized;
            end
        end
        
        function binarized = autoBinarize(this, image)
            image = rgb2gray(image);
            binarized = imbinarize(image);
            if this.isColorInversionOn
                binarized = ~binarized;
            end
        end
        
        function binarized = dynamicBinarize(this, image)
            image = rgb2gray(image);
            if (this.isColorInversionOn)
                image = ones(size(image)) - image;
            end
            
            binarized = imbinarize(image, 'adaptive', 'Sensitivity', this.threshold);
        end
    end
end

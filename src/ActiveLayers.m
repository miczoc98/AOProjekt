classdef ActiveLayers
   properties
    R = false;
    G = false;
    B = false;
   end
    
   methods (Access=public)
       function layers=getActiveLayers(this)
           layers = "";
           if this.R
               layers = layers + "R";
           end
           if this.G
               layers = layers + "G";
           end
           if this.B
               layers = layers + "B";
           end
       end
   end
   
end
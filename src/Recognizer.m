classdef Recognizer
    %OCR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        sideSize = 50;
        dataSet;
        
        arialDataSet; 
        helveticaDataSet; 
        tnrDataSet; 
        purisaDataSet; 
        avgDataSet;
    end
    
    methods
        function obj = Recognizer()
            obj.arialDataSet = obj.createDataSet("Arial");
            obj.helveticaDataSet = obj.createDataSet("Helvetica");
            obj.tnrDataSet = obj.createDataSet("TimesNewRoman");
            obj.purisaDataSet = obj.createDataSet("Purisa");
            obj.avgDataSet = obj.createAvgDataSet();
        end
        
        function result = recognizeCharacter(this, input)
            characters_mapping = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", ...
                                  "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", ...
                                  "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", ...
                                  "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", ...
                                  "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", ...
                                  "4", "5", "6", "7", "8", "9", "0", "!", "@", "#", "&", ...
                                  "(", ")", "-", "+", "=", "[", "]", "{", "}", ":", ";", ...
                                  "'", ",", ".", "?"];

            input = this.resizeToSquare(input, this.sideSize);
                  
            result = zeros(1, size(this.dataSet, 3));

            for i=1:size(this.dataSet, 3)
                result(1,i) = corr2(input(:,:), this.dataSet(:,:,i));
            end

            [~, idx] = max(result(1,:));
            result = characters_mapping(idx);  
        end
        
        function dataSet = createDataSet(this, font_name)
            dir = "DataSets/";

            font_ucase_name  = strcat(dir, font_name, "UpperCase.png");
            font_lcase_name  = strcat(dir, font_name, "LowerCase.png");
            font_others_name = strcat(dir, font_name, "Others.png");

            im_ucase  = double(imread(font_ucase_name))/255;
            im_lcase  = double(imread(font_lcase_name))/255;
            im_others = double(imread(font_others_name))/255;

            bim_ucase  = ~imbinarize(rgb2gray(im_ucase));
            bim_lcase  = ~imbinarize(rgb2gray(im_lcase));
            bim_others = ~imbinarize(rgb2gray(im_others));

            l_ucase  = bwlabel(bim_ucase);
            l_lcase  = bwlabel(bim_lcase);
            l_others = bwlabel(bim_others);

            l_lcase = this.changeLabel(l_lcase, 10, 9);
            l_lcase = this.changeLabel(l_lcase, 11, 10);

            l_others = this.changeLabel(l_others, 12, 11);
            l_others = this.changeLabel(l_others, 20, 19);
            l_others = this.changeLabel(l_others, 25, 24);
            l_others = this.changeLabel(l_others, 26, 25);
            l_others = this.changeLabel(l_others, 30, 29);

            ucase_char  = regionprops(logical(l_ucase), 'image');
            lcase_char  = regionprops(l_lcase, 'image');
            others_char = regionprops(l_others, 'image');

            im_chars = zeros(this.sideSize, this.sideSize, length(ucase_char) + length(lcase_char) + length(others_char));

            for i=1:length(ucase_char)
                im_chars(:,:,i) = this.resizeToSquare(ucase_char(i).Image, this.sideSize);
            end
            for i=1:length(lcase_char)
                im_chars(:,:,i + length(ucase_char)) = this.resizeToSquare(lcase_char(i).Image, this.sideSize);
            end
            for i=1:length(others_char)
                im_chars(:,:,i + length(ucase_char) + length(lcase_char)) = this.resizeToSquare(others_char(i).Image, this.sideSize);         
            end

            dataSet = im_chars;
        end
        
        function im_square = resizeToSquare(~, im, final_size)
            height  = size(im, 1);
            width = size(im, 2);

            if width > height
                padding_bottom = double(idivide(int16(width - height), int16(2)));
                padding_top    = padding_bottom;
                if mod(int16(width - height), 2) %odd
                    padding_top = padding_top + 1;
                end

                im_square = padarray(im, padding_top, 0, 'pre');
                im_square = padarray(im_square, padding_bottom, 0, 'post');
            elseif height > width
                padding_right = double(idivide(int16(height - width), int16(2)));
                padding_left = padding_right;
                if mod(int16(height - width), 2) %odd
                    padding_left = padding_left + 1;
                end

                im_square = padarray(im, [0, padding_left], 0, 'pre');
                im_square = padarray(im_square, [0, padding_right], 0, 'post');
            else
                im_square = im;
            end

            im_square = imresize(im_square, [final_size, final_size]);
        end
        
        function m = changeLabel(~, m, v1, v2)
            m(m==v1) = v2; 
            for i=v1+1:max(m, [], 'all')
                m(m==i) = i-1;
            end
        end
        
        function avgDataSet = createAvgDataSet(this)
            ds1 = this.arialDataSet;
            ds2 = this.helveticaDataSet;
            ds3 = this.tnrDataSet;
            avgDataSet = zeros(size(ds1, 1), size(ds1, 2), size(ds1, 3));
            for i=1:size(ds1, 3)
                for j=1:size(ds1, 2)
                    for k=1:size(ds1, 1)
                        for n_ds=1:3
                            avgDataSet(k, j, i) = (ds1(k, j, i) + ds2(k, j, i) + ds3(k, j, i)) / 3;
                            if avgDataSet(k, j, i) >= 0.5
                                avgDataSet(k, j, i) = 1;
                            else
                                avgDataSet(k, j, i) = 0;
                            end
                        end
                    end
                end
            end
        end
    end
end


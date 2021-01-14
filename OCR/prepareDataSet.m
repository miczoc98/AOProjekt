function data_set = prepareDataSet(font_name)
    
    dir = "DataSets/";
    font_ucase_name  = strcat(dir, "ArialUpperCase.png");
    font_lcase_name  = strcat(dir, "ArialLowerCase.png");
    font_others_name = strcat(dir, "ArialOthers.png");
    
    if isstring(font_name)
        if isfile(strcat(dir, font_name, "UpperCase.png")) && isfile(strcat(dir, font_name, "LowerCase.png")) && isfile(strcat(dir, font_name, "Others.png"))
            font_ucase_name  = strcat(dir, font_name, "UpperCase.png");
            font_lcase_name  = strcat(dir, font_name, "LowerCase.png");
            font_others_name = strcat(dir, font_name, "Others.png");
        end
    end
    
    im_ucase  = double(imread(font_ucase_name))/255;
    im_lcase  = double(imread(font_lcase_name))/255;
    im_others = double(imread(font_others_name))/255;
    
    bim_ucase  = ~imbinarize(rgb2gray(im_ucase));
    bim_lcase  = ~imbinarize(rgb2gray(im_lcase));
    bim_others = ~imbinarize(rgb2gray(im_others));
    
    l_ucase  = bwlabel(bim_ucase);
    l_lcase  = bwlabel(bim_lcase);
    l_others = bwlabel(bim_others);
    
    l_lcase = changeLabel(l_lcase, 10, 9);
    l_lcase = changeLabel(l_lcase, 11, 10);

    l_others = changeLabel(l_others, 12, 11);
    l_others = changeLabel(l_others, 15, 14);
    l_others = changeLabel(l_others, 15, 14);
    l_others = changeLabel(l_others, 21, 20);
    l_others = changeLabel(l_others, 26, 25);
    l_others = changeLabel(l_others, 27, 26);
    l_others = changeLabel(l_others, 28, 27);
    l_others = changeLabel(l_others, 32, 31);
    
    ucase_char  = regionprops(logical(l_ucase), 'image');
    lcase_char  = regionprops(l_lcase, 'image');
    others_char = regionprops(l_others, 'image');
    
    im_chars = zeros(25, 25, length(ucase_char) + length(lcase_char) + length(others_char));
    
    for i=1:length(ucase_char)
        im_chars(:,:,i) = imresize(padarray(ucase_char(i).Image, [7, 7]), [25, 25]);
    end
    for i=1:length(lcase_char)
        im_chars(:,:,length(ucase_char) + i) = imresize(padarray(lcase_char(i).Image, [7, 7]), [25, 25]);
    end
    for i=1:length(others_char)
        im_chars(:,:,length(ucase_char) + length(lcase_char) + i) = imresize(padarray(others_char(i).Image, [7, 7]), [25, 25]);
    end

    data_set = im_chars;
end

clear; clc;

arial_data_set     = prepareDataSet("Arial", 50);
tnr_data_set       = prepareDataSet("TimesNewRoman", 50);
helvetica_data_set = prepareDataSet("Helvetica", 50);

data_set = arial_data_set;

% for i=1:size(data_set, 3)
%     subplot(9, 9, i);
%     imshow(data_set(:,:,i));
% end

% Testing OCR
test_data = double(imread("ArialTest.png"))/255;
test_data = ~imbinarize(rgb2gray(test_data));

test_data = bwlabel(test_data);
test_data = regionprops(logical(test_data), "image");

input_char = zeros(50, 50, length(test_data));

for i=1:length(test_data)
    input_char(:,:,i) = resizeToSquare(test_data(i).Image, 50);
%     subplot(5, 5, i);
%     imshow(input_char(:,:,i));
end

result_text = "";
for i=1:size(input_char, 3)
    result_text = strcat(result_text, myOcr(data_set, input_char(:,:,i)));
end

    

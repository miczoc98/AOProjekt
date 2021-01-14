clear; clc;

arial_data_set     = prepareDataSet("Arial");
tnr_data_set       = prepareDataSet("TimesNewRoman");
helvetica_data_set = prepareDataSet("Helvetica");

% for i=1:size(tnr_data_set, 3)
%     subplot(10, 9, i);
%     imshow(tnr_data_set(:,:,i));
% end

% Testing OCR
test_data = double(imread("ArialTest.png"))/255;
data_set = arial_data_set;
% test_data = double(imread("TimesNewRomanTest.png"))/255;
% data_set = tnr_data_set;
test_data = ~imbinarize(rgb2gray(test_data));

test_data = bwlabel(test_data);
test_data = regionprops(logical(test_data), "image");

input = zeros(25, 25, length(test_data));

for i=1:length(test_data)
    input(:,:,i) = imresize(padarray(test_data(i).Image, [7, 7]), [25, 25]);
%     subplot(5, 5, i);
%     imshow(input(:,:,i));
end

result = myOcr(data_set, input)
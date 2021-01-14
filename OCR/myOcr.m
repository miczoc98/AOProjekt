function result_text = myOcr(data_set, input_characters)
    
    result_text = "";
    characters_mapping = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", ...
                          "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", ...
                          "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", ...
                          "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", ...
                          "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", ...
                          "4", "5", "6", "7", "8", "9", "0", "!", "@", "#", "%", ...
                          "&", "(", ")", "-", "+", "=", "[", "]", "{", "}", ":", ...
                          ";", '"', "'", ",", ".", "?"];
    
    result = zeros(size(input_characters, 3), size(data_set, 3));
                  
    for i=1:size(input_characters, 3)
        for j=1:size(data_set, 3)
            result(i,j) = corr2(input_characters(:,:,i), data_set(:,:,j));
        end
    end
    
    for i=1:size(input_characters, 3)
        [val, idx] = max(result(i,:));
        result_text = strcat(result_text, characters_mapping(idx));
    end
end

















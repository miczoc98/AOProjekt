function result_character = myOcr(data_set, input_character)
    
    characters_mapping = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", ...
                          "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", ...
                          "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", ...
                          "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", ...
                          "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", ...
                          "4", "5", "6", "7", "8", "9", "0", "!", "@", "#", "&", ...
                          "(", ")", "-", "+", "=", "[", "]", "{", "}", ":", ";", ...
                          "'", ",", ".", "?"];
    
    result = zeros(1, size(data_set, 3));
    for i=1:size(data_set, 3)
        result(1,i) = corr2(input_character(:,:), data_set(:,:,i));
    end

    [val, idx] = max(result(1,:));
    result_character = characters_mapping(idx);  
end

















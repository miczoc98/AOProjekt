function im_square = resizeToSquare(im, final_size)
    
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
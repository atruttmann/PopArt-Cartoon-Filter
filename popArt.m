img = imread('Original Sample.png');

% User chosen color values
RGB_1 = [255 133 114];
RGB_2 = [114 117 255];
RGB_3 = [118 219 219];
RGB_4 = [255 224 104];

% Convert RGB
RGB_1 = RGB_1 ./ 255;
RGB_2 = RGB_2 ./ 255;
RGB_3 = RGB_3 ./ 255;
RGB_4 = RGB_4 ./ 255;

% Cartoonize
cartoon = bilateralFilter(img, 3);
cartoon = edgeDetect(cartoon, 3);

% Convert to grayscale and use threshold to make into black and white
gray = rgb2gray(cartoon);
BIN = gray > 0.5;
grayImage = uint8(255 * BIN);

% Fill white with user-chosen colors
image_1 = cat(3, grayImage * RGB_1(1), grayImage * RGB_1(2), grayImage * RGB_1(3));
image_2 = cat(3, grayImage * RGB_2(1), grayImage * RGB_2(2), grayImage * RGB_2(3));
image_3 = cat(3, grayImage * RGB_3(1), grayImage * RGB_3(2), grayImage * RGB_3(3));
image_4 = cat(3, grayImage * RGB_4(1), grayImage * RGB_4(2), grayImage * RGB_4(3));

% Write images and combine into a group of images
imwrite(image_1, 'image_1.jpg');
imwrite(image_2, 'image_2.jpg');
imwrite(image_3, 'image_3.jpg');
imwrite(image_4, 'image_4.jpg');
pictures = {'image_1.jpg' 'image_2.jpg' 'image_3.jpg' 'image_4.jpg'};
montage(pictures, 'Size', [2 2]);
group = getframe(gca);

imwrite(group.cdata, 'popArt5.jpg');
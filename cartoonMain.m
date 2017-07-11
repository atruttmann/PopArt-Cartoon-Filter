img = imread('Marilyn.jpg'); 

img = bilateralFilter(img, 1);

% For user input: min value = 8, max value = 18
img = edgeDetect(img, 9);

imwrite(img, 'r7.jpg');
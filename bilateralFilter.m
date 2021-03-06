function[B] = bilateralFilter(A, passes)
    A = rgb2lab(A);
    A = im2double(A);
    sigma_d = 3;
    sigma_r = 10;
    w = 5;
    
    % Gaussian domain weights
    [X,Y] = meshgrid(-w:w, -w:w);
    G = exp(-(X.^2 + Y.^2)/(2 * sigma_d^2));

    % Apply bilateral filter
    dim = size(A);
    B = zeros(dim);
    for k = 1:passes
        for i = 1:dim(1)
           for j = 1:dim(2)

                 % Extract local region.
                 iMin = max(i-w, 1);
                 iMax = min(i+w, dim(1));
                 jMin = max(j-w, 1);
                 jMax = min(j+w, dim(2));
                 I = A(iMin:iMax,jMin:jMax,:);

                 % Compute Gaussian range weights.
                 dL = I(:,:,1)-A(i,j,1);
                 da = I(:,:,2)-A(i,j,2);
                 db = I(:,:,3)-A(i,j,3);
                 H = exp(-(dL.^2+da.^2+db.^2)/(2*sigma_r^2));

                 % Calculate bilateral filter response
                 F = H.*G((iMin:iMax)-i+w+1,(jMin:jMax)-j+w+1);
                 norm_F = sum(F(:));
                 B(i,j,1) = sum(sum(F.*I(:,:,1)))/norm_F;
                 B(i,j,2) = sum(sum(F.*I(:,:,2)))/norm_F;
                 B(i,j,3) = sum(sum(F.*I(:,:,3)))/norm_F;
                 
           end
        end
        A = B;
    end
end
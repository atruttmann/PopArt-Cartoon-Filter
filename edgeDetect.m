function[C] = edgeDetect(B, levels)
    
    max_gradient      = 0.2;
    sharpness_levels  = [0.75 5.0];
    min_edge_strength = 0.3;

    % Allows user to set level of detail
    quant_levels = levels;
    
    % Determine gradient magnitude of luminance
    [GX, GY] = gradient(B(:,:,1)/100);
    G = sqrt(GX.^2 + GY.^2);
    G(G > max_gradient) = max_gradient;
    G = G / max_gradient;

    % Determine per-pixel "sharpening" parameter
    S = diff(sharpness_levels)*G+sharpness_levels(1);
    qB = B; 

    % Color quantization
    dq = 100/(quant_levels-1);
    qB(:,:,1) = (1/dq)*qB(:,:,1);
    qB(:,:,1) = dq*round(qB(:,:,1));
    qB(:,:,1) = qB(:,:,1)+(dq/2)*tanh(S.*(B(:,:,1)-qB(:,:,1)));
    
    % Create edge map using gradient magnitudes
    E = G; 
    E(E < min_edge_strength) = 0;
    C = repmat(1-E,[1 1 3]).*lab2rgb(qB);
    
end
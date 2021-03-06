
function [ Gx, Gy, grad_magnitude , grad_direction ] = compute_gradient( image )
    
    image = double(image);
    
    % Creates the Sobel mask
    H = -fspecial('sobel'); % negate it to enforce that the x gradients increase towards the right
    
    % Applies the differential operator to the image 
    Gx = imfilter(image,H','replicate');
    Gy = imfilter(image,H,'replicate'); % positive Y-gradients point downwards
    
    % Calculates the magnitude of the gradient as the hypotenuse
    grad_magnitude = hypot(Gx,Gy);
    
    % Applies atan to find the gradient direction
    grad_direction = atan2(-Gy,Gx)*180/pi;
    
end
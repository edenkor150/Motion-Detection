function filteredIMG = FreqCanceling(IMG,P_energy)
% filter image according to energy threshold of low frequencies

IMGfft = fftshift(fft2(IMG(2:end,2:end))); 
s = 0.02:0.1:10;
Energy = sum(sum(abs(IMGfft).^2)); %the total energy
for i=1:length(s) 
    % high-pass filter h is created by subtracting a Gaussian low-pass filter from an all-ones matrix.
    % The fspecial function generates the Gaussian filter with the current standard deviation s(i).
    h = ones(size(IMGfft)) - fspecial('gaussian',size(IMGfft),s(i));
    filtered = IMGfft.*h; %apply the HPF
    energy = sum(sum(abs(filtered).^2));
    if energy >= P_energy*Energy 
        filteredIMG = abs(ifft2(filtered));
        break
    end
end
end

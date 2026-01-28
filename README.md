# Motion-Detection

Image Processing Lab Report
This document serves as a comprehensive lab report and code repository for an Image Processing course. It demonstrates various techniques for manipulating digital images using MATLAB, ranging from basic contrast adjustments to complex morphological animations.

📄 Overview

Context: Lab report for "Physiological Signal Processing / Image Processing".


Authors: Orel Betito & Eden Koresh.



Core Concepts: The report covers histograms, linear and non-linear filtering (Gaussian, Median, Laplacian), frequency domain analysis (FFT), and edge detection (Sobel, LoG).

🏃‍♂️ Motion & Animation Highlights
The project places a special emphasis on Morphological Operations, using them creatively to simulate movement and restore images.

1. The "Walking" Stick-Man (Morphological Animation)
The project includes a custom function, IMove, which generates an animation of a "stick-man" figure walking across the screen.


How it works: Instead of simply redrawing the figure at new coordinates, the code uses Dilation and Erosion.



The Mechanism: To move the figure (e.g., to the right), the code dilates (expands) the pixels in the direction of movement and erodes (deletes) the pixels from the opposite side.



Result: This sequence of expanding and shrinking creates a frame-by-frame "walking" effect, which is exported as an animated GIF.

2. "Eye Exam" & Pattern Detection
The report addresses "eyes" in two distinct ways—restoring visibility to an eye chart and finding eye-like patterns:

Eye Exam Restoration: The code takes an image of an Eye Exam chart that has been corrupted by "Salt & Pepper" noise (random black and white pixels). It uses morphological Opening (dilation followed by erosion) and Closing to "clean" the chart and make the letters readable again.


Pattern Matching ("Finding Eyes"): The LocateCirc function implements a "Hit-or-Miss" transform to scan an image and detect specific shapes. In the report, it successfully identifies multiple concentric circle patterns (resembling eyes or bullseyes) scattered across a noisy background.



🛠️ Additional Functionality

Image Sharpening: Uses Laplacian filters to remove blur and highlight details.


Edge Detection: Implements Sobel and Laplacian of Gaussian (LoG) operators to find the boundaries of objects (demonstrated on an image of Saturn).



Fun Features: Includes a function AddToMandi that segments people from a photo and superimposes them onto a background image of "Mandi at the museum".

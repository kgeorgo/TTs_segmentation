# TTs_segmentation
The aim of this custom macro is to apply it on confocal images or already-processed images to extract the inter Transverse Tubular (inter TT) network in primary cardiomyocytes. The application of this approach is not limited to the extraction of inter TTs but can prove useful for the segmentation of any tubule-like structures. This custom macro employs pre-built ImageJ plugins like the BioVoxxel 2D/3D Toolbox and specifically the Tubeness filter. Additionally, the Watershed algorithm is integrated in the macro to analyze each inter TT area seperately and allow quantitative analyses.

## Installation 
To run the custom macro the installation of the [BioVoxxel 3D Box](https://github.com/biovoxxel/bv3dbox/blob/main/README.md) ImageJ sites is necessary
(bv3dbox; clij; clij2; clijx-assistant; clijx-assistant-extensions; 3D ImageJ Suite).
Installation of **Read and Write Excel** (https://imagej.net/plugins/read-and-write-excel) allows you to automatically save your results in an Excel file. 

## Macro demonstration 
Here we show the image processing pipeline for segmentation using our custom macro. The macro adjusts the adjust the contract of the original confocal image (a) to enhance the structures of interest and select a ROI within the image to duplicate and analyze (b). The macro uses a Median filter to remove background noise over the ROI (c) and after it converts the image to 32-bit (d), it runs a tubeness filter to segment tubule-like structures (e). The TTs initially appear in the foreground (white) (f) and then the foreground is inverted to bring the inter TT areas in the foreground (white) (g). The watershed is ran on the segmented image and the analysis of particles allows the quantification of each inter TT area (h). For a qualitative assessment we show the overlay of the extracted inter TT areas and the original confocal image. 

![Github figure1](https://github.com/kgeorgo/TTs_segmentation/assets/133637188/af9a1e44-fd7a-4635-8bc7-b5aea8fb3c22)

In the second example we show a confocal image (a) that underwent ridge detection (Biomedical Imaging Group, Ridge Detector) (b) prior to the application of our custom macro. Similarly, the tubeness filter is applied on the binary image (c) and the image is inverted to bring the inter TT areas in the foreground. The watershed algorithm and particle analysis allow the extraction of all inter TT areas (d). An overlay of the extracted inte TT areas and the original confocal image is shown in (f).

![Github figure2](https://github.com/kgeorgo/TTs_segmentation/assets/133637188/5b532e62-3c94-4a16-9664-0da584019565)

## Disclaimer
We present an approach to extract the TT and inter TT networks in images of primary cardiomyocytes using a combination of prebuilt ImageJ plugins, including [BioVoxxel 3D Box](https://github.com/biovoxxel/bv3dbox/blob/main/README.md), [Watershed](https://github.com/imagej/ImageJ/blob/v1.53q/src/main/java/ij/plugin/filter/EDM.java), and [Read and Write Excel](https://imagej.net/plugins/read-and-write-excel#disclaimers-and-licencing-stuff)  

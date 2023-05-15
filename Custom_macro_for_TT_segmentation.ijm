//A custom ImageJ macro to extract the inter T Tubular (inter TT) network in primary cardiomyocytes and allow quantitative analysis.
//It employs pre-built ImageJ plugins like the Tubeness filter (BioVoxxel 2D/3D Toolbox), Watershed, Read and Write Excel

//Fiji setup
run("Set Measurements...", "area redirect=None decimal=3");
setOption("BlackBackground", true);
setForegroundColor(255, 255, 255);
setBackgroundColor(0, 0, 0);

//image pre-processing
originalImage = getTitle();
title = getTitle();
run("Enhance Contrast...", "saturated=5 normalize"); //to enhance structures within the original image (eg if confocal image is used); you can adapt settings according to your needs; comment this line if eg you are using a binary image as a starting image
setTool("rectangle");
waitForUser("Please, select your ROI and press Ok"); //to exclude regions (eg the outer plasma membrane of the cell) from the analysis

//only one sample should be in the ROI
run("Duplicate...", " "); //to duplicate the selected ROI and analyse the duplicate
duplicate = getTitle();

run("Select None");

//extraction of complete sample area/ROI
run("Voronoi Threshold Labler (2D/3D)", "filtermethod=Median filterradius=5.0 backgroundsubtractionmethod=None backgroundradius=6.0 histogramusage=[ignore both] thresholdmethod=Li fillholes=2D separationmethod=[DoG Seeds] spotsigma=20.0 maximaradius=11.0 volumerange=50000-Infinity excludeonedges=false outputtype=Labels stackslice=1 applyoncompleteimage=false processonthefly=true"); //to remove noise from the image with the use of the "Median" filter; comment this line if eg you are using a binary image as a starting image

//extraction of tubular/void network
selectWindow(duplicate);
run("32-bit");
run("Voronoi Threshold Labler (2D/3D)", "filtermethod=Tubeness filterradius=4.0 backgroundsubtractionmethod=TopHat backgroundradius=6.0 histogramusage=[ignore both] thresholdmethod=Li fillholes=Off separationmethod=None spotsigma=20.0 maximaradius=11.0 volumerange=25-Infinity excludeonedges=false outputtype=Binary stackslice=1 applyoncompleteimage=false processonthefly=false"); //to segment "tube-like" structures with the use of the "Tubeness" filter; the T-tubules are now in the foreground
tubularSystem = getTitle();

//inverting image to get the void areas as foreground
run("Invert"); //to bring the inter T-tubular areas in the foreground; if TT selection is desired comment this line

//treat each void as a distinct region
run("Watershed");
run("Analyze Particles...", "size=0-Infinity display clear add");
run("Create Selection");
roiManager("Add");
count = roiManager("count");
array = newArray(count);
  for (i=0; i<array.length; i++) {
      array[i] = i;
  }
roiManager("select", array);
roiManager("measure") //to measure the size of each inter T-tubular area; note if your ImageJ settings measure in pixels^2 or um^2
selectWindow("Results");
run("Read and Write Excel", "file=[C:/Desktop/Users/Your_Username/Your_folder_name/Your_excel_file_name.xlsx] dataset_label=[your_labe]") //to save the inter TT areas measurements in an excel folder for further quantitative analysis; copy the directory address where you want to save the excel file
selectWindow("Results");
run("Close");

//save all open images for future reference and revision 
dir = getDirectory("Choose a Directory");
//ids=newArray(nImages);
for (i=0;i<nImages;i++) {
        selectImage(i+1);
        title = getTitle;
        print(title);
        //ids[i]=getImageID;

        saveAs("tiff", dir+title);
} 

//save ROI set for future reference and revision 
originalImage = getTitle();
dir = getDirectory("Choose a Directory");
for (i=0;i<nImages;i++) {
        selectImage(i+1);
        title = getTitle;
        print(title);
selectWindow("ROI Manager");
roiManager("Show All");
run("Select All");
roiManager("Save", dir + title + ".zip")

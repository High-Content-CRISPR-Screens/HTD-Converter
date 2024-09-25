// --- HTD Converter ---
// This macro converts the HTD images into OME-TIFF files for easier analysis in freewares.

// --- Initialization ---
run("Options...", "iterations=1 count=1 black");
run("Bio-Formats Macro Extensions"); 
setBatchMode(true);

// --- Main  ---
#@ File (label = "Select Image:", style = "file") file
imageFolder = File.getDirectory(file);
outputDirectory = imageFolder + File.separator + File.getNameWithoutExtension(file);
Ext.setId(file);

// Determine the number of series (i.e. images)
Ext.getSeriesCount(seriesCount);

// Prepare the destination directory
if (!File.exists(outputDirectory)){
	File.makeDirectory(outputDirectory);
}

// read the file and save it
for (seriesNo=1; seriesNo <= seriesCount; seriesNo++) { //uncomment for batch
	print("Analysing Series No "+ seriesNo + "/" + seriesCount);
	run("Bio-Formats Importer", "open=" + file + " autoscale color_mode=Default rois_import=[ROI manager] view=Hyperstack stack_order=XYCZT series_list=" + seriesNo);
	img = getTitle();
	outputPathFull = outputDirectory + File.separator + img + ".tif";
	saveAs("TIFF", outputPathFull);
	close();
}
print("Convertion Complete.");
setBatchMode(false);

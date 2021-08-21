# Hyperspectral_agriculture_analysis
This repo intention is to help you analyze hyperspectral data taken from agriculture field experiments throughout the season. 
For example, if you are working on a wheat field experiment and every week you measured the plots with an Analytical Spectral Device that recorded the reflectance of the plant in ~2000 wavelength, the code could help you to compute all the available normalize difference spectral indices from every week and to correlate them to a plant feature you measured.
Basically the code defining two functions:
1. *spectra_pearson_r* 
2. *spectra_pearson_p*

What is spectra? spectra is a data set of reflectance measured from narrow wavelength channels. It can be hunreds or tousands. 
The functions have two arguments:
1. spectra.
2. feature.

The spectra need to be organised as follows:
When you read it to R, preferably from a csv file. Columns are wavelength and rows are samples, each row have a matching biological feature. 
The feature need to be a vector with the same number of rows as the spectra.
**It is ok to leave the column names with "X" sign as R read them, the function removing the""

Please go to the Rmarkdown file in the repo to see a detailed example. 


# WRF Deployment

This scripts can deploy a already precompiled version of the WRF model in the
home directory of the user calling this script. On default it will download the
latest version of WRFV4 (currently: 4.1.5) and the minimal geodata (~200 mb) 
required to start a model run. The main script will be extended to accept
parameters to customize the deployment process.

## Parameters
* WRF version, currently available: 3.8.0, 3.8.1, 3.9.0, 3.9.1, 4.0.2, 4.1.5
* Geodata: 
	* WRFV3 lowres (~200 mb), WRFV3 highres (~50 gb)
	* additional resolutions can the downloaded manually from [Link](http://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog_V3.html)
	* WRFV4 lowres (~200 mb), WRFV4 hightes (~50 gb)
	* overview of WRFV4 geo data and manual download of additional resolutions is available [here](http://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog.html)
* Visualization of WRF results with precompiled ncl

## Usage
Simply call the deployment script
```
    ./deploy_wrf.sh
```

## Additional manual prepartions
Depending on the deployed wrf_model a few manual steps are required to do before running the model
* build directory: set correct directory in run_model.sh
* namelist file for WPS: set to correct path to the geo data (that will be automated in the future and integrated into the deployment)
* wrf_output directory: adjust destination folder and destination suffix for the output files in draw_plots.sh
* configure e-mail settings:
	* configure mail text and default sender in create_mail.sh
	* configure .msmtp file for correct mail settings
* adjust tslist for further locations (optional)

## Troubleshooting
* check if the copied namelist.wps works for your geo data, the WRFV4 lowres data needs the lowres data instead of default
* check the correct build path
* check for correct ggc-fortran libraries if the output with ncl causes any trouble

## NCL usage
As of september 2019 the ncar command language used for the current wrf output is no longer developed. 
The last binary version has been built with gcc 6.3.0 and need libgfortran3.so to run correctly.
To use this as a library for visualizing the wrf output a workaorund is the usage of a parallel gcc version.
That is done within the `load_packages.sh`. The compilation process of the gcc6 package takes up to a few hours.
After that the model run will set the path to the missing libgfortran3.so when creating the output with ncl.

## License
see LICENSE

## Todo
check issues with wrf_deploy label

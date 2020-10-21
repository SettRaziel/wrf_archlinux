# WRF Deployment

This scripts can deploy a already precompiled version of the WRF model in the
home directory of the user calling this script. On default it will download the
latest version of WRFV4 (currently: 4.1.5) and the minimal geodata (~200 mb) 
required to start a model run. The main script will be extended to accept
parameters to customize the deployment process.

## Parameters
* WRF version, currently available: 3.9.0, 3.9.1, 4.0.2, 4.1.5, 4.2.0
* Geodata: 
	* WRFV3 lowres (~200 mb), WRFV3 highres (~50 gb)
	* additional resolutions can the downloaded manually from [Link](http://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog_V3.html)
	* WRFV4 lowres (~200 mb), WRFV4 hightes (~50 gb)
	* overview of WRFV4 geo data and manual download of additional resolutions is available [here](http://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog.html)
* Visualization of WRF results with wrf_visualization based on pyngl, pynio which will be installed using wrf_deploy

## Usage
Simply call the deployment script
```
    ./deploy_wrf.sh
```
The deployment script can be used with the parameter --default, which will deploy the latest version of the WRF model with minimal
geodata. But there is no need for manual selection of the required model version and geodata.

## Additional manual prepartions
Depending on the deployed wrf_model a few manual steps are required to do before running the model
* build directory: set correct directory in run_model.sh
* namelist file for WPS: set to correct path to the geo data (that will be automated in the future and integrated into the deployment)
* wrf_output directory: adjust destination folder and destination suffix for the output files in draw_plots.sh
* configure e-mail settings:
	* configure mail text and default sender in create_mail.sh
	* configure .msmtp file for correct mail settings
* adjust tslist for further locations (optional)

## Migration
When changing WRF versions or other software components it is useful to migrate your model setup rather than redeploying it on the same machine.
Since this project already handles installing, running and deploying the model it should not be the repository for additional migration script.
Starting with the change from ncl to the python based wrf_visualization the repository [wrf_utils](https://github.com/SettRaziel/wrf_utils) will
add some migration scripts for migrating to other WRF versions or software components. These scripts need to be created and test in a given enviroment,
so apply them with care, while there are still in testing. If you apply them an run into trouble, please create an issue in the wrf_utils repository.
You have access to the following migration scripts:
* Migration from ncl to wrf_visualization: [ncl_migration](https://github.com/SettRaziel/wrf_utils/blob/development/migration/visualization_migration.sh)

## Troubleshooting
* check if the copied namelist.wps works for your geo data, the WRFV4 lowres data needs the lowres data instead of default
* check the correct build path
* (DEPRECATED) check for correct ggc-fortran libraries if the output with ncl causes any trouble

## NCL usage (DROPPED)
As of september 2019 the ncar command language used for the current wrf output is no longer developed. 
The last binary version has been built with gcc 6.3.0 and need libgfortran3.so to run correctly.
To use this as a library for visualizing the wrf output a workaorund is the usage of a parallel gcc version.
That is done within the `load_packages.sh`. The compilation process of the gcc6 package takes up to a few hours.
After that the model run will set the path to the missing libgfortran3.so when creating the output with ncl.
The usage of NCL is dropped with v0.5.0.

## License
see LICENSE

## Todo
check issues with wrf_deploy label

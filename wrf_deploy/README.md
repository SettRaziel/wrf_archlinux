# WRF Deployment

This scripts can deploy a already precompiled version of the WRF model in the
home directory of the user calling this script. Initially it will download the
latest version of WRFV3 (currently: 3.9.1) and the minimal geodata (~200 mb) 
required to start a model run. The main script will be extended to accept
parameters to customize the deployment process.
WRFV4 will be the default download once it runs properly.

## Parameters
* WRF version, currently available: 3.8.0, 3.8.1, 3.9.0, 3.9.1, 4.0.2
* Geodata: 
	* WRFV3 lowres (~200 mb), WRFV3 highres (~50 gb)
	* additional resolutions can the downloaded manually from [Link](http://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog_V3.html)
	* WRFV4 lowres (~200 mb), WRFV4 hightes (~50 gb)
* Visualization of WRF results with precompiled ncl

## Usage
Simply call the deployment script
```
    ./deploy_wrf.sh
```

## Additional run prepartions
Depending on the deployed wrf_model a few manual steps are required to do before running the model
* build directory: set correct directory in run_model.sh
* wrf_output directory: adjust destination folder and destination suffix for the output files in draw_plots.sh
* configure e-mail settings:
	* configure mail text and default sender in create_mail.sh
	* configure .msmtp file for correct mail settings
* adjust tslist for further locations (optional)

## License
see LICENSE

## Todo
* Parameters for the deployment script to deploy custom setups see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/4)
* adding WRFV4 deployment; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/2)
* adding WRFV4 geo data; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/2)
* adding deployment for hybrid vertical coordinated; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/8)

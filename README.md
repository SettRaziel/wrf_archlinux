# WRF Forecast System

Scripts and documentation to run your own WRF model forecast system on
ArchLinux. The descriptions will grow together with the uploaded files.

# Folder Overview
* wrf_install: contains scripts to install and configure the wrf model and its
  requirements

# Sources
* basic system: [here](https://wiki.archlinux.org/index.php/Installation_guide)
* wrf tutorial: [here](http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php)

# License
The scripts are licensed under the given license file. 3rd party software and
scripts are marked and can have different license conditions. Please check the
folders for subsidiary license files.

## Software components
* Network Common Data Form (NetCDF): [Source](https://www.unidata.ucar.edu/software/netcdf/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 4.4.1.1
* NetCDF-Fortran Library: [Source](https://www.unidata.ucar.edu/software/netcdf/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 4.4.4
* Message Passing Interface (mpich): [Source](https://www.mpich.org/) and [License](http://git.mpich.org/mpich.git/blob/HEAD:/COPYRIGHT), used version: 3.2
* PNG reference library (libpng): [Source](http://www.libpng.org/pub/png/libpng.html) and [License](http://www.libpng.org/pub/png/src/libpng-LICENSE.txt), used version: 1.6.28
* A Massively Spiffy Yet Delicately Unobtrusive Compression Library (zlib): [Source](www.zlib.net) and [License](http://www.zlib.net/zlib_license.html), used version: 1.2.11
* JasPer Project (JasPer): [Source](https://www.ece.uvic.ca/~frodo/jasper/) and [License](https://www.ece.uvic.ca/~frodo/jasper/LICENSE), used version: 1.900.1
* Optional postprocessing tools:
  - Unified Post Processor (UPP): [Source](http://www.dtcenter.org/wrf-nmm/users/downloads/index.php), needs email validation
  - NCAR Command Language (NCL): [Source](https://www.ncl.ucar.edu/Download/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 6.4.0 Binaries

# Additional configurations
* install_wrf.sh: Set the correct file paths
  - BUILD_PATH: the path relative from the home folder, where the model data
    should be installed
  - WRF_ROOT_PATH: the absolute path to the home folder of the used user plus
    the $BUILD_PATH to the wrf model root
* libraries: adjust the number of used cores by changing the -j parameter

# Compile Options, that worked for me
* WPS: 1 gfortran serial
* WRF: 35 gfortran dm+sm
* UPP (if used): 7 gfortran serial

# Todos:
* generic file paths will be added later as shell parameters
* ncl examples for output
* cronjob details
* intermediate results during wrf_run
* installation details

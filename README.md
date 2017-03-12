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

# Additional configurations
* install_wrf.sh: Set the correct file paths
  - BUILD_PATH: the path relative from the home folder, where the model data
    should be installed
  - WRF_ROOT_PATH: the absolute path to the home folder of the used user plus
    the $BUILD_PATH to the wrf model root

# Todo
* generic file paths will be added later as shell parameters

# WRF Forecast System

Scripts and documentation to run your own WRF model forecast system on
ArchLinux. The descriptions will grow together with the uploaded files.
A description that summarizes the requried steps and gives additional
information will be available shortly.

Current version: v0.1.0

# Current content
* scripts to install the wrf model on a minimum arch linux installation
* basic script collection to start a model run

# Folder Overview
* wrf_install: contains scripts to install and configure the wrf model and its
  requirements
* wrf_run: contains scripts to fetch the required input data, prepare the
  start values and execute a model run
* additions: additional scripts and files that can help running the model

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
  - NCAR Command Language (NCL): [Source](https://www.ncl.ucar.edu/Download/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 6.4.0_nodap Binaries

# Additional install configurations
* install_wrf.sh: Set the correct file paths
  - BUILD_PATH: the path relative from the home folder, where the model data
    should be installed
  - WRF_ROOT_PATH: the absolute path to the home folder of the used user plus
    the $BUILD_PATH to the wrf model root
  - the path to the required libraries
* libraries: adjust the number of used cores by changing the -j parameter

# Compile Options, that worked for me
* WPS: 1 gfortran serial
* WRF: 35 gfortran dm+sm
* UPP (if used): 7 gfortran serial

# Run options
* grid parameter (namelists)
  - horizontal grid size: grid_dx, grid_dy
  - vertical grid size: grid_dz
  - horitontal grid resolution: dx, dy
  - start time stamp

# Troubleshooting
* If one of the mpi test fails with a naming error, check if you have set the
hostname from your /etc/hostname in your file /etc/hosts. Since mpi can run
on a cluster it needs a valid name to work with several machines.
* Installing and running the model should be done with gcc/gcc-libs/gcc-gfortran
  6.3.1-2. During the wrf compilation an error occurs like:
   ```
   CALL RANDOM_SEED(PUT=count)
                     1
   Error: Size of 'put' argument of 'random_seed' intrinsic at (1) too small (12/33)
    ```
    This can be avoided by editing phys/module_cu_g3.F and setting the dimension of seed
    to the required value.
    When running the model it breaks (last check: 2017/05/30) since the model needs libgfortran.so.3
    which cannot be found after upgrading the gcc-gfortran to 7.1.1-2. Even compiling WRFV3.9 and
    WPSV3.9 does not resolve this issue.
* NCL: If you have problems with ncl and missing ssl libraries, use the nodap binaries

# Todos:
* generic file paths will be added later as shell parameters
* archive cleanup after installation
* ncl examples for output
* cronjob details
* intermediate results during wrf_run
* installation details

created by: Benjamin Held, March 2017

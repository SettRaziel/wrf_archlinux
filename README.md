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
* ncl output: [here](https://www.ncl.ucar.edu/Applications/)

# License
The scripts are licensed under the given license file. 3rd party software and
scripts are marked and can have different license conditions. Please check the
folders for subsidiary license files.

## Software components
* WRF Model / WPS: [Source](http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php), used version: 3.8.1
* Network Common Data Form (NetCDF): [Source](https://www.unidata.ucar.edu/software/netcdf/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 4.4.1.1
* NetCDF-Fortran Library: [Source](https://www.unidata.ucar.edu/software/netcdf/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 4.4.4
* Message Passing Interface (mpich): [Source](https://www.mpich.org/) and [License](http://git.mpich.org/mpich.git/blob/HEAD:/COPYRIGHT), used version: 3.2
* PNG reference library (libpng): [Source](http://www.libpng.org/pub/png/libpng.html) and [License](http://www.libpng.org/pub/png/src/libpng-LICENSE.txt), used version: 1.6.34
* A Massively Spiffy Yet Delicately Unobtrusive Compression Library (zlib): [Source](http://www.zlib.net) and [License](http://www.zlib.net/zlib_license.html), used version: 1.2.11
* JasPer Project (JasPer): [Source](https://www.ece.uvic.ca/~frodo/jasper/) and [License](https://www.ece.uvic.ca/~frodo/jasper/LICENSE), used version: 1.900.2
* Optional postprocessing tools:
  - Unified Post Processor (UPP): [Source](http://www.dtcenter.org/wrf-nmm/users/downloads/index.php), needs email validation
  - NCAR Command Language (NCL): [Source](https://www.ncl.ucar.edu/Download/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 6.4.0_nodap Binaries

# Additional install configurations
* install_wrf.sh: Set the correct file paths
  - BUILD_PATH: the path relative from the home folder, where the model data
    should be installed
  - WRF_ROOT_PATH: on default the home folder + the build path is used, adjust if necessary
* libraries: adjust the number of used cores by changing the -j parameter
* starting with WRF v3.9 the model can use a hybrid approach for the vertical coordinate
  (see manual for details); atm the corresponding parameter -hyb needs to be set manually

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

# Known issues
* Since the model creates intermediate output every 3 hours (configurable in namelist.input)
  it is useful to choose a forecast range accordingly to that time step
* The total rain output is calculated for a 6 hour interval. Choosing a forecast interval that is not
  a common multiple of 6 leads to errors for the total rain output that prevents the data from
  being copied to the destination folder (that needs to be adresses in the ncl output script)
* The forecast uses the unix date command to determine the start and end date. Using full days (e.g
  24 hours, 72 hours, ...) leads to a problem to determine the correct dates. That issue will be
  adressed soon.
* Model instability as statet in Troubleshooting

# Working setup and testing setups
This section describes the current working setup based under the condition that the installation is
successful and a model run is starting for a given time stamp of input data. Unstable means that for
the current namelist-files some model runs end preliminary with an error.
The different setups will be categorized in
* {compiling, not_compiling}
* {debug_build, normal_build, hybrid_build, combined_build}
* {running, unstable, not_running}

Additionally all setups use gcc/gcc-libs/gcc-gfortran 6.3.1-2 until described 
otherwise.
* current setup:
  - WRF Model and WPS v3.8.1 [compiling, normal_build, unstable]
    - NetCDF v4.4.1.1 / NetCDF-Fortran Library v4.4.4
    - mpi v3.2, libpng v1.6.28, zlib v1.2.11, JasPer v1.900.1
* testing setup:
  - WRF Model and WPS v3.9 [not_compiling, hybrid_build, not_running]
    - NetCDF v4.5.0 / NetCDF-Fortran Library v4.4.4
    - mpi v3.2.1, libpng v1.6.34, zlib v1.2.11, JasPer v1.900.1
* tested setups:
  - WRF Model and WPS v3.8.1 [compiling, normal_build, unstable]
    - NetCDF v4.4.1.1 / NetCDF-Fortran Library v4.4.4
    - mpi v3.2, libpng v1.6.34, zlib v1.2.11, JasPer v1.900.2
  - WRF Model and WPS v3.9 [compiling, normal_build, unstable]
    - NetCDF v4.5.0 / NetCDF-Fortran Library v4.4.4
    - mpi v3.2.1, libpng v1.6.34, zlib v1.2.11, JasPer v1.900.1

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
* My model instability seems to result from the choosen model area. Considering posts from the WRF 
  forum it can be caused by high orography near the model borders or CFL violations in the vertical wind
  interpolation. Consider trying a model area with an island or a whole continent if your model runs 
  fail shortly after the wrf.exe starts running. So you will have water near the boundaries.
  - even the model area around Iceland does crash occasionally. Not clear if that is caused by CFL 
    violations or faulty GFS data. Setting the model area to central europe results in crahes at
    the first model iteration. Setting additional dampening parameters and settings for the vertical
    interpolation does not improve the problem. If you have a solution please write me an e-mail.
* Sometimes the virtual machine freezes when trying to make a model run. Looking on the last entries  
  of the system log most of the time the machine freezes while loading input data.
  - The latest change to adress this problem is the usage of flock within the script that prevents two or more
    parallel model runs
* Using different resolutions for x and y seems to lead to an error, that file informations do not
  concur with the settings from the namelist file. Only the value of dx seems to be used. This
  needs to be reviewed.

# Todos:
* better error handling, error logging and script behavior in error cases
* generic file paths will be added later as shell parameters
* archive cleanup after installation
* ncl examples for output
* cronjob details
* intermediate results during wrf_run
* installation details
* testing of newer wrf version, e.g. WRFV3.9
* testing the new hybrid vertical coordinate for WRFV3.9 and higher
* more error checks:
  - e.g. checks that the run time of the model need to be a multiple of three
    (as long as the output interval is static and set to 3 hours)

created by: Benjamin Held, March 2017

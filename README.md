# WRF Forecast System

Scripts and documentation to run your own WRF model forecast system on
ArchLinux. The descriptions will grow together with the uploaded files.
A description that summarizes the requried steps and gives additional
information will be available shortly.

Current version: v0.2.0

## License
The scripts are licensed under the given license file. 3rd party software and
scripts are marked and can have different license conditions. Please check the
folders for subsidiary license files.

## Current content
* scripts to install the wrf model on a minimum ArchLinux installation
* basic script collection to start a model run
* scripts to deploy a precompiled archive on an ArchLinux system 

## Folder Overview
* wrf_install: [readme](./wrf_install/README.md)
  * contains scripts to install and configure the wrf model and its requirements
* wrf_run: [readme](./wrf_run/README.md)
  * contains scripts to fetch the required input data, prepare the start values and execute a model run
* wrf_deploy: [readme](./wrf_deploy/README.md)
  * contains scripts to load and deploy a precompiled wrf archive
* additions: additional scripts and files that can help running the model

## Sources
* basic system: [here](https://wiki.archlinux.org/index.php/Installation_guide)
* wrf tutorial: [here](http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php)
* ncl output: [here](https://www.ncl.ucar.edu/Applications/)

## Software components
* WRF Model / WPS: [Source](http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php), used version: 3.9.1
* Network Common Data Form (NetCDF): [Source](https://www.unidata.ucar.edu/software/netcdf/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 4.6.0
* NetCDF-Fortran Library: [Source](https://www.unidata.ucar.edu/software/netcdf/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 4.4.4
* Message Passing Interface (mpich): [Source](https://www.mpich.org/) and [License](http://git.mpich.org/mpich.git/blob/HEAD:/COPYRIGHT), used version: 3.2
* PNG reference library (libpng): [Source](http://www.libpng.org/pub/png/libpng.html) and [License](http://www.libpng.org/pub/png/src/libpng-LICENSE.txt), used version: 1.6.34
* A Massively Spiffy Yet Delicately Unobtrusive Compression Library (zlib): [Source](http://www.zlib.net) and [License](http://www.zlib.net/zlib_license.html), used version: 1.2.11
* JasPer Project (JasPer): [Source](https://www.ece.uvic.ca/~frodo/jasper/) and [License](https://www.ece.uvic.ca/~frodo/jasper/LICENSE), used version: 1.900.2
* Optional postprocessing tools:
  - Unified Post Processor (UPP): [Source](http://www.dtcenter.org/wrf-nmm/users/downloads/index.php), needs email validation
  - NCAR Command Language (NCL): [Source](https://www.ncl.ucar.edu/Download/) and [Terms of use](https://www2.ucar.edu/terms-of-use), used version: 6.4.0_nodap Binaries / newest version 6.5.0

## Working setup and testing setups
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
  - WRF Model and WPS v3.9.1 [compiling, normal_build, unstable]
    - NetCDF v4.4.1.1 / NetCDF-Fortran Library v4.4.4
    - mpi v3.2, libpng v1.6.28, zlib v1.2.11, JasPer v1.900.1
* testing setup:
  - starting WRFV4 soon
* tested setups:
  - WRF Model and WPS v3.8.1 [compiling, normal_build, unstable]
    - NetCDF v4.4.1.1 / NetCDF-Fortran Library v4.4.4
    - mpi v3.2, libpng v1.6.34, zlib v1.2.11, JasPer v1.900.2
  - WRF Model and WPS v3.9 [compiling, normal_build, unstable]
    - NetCDF v4.5.0 / NetCDF-Fortran Library v4.4.4
    - mpi v3.2.1, libpng v1.6.34, zlib v1.2.11, JasPer v1.900.1
  - WRF Model and WPS v3.91 [compiling, normal_build, unstable]
    - NetCDF v4.6.0 / NetCDF-Fortran Library v4.4.4
    - mpi v3.2.1, libpng v1.6.34, zlib v1.2.11, JasPer v1.900.2

## Todos
Check the subsidiary readmes or issues for further work
* wrf_install: [readme](./wrf_install/README.md)
* wrf_run: [readme](./wrf_run/README.md)
* wrf_deploy: [readme](./wrf_deploy/README.md)

## Contributing
* Fork it
* Create your feature branch (git checkout -b my-new-feature)
* Commit your changes (git commit -am 'add some feature')
* Push to the branch (git push origin my-new-feature)
* Create an issue describing your work
* Create a new pull request

created by: Benjamin Held, March 2017

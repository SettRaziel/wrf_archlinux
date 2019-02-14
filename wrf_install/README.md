# WRF installation scripts

## License
The installation scripts are based on the the tutorial of the wrf model that can be found
[here](http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php).

## Additional install configurations
* install_wrf.sh: Set the correct file paths
  - BUILD_PATH: the path relative from the home folder, where the model data
    should be installed
  - WRF_ROOT_PATH: on default the home folder + the build path is used, adjust if necessary
* libraries: adjust the number of used cores by changing the -j parameter
* starting with WRF v3.9 the model can use a hybrid approach for the vertical coordinate
  (see manual for details); atm the corresponding parameter -hyb needs to be set manually
* postprocessing options:
  - ncl is now the default postprocessing tool that will be installed automatically

## Compile Options, that worked for me
* WPS: 1 gfortran serial
* WRF: 35 gfortran dm+sm
* UPP (if used): 7 gfortran serial

## Troubleshooting
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
    which cannot be found after upgrading the gcc-gfortran to newer version. Even compiling WRFV3.9 and
    WPSV3.9 does not resolve this issue.
* NCL: If you have problems with ncl and missing ssl libraries, use the nodap binaries

## Todos:
* better error handling, error logging and script behavior in error cases; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/3)
* generic file paths will be added later as shell parameters
* archive cleanup after installation (added)
* alternate postprocessing options: choice between upp and ncl during installation
* installation details
* testing of newer wrf version, e.g. WRFV4; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/6)
* testing the new hybrid vertical coordinate for WRFV3.9 and higher; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/7)
* testing newer gcc/gfortran with WRFV4

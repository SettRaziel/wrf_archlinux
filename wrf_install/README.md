# WRF installation scripts

## License
The installation scripts are based on the the tutorial of the wrf model that can be found
[here](http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php).
The installation scripts are for the compilation of new versions or different WRF configurations.
If you want to run the WRF model and chose to compile it on your own be advised that serveral manual steps are required to run it afterwards.
For running the model without compiling everything from scratch try the deployment scripts. They minimize the manual configuration steps that
are requried to run the model on your own hardware.

## Additional install configurations
* install_wrf.sh: Set the correct file paths
  - BUILD_PATH: the path relative from the home folder, where the model data
    should be installed
  - WRF_ROOT_PATH: on default the home folder + the build path is used, adjust if necessary
  - installation with local libraries: all libraries must be present in the folder libraries in the repository folder
    by adding --local as a script parameter
  - if no build path is set the script will fail, a default folder will be added with [(#26)](https://github.com/SettRaziel/wrf_archlinux/issues/26)
* libraries: adjust the number of used cores by changing the -j parameter
* starting with WRF v3.9 the model can use a hybrid approach for the vertical coordinate
  (see manual for details); atm the corresponding parameter -hyb needs to be set manually
* postprocessing options:
  - ncl is the default postprocessing tool that will be installed automatically at the moment. Since it was set to maintance mode in Sep. 2019 a
    replacement is needed. If you still want to use it you need to install a version of gcc 6, e.g. 
    ```
    yay -S --needed gcc-fortran 
    ```
    that will compile the latest gcc 6 version. This is not included in the installation process since the compilation can take several hours. You need to do that
    manually using the command above.

## Compile Options, that worked for me
* WPS: 1 gfortran serial
* WRF: 35 gfortran dm+sm
* UPP (if used): 7 gfortran serial

## Troubleshooting
* If one of the mpi test fails with a naming error, check if you have set the
hostname from your /etc/hostname in your file /etc/hosts. Since mpi can run
on a cluster it needs a valid name to work with several machines.
* WRF with Version less then 4: Installing and running the model should be done with 
  gcc/gcc-libs/gcc-gfortran 6.3.1-2. During the wrf compilation an error occurs like:
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
* WRF version 4: Compiling the WRF sources did not succeed every time. Roughly half the compile tests failed, mostly with
  the message of an compiler problem / bug. Recompiling with the same settings lead to a successful build. But with WRFV 4
  the gcc / gcc-fortran version 8 could be used.
* NCL: If you have problems with ncl and missing ssl libraries, use the nodap binaries

## Todos:
* better error handling, error logging and script behavior in error cases; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/3)
* generic file paths will be added later as shell parameters
* archive cleanup after installation (added)
* alternate postprocessing options: choice between upp and ncl during installation
* installation details
* testing of newer wrf version, e.g. WRFV4; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/6)
* testing the new hybrid vertical coordinate for WRFV3.9 and higher; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/7)
* testing newer gcc/gfortran with WRFV4; see:[(Issue)](https://github.com/SettRaziel/wrf_archlinux/issues/12)

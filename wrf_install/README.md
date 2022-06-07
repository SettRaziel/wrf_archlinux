# WRF installation scripts

## License
The installation scripts started based on the tutorial of the WRF model that can be found
[here](http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compilation_tutorial.php).
The scripts are for the compilation of new versions or different WRF configurations.
With the development of the model versions and additional knowledge of compiling and dependencies
the presented script collection will increasingly differ from the basic tutorial.
If you want to run the WRF model and chose to compile it on your own be advised that serveral manual
steps are required to run it afterwards. For running the model without compiling everything from scratch 
try the deployment scripts. They minimize the manual configuration steps that are requried to run the model 
on your own hardware.

## Additional install configurations
* install_wrf.sh: Set the correct file paths
  - BUILD_PATH: the path relative from the home folder, where the model data should be installed
  - WRF_ROOT_PATH: on default the home directory + the build path is used, adjust if necessary
  - installation with local libraries: all libraries must be present in the folder libraries in the repository folder
    by adding --local as a script parameter
  - if no build path is given as a script argument the script will show a warning and use the default path: /home/user/WRF
* libraries: adjust the number of used cores by changing the -j parameter
* starting with WRF v3.9 the model can use a hybrid approach for the vertical coordinate
  (see manual for details); atm the corresponding parameter -hyb needs to be set manually
* different library version or WRF/WPS versions: adjusted version numbers in set_env.sh; this may lead to untested conflicts, so handle with care!
* postprocessing options:
  - (DEFAULT) wrf_visualization based on pyngl, pynio
  - ncl was the defult postprocessing tool that can be used with versions below v0.5.0. 
    Since it was set to maintance mode in Sep. 2019 is is considered DEPRECATED. 
    If you still want to use it you need to install a version of gcc 6, e.g. 
    ```
    yay -S --needed gcc6-fortran 
    ```
    that will compile the latest gcc 6 version. 
    This is not included in the installation process since the compilation can take several hours. 
    You need to do that manually using the command above.

## Usage
Call the run script
```
script usage: ./install.sh [parameter]
Install parameter:
     --help         show help text
 -b, --build        argument: <path>; specifies the wrf path
 -l, --local        uses local libraries for installation
```

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
  the gcc / gcc-fortran version 8 or higher can be used.
* gcc / gfortran 10: With version 10 the compiler prohibits mismatches between the calls and the procedure definition that leads to 
  a compile error for at least the netcdf library. This can be moved to a warning using -fallow-argument-mismatch although the usage of
  this option is discouraged.
* The compile logs of WRF and WPS are now stored in the logs folder, check if the executables for the WRF are created and that the WPS
  log did not throw an error, the other libraries will stop the whole installation process since the scripts run with -e flag.
* NCL: If you have problems with ncl and missing ssl libraries, use the nodap binaries

## Todos:
check issues with wrf_install label


# WRF run scripts

## License
see LICENSE

## Additional run preparations
* load geodata for the model
  - WRF version 3: [Link](http://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog_V3.html)
  - WRF Version 4: [Link](http://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog.html)
  - geodata resulutions are described using arc-minutes or arc-seconds, so the resultion values are:
    * 30 arc-seconds
    * 2, 5 or 10 arc-minutes
  - for WRF version 3 not all resolutions are available in the coarse or fine resolution packs, they can
    be downloaded manually and needed to be copied into the geodata folder
  - make sure that you have installed the required packages, especially a compatible fortran compiler (see deployment
    or install scripts for details). The run script does not check if all requried dependencies are installed, since
    it assumes that at least the deploy scripts are used to setup a running environment!

## Run options
* build directory: set correct directory in run_model.sh
* WRF / WPS Version when using different versions than the latest development: set value in set_env.sh
* run parameter for namelists: adjust them in prepare_namelist.sh
  - horizontal grid size: grid_dx, grid_dy
  - horitontal grid resolution: dx, dy
  - reference latitude and longitude
  - start time stamp
* addition grid parameter: set directly in namelist file, the preparation file does not cover that
  - vertical grid size: grid_dz
* meteogram locations can be set in `WRF/test/em_real/tslist`
  - check the description, you have 24 characters for the location name, than identifier and coordinates
  - a readme can be found at: `WRF/run/README.tslist`
  - be cautious with an umlaut like {ö,ä,ü}. Using that in a name leads to an additional char, so a workaround
    that help me was the removal of a padding whitespace between location name and identifier
  - if not locations are set or no locations are present within the model area, the post_processing will write log entries
    into the debug.log, so if no meteograms are available the log should be checked first
* run additional scripts after the model run finishes: after the output creation and before sending the success mail
  there is a new shell script call for additional post hook calls the subsidiary script allows it to call additional scripts
  that should be run before finishing, e.g. moving data to another server

## Usage
Use the script with the follwing settings, mandatory values are hour, period and resolution
```
script usage: ./run_model.sh [parameter]
Model run parameter:
     --help         show help text
     --rerun        the model does a rerun skipping namelist preparation and data fetching
 -a, --archive      argument: <path>; stores the results at the given path
 -b, --build        argument: <path>; specifies the wrf path
 -y, --year         argument: <year>; the model year
 -m, --month        argument: <month>; the model month
 -d, --day          argument: <day>; the model day
 -h, --hour         argument: <hour>; the model hour (mandatory)
 -p, --period       argument: <period>; the forecast duration (mandatory)
 -r, --resolution   argument: <resolution>; the model resolution (mandatory)
```
* input_model_run: {00, 06, 12, 18}
* forecast_time: hours as integer, no whole days (see known issues)
* input_resolution: {0p25, 0p50, 1p00}

## Data source
According to the ncep noaa [website](https://www.nco.ncep.noaa.gov/pmb/products/gfs/#GFS) the input data can be downloaded as of
2020-06-01 from the [nomad](https://nomads.ncep.noaa.gov/pub/) webserver.

## Known issues
* Since the model creates intermediate output every 3 hours (configurable in namelist.input)
  it is useful to choose a forecast range accordingly to that time step
* The total rain output is calculated for a 6 hour interval. Choosing a forecast interval that is not
  a common multiple of 6 leads to errors for the total rain output that prevents the data from
  being copied to the destination folder (that needs to be adresses in the ncl output script)
* The forecast uses the unix date command to determine the start and end date. Using full days (e.g
  24 hours, 72 hours, ...) leads to a problem to determine the correct dates. Update (2021-2-1): Retested that with the 
  current model setup, this error cannot be reproduced. Model run was successful for different paramter combinations.
  The corresponding ticket #5 will be closed, but reopened if the problem occurs again.
* Model instability as statet in Troubleshooting

## Troubleshooting
* My model instability seems to result from the choosen model area. Considering posts from the WRF 
  forum it can be caused by high orography near the model borders or CFL violations in the vertical wind
  interpolation. Consider trying a model area with an island or a whole continent if your model runs 
  fail shortly after the wrf.exe starts running. So you will have water near the boundaries.
  - even the model area around Iceland does crash occasionally. Not clear if that is caused by CFL 
    violations or faulty GFS data. Setting the model area to central europe results in crahes at
    the first model iteration. Setting additional dampening parameters and settings for the vertical
    interpolation does not improve the problem. If you have a solution please write me an e-mail.
      - the current setup works for middle europe as expected, v3.9.1 via wrf_deploy works stable at the moment
* Sometimes the virtual machine freezes when trying to make a model run. Looking on the last entries  
  of the system log most of the time the machine freezes while loading input data.
  - The latest change to adress this problem is the usage of flock within the script that prevents two or more
    parallel model runs
  - running an additional instance on another server with a different virtualization software resulted in a stable
    instance, so it might be possible that the different virtualization or ram errors lead to the freezing behavior
      - April 2019: new virtual machine works without this problem
* Using different resolutions for x and y seems to lead to an error, that file informations do not
  concur with the settings from the namelist file. Only the value of dx seems to be used. This
  needs to be reviewed.
* If the model fails with error regarding namelist and data files or bad file descriptions check the loaded input data.
  Most of the time connection errors lead to incomplete file downloads. The data fetching tries to restart the download
  progress if an error occurs, but the proble, can still occur.
* The input data cannot be loaded from the https address. Check the ftp fileserver for availablity:
  `ftp://ftp.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/`. If its available a temporary workaround to load the data via
  unsecure ftp can be achieved by changing the curl command to
  `curl -f -o "${3}"/gfs.t"${2}"z.pgrb2."${4}".f"${i}" "${GFS_URL}"gfs."${1}"/"${2}"/gfs.t"${2}"z.pgrb2."${4}".f"${i}"`
  This can be achived by using the function `gfs_ftp_fetch_curl` in the gfs_fetch script instead of the normal curl fetch.

## Todos:
check issues with wrf_run label

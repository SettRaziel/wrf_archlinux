# WRF Additions

This folders hold additional informations for configurating and running the WRF model.

## Config
Stores the main configuration files that i use for a model run. The values are choosen with best
knowledge and are optimized over the time. The currently used WRF version is 4.2.0. uses addition 
geo_data. If you deployed version 3.9.1 through the deployment script with the high resolution and
want to use the stored config files you also need to load and unpack the additional 3.9 static data
from [here](http://www2.mmm.ucar.edu/wrf/users/download/get_sources_wps_geog_V3.html). If you don't
have that the model run will fail stating missing geo_data in the debug.log. You can also adjust 
the used geodata in the namelist.wps to used only available data.

; library which holds functions for creating 3 h rain output
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

; function to create the rain sum data
undef("create_3hr_rainsums")
function create_3hr_rainsums(file, ntimes)
local rain_tot
begin
  rain_tot = wrf_user_getvar(file,"RAINNC",-1) + wrf_user_getvar(file,"RAINC",-1)
  rain_tot@description = "Total Precipitation"

  ; creating new arrays
  rain_tot_tend = rain_tot
  rain_tot_tend = 0.0
  rain_tot_tend@description = "3h Precipitation"

  ; calculating precipitation values
  ; data is available every 3 hours, so setting tend_int to 1 gives
  ; tendencies for 3 hours, setting it to 2, gives 6 hourly tendencies
  tend_int = 1
  rain_tot_tend(tend_int:ntimes-1:tend_int,:,:) = rain_tot(tend_int:ntimes-1:tend_int,:,:) - rain_tot(0:ntimes-2:tend_int,:,:)
  return(rain_tot_tend)
end

; function to generate the output image for the given timestep
undef("print_3hr_rain_for_timestamp")
procedure print_3hr_rain_for_timestamp(timestamp, data, mpres, slp, rainsum)
local wks_type, time_array, wks, res, opts_psl, opts_r, contour_psl, contour_tend, pltres
begin
	wks_type = "png"
  wks_type@wkWidth = 2500
  wks_type@wkHeight = 2500
  time_array = str_split(timestamp, ":")
  wks = gsn_open_wks(wks_type,"rain_3h_" + time_array(0))

  res = True
  res@TimeLabel = timestamp   ; Set Valid time to use on plots

	; Plotting options for Sea Level Pressure
  opts_psl = res
  opts_psl@ContourParameters = (/ 900., 1100., 4. /)
  opts_psl@cnLineColor       = "Gray25"
  opts_psl@cnInfoLabelOn     = True
  opts_psl@cnHighLabelsOn = True                           ; Set labels
  opts_psl@cnLowLabelsOn = True
  opts_psl@cnLineLabelFontHeightF = 0.01
  opts_psl@cnLineLabelPerimOn = False
  opts_psl@gsnContourLineThicknessesScale = 1.5
  contour_psl = wrf_contour(data, wks,slp,opts_psl)

	; Plotting options for Precipitation
  opts_r = res
  opts_r@UnitLabel            = "mm"
  opts_r@cnLevelSelectionMode = "ExplicitLevels"
  opts_r@cnLevels             = (/ .1, .2, .4, .8, 1.6, 3.2, 6.4, \
                                  12.8, 25.6, 51.2, 102.4, 204.8/)
  opts_r@cnFillColors         = (/"White","White","DarkOliveGreen1", \
                              "DarkOliveGreen3","Chartreuse", \
                                  "Chartreuse3","Green","ForestGreen", \
                                  "Yellow","Orange","Red","Violet","Blue"/)
  opts_r@cnInfoLabelOn        = False
  opts_r@cnConstFLabelOn      = False
  opts_r@cnFillOn             = True

	; MAKE PLOTS
	pltres = True
  pltres@PanelPlot = True
  pltres@FramePlot = False
  contour_tend = wrf_contour(data, wks, rainsum, opts_r)
  ; Total Precipitation Tendency + SLP
  plot = wrf_map_overlays(data, wks,(/contour_tend,contour_psl/),pltres,mpres)
  draw(plot)
  frame(wks)
end
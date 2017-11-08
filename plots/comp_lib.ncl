; library with function to generate a multi value composite
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

; function to retrieve the sea level pressure from the input data
undef("get_sea_level_pressure")
function get_sea_level_pressure(a)
local slp
begin
	slp = wrf_user_getvar(a,"slp",-1) 
  wrf_smooth_2d(slp, 3)                          ; Smooth sea level pressure
  return(slp)
end  

; function to retrieve the surface temperature from the input data
undef("get_surface_temperature")
function get_surface_temperature(a)
local t2, t2c
begin
  t2 = wrf_user_getvar(a,"T2",-1)                  ; Get T2 (deg K)
  tc2 = t2-273.16                                  ; Convert to deg C
  tc2@description = "Surface Temperature"
  tc2@units = "C"
  return(tc2)
end

; function to retrieve the latitude wind component from the input data
undef("get_latitude_wind")
function get_latitude_wind(a)
local u10
begin
  u10 = wrf_user_getvar(a,"U10",-1)           ; Get 10m u component
  u10 = u10*1.94386                           ; Convert to knots
  u10@units = "kts"
  return(u10)
end

; function to retrieve the longitude wind component from the input data
undef("get_longitude_wind")
function get_longitude_wind(a)
local v10
begin
	v10 = wrf_user_getvar(a,"V10",-1)           ; Get 10m v component
  v10 = v10*1.94386                           ; Convert to knots
  v10@units = "kts"
  return(v10)
end

; function to generate the output image for the given timestep
undef("print_comp_for_timestamp")
procedure print_comp_for_timestamp(timestamp, data, mpres, tc2, slp, u10, v10)
begin
  ; preparing graph resources
  res = True
  res@TimeLabel = timestamp ; set valid time to use on plot
  ; temperature
  opts_T = res                                  ; Add basic resources
  opts_T@cnFillOn = True                                ; Shaded plot
  opts_T@ContourParameters = (/ -30., 50., 1./)   ; Contour intervals
  opts_T@cnFillPalette = "BlAqGrYeOrReVi200"
  ; pressure
  opts_p = res                                  ; Add basic resources
  opts_p@cnLineColor = "gray25"                        ; Set line color
  opts_p@cnHighLabelsOn = True                           ; Set labels
  opts_p@cnLowLabelsOn = True
  opts_p@gsnContourLineThicknessesScale = 2.5
  opts_p@ContourParameters = (/ 900.,1100.,4./)   ; Contour intervals
  ; wind
  opts_uv = res                                  ; Add basic resources
  opts_uv@FieldTitle = "Winds"             ; Overwrite the field title
  opts_uv@NumVectors = 40                      ; Density of wind barbs

	wks_type = "png"
  wks_type@wkWidth = 2500
  wks_type@wkHeight = 2500
  time_array = str_split(timestamp, ":")
  wks_comp = gsn_open_wks(wks_type,"comp_" + time_array(0))
  
  ; Plotting options for T
  contour_tc = wrf_contour(data,wks_comp,tc2,opts_T) ; Create plot
  
  ; Plotting options for SLP
  contour_psl = wrf_contour(data,wks_comp,slp,opts_p) ; Create plot
  
  ; Plotting options for Wind Vectors
  vector = wrf_vector(data,wks_comp,u10,v10,opts_uv) ; Create plot
  
  ; plot comp output
  pltres= True
  pltres@PanelPlot = True
  pltres@FramePlot = False
  plot_comp = wrf_map_overlays(data,wks_comp,(/contour_tc,contour_psl,vector/),pltres,mpres)
  draw(plot_comp)
  frame(wks_comp)
end
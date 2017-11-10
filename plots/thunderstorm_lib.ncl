; library with function to generate thunderstorm output images
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

; function to retrieve the cape energy values from the input data
undef("get_cape_energy")
function get_cape_energy(a)
local cinfo, mcape
begin
	cinfo = wrf_user_getvar(a,"cape_2d",-1)
  mcape = cinfo(0,0,:,:)
  mcape@description = "CAPE"
  return(mcape)
end

undef("print_cape_energy_for_timestamp")
procedure print_cape_energy_for_timestamp(timestamp, data, mpres, mcape)
local wks_type, time_array, wks, res, pltres, plot
begin
	wks_type = "png"
  wks_type@wkWidth = 2500
  wks_type@wkHeight = 2500
  time_array = str_split(timestamp, ":")
  wks = gsn_open_wks(wks_type,"thunderstorm_" + time_array(0))

	res = True
  res@MainTitle = "WRF: Thunderstorm index CAPE"
  res@TimeLabel = timestamp
  res@cnFillOn              = True            ; turn on color
  res@cnLinesOn             = False           ; turn contour lines
  res@gsnSpreadColors       = True            ; use entire color map
  res@lbLabelAutoStride     = True            ; let NCL determine label spacing

  res@UnitLabel            = "Energy in J/kg"
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@cnLevels             = (/ 500, 1000, 1500, 2000, 2500, 3000, 3500, 4000, \
                                  4500/)
  res@cnFillColors         = (/"DarkOliveGreen1", "Green", "Yellow2", "Yellow",\
                               "Orange", "OrangeRed2", "Red", "Magenta", "Magenta3"/)
  res@cnInfoLabelOn        = False
  res@cnConstFLabelOn      = False
  res@cnFillOn             = True

  pltres = True
  pltres@PanelPlot = True
  pltres@FramePlot = False
  contour_tot = wrf_contour(data, wks, mcape, res)
  plot = wrf_map_overlays(data, wks, contour_tot, pltres, mpres)
  draw(plot)
  frame(wks)
end
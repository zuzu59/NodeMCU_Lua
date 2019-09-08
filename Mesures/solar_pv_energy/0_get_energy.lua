-- Lit le convertisseur ADC pour mesurer le courant électrique de l'installation PV
print("\n 0_get_energy.lua zf190909.0021 \n")

-- Astuce de mesure, on lit l'adc toutes les 21ms, soit 47.6x par seconde
-- comme l'alternance fait 20ms, on balaye (déphasage) statistiquement l'aleternance
-- ce qui nous permet d'estimer une valeur moyenne du courant
-- quelque soit sa forme !
-- toutes les 2 secondes on remet à zéro les minima et maxima

zadc_min=1024   zadc_max=0


if adc.force_init_mode(adc.INIT_ADC)
then
  node.restart()
  return -- don't bother continuing, the restart is scheduled
end

tmr_clr_rms=tmr.create()
tmr_clr_rms:alarm(2*1000,  tmr.ALARM_AUTO, function()
    clr_rms()
end)

tmr_mes_adc=tmr.create()
tmr_mes_adc:alarm(21,  tmr.ALARM_AUTO, function()
    get_adc()
end)

function get_adc()
    zadc=0   znb=3
    for i=1,znb do zadc=zadc+adc.read(0) end
    zadc=math.floor(zadc/znb)
    if zadc<=zadc_min then zadc_min=zadc end
    if zadc>=zadc_max then zadc_max=zadc end
end

zrms_offset=12
zpow_cal=411
zadc_cal=336

function clr_rms()
    zadc_rms0=zadc_max-zadc_min
    zadc_rms=zadc_rms0-zrms_offset
    if zadc_rms<=0 then zadc_rms=0 end
    zpower=math.floor(zadc_rms*zpow_cal/zadc_cal)
    print(zadc,zadc_min,zadc_max,zadc_rms0,zadc_rms,zpower.."W")
    zadc_min=1024   zadc_max=0
end




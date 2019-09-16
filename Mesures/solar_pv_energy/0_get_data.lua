-- Lit le convertisseur ADC connecté sur le transformateur de courant
-- pour mesurer le courant électrique de l'installation PV
print("\n 0_get_data.lua zf190916.1925 \n")

-- Astuce de mesure:
-- au lieu de découper la sinusoïde en 100 parties, c'est à dire toutes 
-- les 0.2ms (5'000x /s), pour en faire l'intégrale. On lit l'adc toutes 
-- les 11ms (91x /s) beaucoup plus lentement.
-- Comme la sinusoïde fait 20ms et est répétitive, on balaye (par décalage)
-- statistiquement la sinusoïde.
-- On redresse l'alternance par rapport à la masse fictive (env 0.5),
-- ce qui nous permet d'estimer une valeur RMS du courant
-- quelque soit sa forme !
-- On le somme sur 2.1 secondes avec une moyenne glissante sur 3 valeurs

zadc_offset=548
zpow_cal=401
zadc_cal=189
zadc_err=-5

zadc_sum=0   zadc_offset_sum=0   znb_mes=0
zadc_rms1=0   zadc_rms2=0   zadc_rms3=0

if adc.force_init_mode(adc.INIT_ADC)
then
    node.restart()
    return
end

tmr_read_adc=tmr.create()
tmr_read_adc:alarm(11, tmr.ALARM_AUTO, function()
    read_adc()
end)

tmr_calc_rms=tmr.create()
tmr_calc_rms:alarm(2.1*1000, tmr.ALARM_AUTO, function()
    calc_rms()
end)

function read_adc()
    zadc=adc.read(0)
    zadc_offset_sum=zadc_offset_sum+zadc
    zadc=zadc-zadc_offset   if zadc<=0 then zadc=zadc*-1 end
    zadc_sum=zadc_sum+zadc   znb_mes=znb_mes+1
end

function calc_rms()
    zadc_rms=math.floor(zadc_sum/znb_mes)+zadc_err
    if zadc_rms<=0 then zadc_rms=0 end
--    zadc_rms1=zadc_rms2   zadc_rms2=zadc_rms3   zadc_rms3=zadc_rms
--    zadc_rms=math.floor((zadc_rms1+zadc_rms2+zadc_rms3)/3)
    zadc_offset=math.floor(zadc_offset_sum/znb_mes)
    zpower=math.floor(zadc_rms*zpow_cal/zadc_cal)
    print(zadc_offset,zadc_rms,zpower.."W")
    zadc_min=zadc_offset   zadc_max=zadc_offset
    zadc_sum=0   zadc_offset_sum=0   znb_mes=0
end

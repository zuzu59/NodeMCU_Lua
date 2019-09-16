-- Lit le convertisseur ADC connecté sur le transformateur de courant
-- pour mesurer le courant électrique de l'installation PV
print("\n 0_get_data.lua zf190916.1534 \n")

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

zadc_min=1024   zadc_max=0   zadc_sum=0   znb_mes=0

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


zadc1=0   zadc2=0   zadc3=0

function read_adc()
    zadc=adc.read(0)

    zadc1=zadc2   zadc2=zadc3   zadc3=zadc
    zadc=math.floor((zadc1+zadc2+zadc3)/3)

    
    
    if zadc<=zadc_min then zadc_min=zadc end
    if zadc>=zadc_max then zadc_max=zadc end
    zadc=zadc-zadc_offset
    if zadc<=0 then zadc=zadc*-1 end
    zadc_sum=zadc_sum+zadc   znb_mes=znb_mes+1
end

zadc_offset=548
zpow_cal=409
zadc_cal=192
zadc_err=-4

zadc_rms1=0   zadc_rms2=0   zadc_rms3=0

function calc_rms()
    zadc_rms=math.floor(zadc_sum/znb_mes)+zadc_err

--    zadc_rms1=zadc_rms2   zadc_rms2=zadc_rms3   zadc_rms3=zadc_rms
--    zadc_rms=math.floor((zadc_rms1+zadc_rms2+zadc_rms3)/3)
    
--    if zadc_rms<=0 then zadc_rms=0 end
    zadc_offset=math.floor((zadc_min+zadc_max)/2)
    zpower=math.floor(zadc_rms*zpow_cal/zadc_cal)    
    print(zadc_min,zadc_max,zadc_offset,zadc_rms,zpower.."W")
    zadc_min=1024   zadc_max=0   zadc_sum=0   znb_mes=0
end

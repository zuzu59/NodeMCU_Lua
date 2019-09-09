-- Lit le convertisseur ADC pour mesurer le courant électrique de l'installation PV
print("\n 0_get_energy.lua zf190910.0108 \n")

-- Astuce de mesure:
-- on lit l'adc toutes les 11ms, soit 91x par seconde
-- comme l'alternance fait 20ms, on balaye (déphasage) statistiquement l'alternance
-- on redresse l'alternance par rapport à la masse fictive (env 0.5)
-- ce qui nous permet d'estimer une valeur RMS du courant
-- quelque soit sa forme !
-- on le fait sur 2.1 secondes avec une moyenne glissante sur 3 valeurs

zadc_min=1024   zadc_max=0   zadc_sum=0   znb_adc=0

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
    if zadc<=zadc_min then zadc_min=zadc end
    if zadc>=zadc_max then zadc_max=zadc end
    zadc=zadc-zadc_offset
    if zadc<=0 then zadc=zadc*-1 end
    zadc_sum=zadc_sum+zadc   znb_adc=znb_adc+1
end

zadc_offset=548
zpow_cal=409
zadc_cal=192
zadc_err=-4

za1=0   za2=0   za3=0

function calc_rms()
    zadc_rms=math.floor(zadc_sum/znb_adc)+zadc_err

    za1=za2   za2=za3   za3=zadc_rms  zadc_rms=math.floor((za1+za2+za3)/3)
    
    if zadc_rms<=0 then zadc_rms=0 end
    zadc_offset=math.floor((zadc_min+zadc_max)/2)
    zpower=math.floor(zadc_rms*zpow_cal/zadc_cal)    
    print(zadc_min,zadc_max,zadc_offset,zadc_rms,zpower.."W")
    zadc_min=1024   zadc_max=0   zadc_sum=0   znb_adc=0
end

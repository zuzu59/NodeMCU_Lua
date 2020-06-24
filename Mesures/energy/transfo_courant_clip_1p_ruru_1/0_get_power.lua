-- Lit le convertisseur ADC connecté sur le transformateur de courant
-- pour mesurer le courant électrique de l'installation PV
print("\n 0_get_power.lua zf200621.1143 \n")

-- Astuce de mesure:
-- On converti le courant en tension avec la résistance de charge du
-- transformateur de courant 1/800 et le mesure avec l'ADC
-- Au lieu de découper la sinusoïde en 100 parties, c'est à dire toutes
-- les 0.2ms (5'000x /s), pour en faire l'intégrale. On lit l'adc toutes
-- les 11ms (91x /s) donc beaucoup plus lentement.
-- Comme la sinusoïde fait 20ms et est répétitive, on balaye (par décalage)
-- statistiquement la sinusoïde.
-- On redresse l'alternance par rapport à la masse fictive (env 0.5),
-- ce qui nous permet d'estimer une valeur RMS du courant
-- quelque soit sa forme et on le somme sur 2.1 secondes
-- Les mesures min et max ne sont là juste pour vérifier que nous sommes
-- bien dans la plage de mesure avec le choix de la résistance de conversion
-- la conversion courant/tension/puissance est faite avec une simple régle de 3

zpow_cal=692    --puissance mesurée de la charge étalon
zadc_cal=59     --valeur de l'adc pour zpow_cal
zadc_offset=172

zadc_sum=0   zadc_offset_sum=0   znb_mes=0
zadc_min=zadc_offset   zadc_max=zadc_offset

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
    zadc_offset_sum=zadc_offset_sum+zadc
    zadc=zadc-zadc_offset   if zadc<=0 then zadc=zadc*-1 end
    zadc_sum=zadc_sum+zadc   znb_mes=znb_mes+1
end

function calc_rms()
    zadc_rms=math.floor(zadc_sum/znb_mes)
    -- if verbose then print(zadc_sum,znb_mes,zadc_rms) end
    if zadc_rms<=4 then zadc_rms=0 end
    zadc_offset=math.floor(zadc_offset_sum/znb_mes)
    zpower=math.floor(zadc_rms*zpow_cal/zadc_cal)
    -- if verbose then print(node.heap()) end
    -- if verbose then print(zadc_min,zadc_max,zadc_max-zadc_min,zadc_offset,zadc_rms,zpower.."W") end
    zadc_min=zadc_offset   zadc_max=zadc_offset
    zadc_sum=0   zadc_offset_sum=0   znb_mes=0
    zadc_min=zadc_offset   zadc_max=zadc_offset
end

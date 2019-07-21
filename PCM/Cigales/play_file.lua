-- Scripts pour jouer un fichier son sur un HP

print("\n play_file.lua zf190721.1238 \n")


-- ****************************************************************************
-- Play file with pcm module.
--
-- Upload jump_8k.u8 to spiffs before running this script.
--
-- ****************************************************************************


function cb_drained(d)
  print("drained "..node.heap())

  file.seek("set", 0)
  -- uncomment the following line for continuous playback
  --d:play(pcm.RATE_8K)
end

function cb_stopped(d)
  print("playback stopped")
  file.seek("set", 0)
end

function cb_paused(d)
  print("playback paused")
end

file.open("cigale_10s_16k.wav", "r")

drv = pcm.new(pcm.SD, 5)

-- fetch data in chunks of FILE_READ_CHUNK (1024) from file
drv:on("data", function(drv) return file.read() end)

-- get called back when all samples were read from the file
drv:on("drained", cb_drained)

drv:on("stopped", cb_stopped)
drv:on("paused", cb_paused)

-- start playback
drv:play(pcm.RATE_16K)

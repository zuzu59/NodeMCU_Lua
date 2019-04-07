count=100

-- when 4 chars is received.
uart.on("data", 4,
  function(data)
    count = count - 1 
    print("receive from uart:", data)
    if data=="quit" or count<1 then
      uart.on("data") -- unregister callback function
    end
end, 0)
-- when '\r' is received.
uart.on("data", "\r",
  function(data)
    count = count - 1 
    print("receive from uart:", data)
    if data=="quit\r" or count<1 then
      uart.on("data") -- unregister callback function
    end
end, 0)


local ODAServer = class:new{}

function ODAServer:instance (obj)

  local oda   = require 'oda'
  local tick  = 0
  local soundtrack

  oda.start { "./patches" }

  soundtrack = oda.eventInstance 'danmaku'
  soundtrack:pushCommand 'start'

  function obj:refresh (dt)
    tick = math.fmod(tick + 10*dt, 256)
    oda.tick(dt)
  end

  function obj:pulse (n)
    return 4/(n*n) * (math.fmod(tick, n) - n/2)^2
  end

  function obj:pushCommand (id, ...)
    soundtrack:pushCommand(id, ...)
  end

  function obj:shutdown ()
    soundtrack:pushCommand 'stop'
    soundtrack = nil
    oda.finish()  
  end

end

return ODAServer


local ODAServer = class:new{}

function ODAServer:instance (obj)

  local oda = require 'oda'
  local soundtrack

  oda.start { "./patches" }

  soundtrack = oda.eventInstance 'danmaku'
  soundtrack:pushCommand 'start'

  function obj:refresh (dt)
    oda.tick(dt)
  end

  function obj:shutdown ()
    soundtrack:pushCommand 'stop'
    soundtrack = nil
    oda.finish()  
  end

end

return ODAServer

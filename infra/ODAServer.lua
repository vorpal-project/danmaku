
local ODAServer = class:new{}

function ODAServer:instance (obj)

  local oda = require 'oda'

  function obj:refresh (dt)

  end

  function obj:shutdown ()
    
  end

end

return ODAServer


local Body = class:new{}

function Body:instance (obj)
  
  local pos = vec2:new{}

  function obj:getPosition ()
    return pos:unpack()
  end

  function obj:move (diff)
    pos:add(diff)
  end

end

return require 'Domain' (Body)

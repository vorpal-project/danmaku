
local Body = class:new{}

function Body:instance (obj, kind)
  
  local pos = vec2:new{}

  function obj:getPosition ()
    return pos:unpack()
  end

  function obj:getKind ()
    return kind
  end

  function obj:move (diff)
    pos:add(diff)
  end

end

return require 'Domain' (Body)

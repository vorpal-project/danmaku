
local Body = class:new{}

function Body:instance (obj, kind)
  
  local position = vec2:new{}

  function obj:getPosition ()
    return position:clone()
  end

  function obj:getKind ()
    return kind
  end

  function obj:setPosition (pos)
    position = pos:clone()
  end

  function obj:move (diff)
    position:add(diff)
  end

end

return require 'Domain' (Body)

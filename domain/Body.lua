
local Body = class:new{}

function Body:instance (obj)
  
  local x, y = 0, 0

  function obj:getPosition ()
    return x, y
  end

end

return require 'Domain' (Body)


local Body = class:new{}

local groups = {}

function Body:instance (obj, kind)
  
  local position = vec2:new{}

  if not groups[kind] then
    groups[kind] = {}
  end

  groups[kind][obj] = true

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

function Body:forKind (kind)
  if groups[kind] then
    return pairs(groups[kind])
  else
    return pairs {}
  end
end

function Body:onDestroy (body)
  groups[body:getKind()][body] = nil
end

return require 'Domain' (Body)

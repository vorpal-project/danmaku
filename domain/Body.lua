
local Body = class:new{}

local groups = {}

local function checkCollision (body1, body2)
  local pos1, pos2    = body1:getPosition(), body2:getPosition()
  local size1, size2  = body1:getSize(), body2:getSize()
  local left1, right1 = pos1.x - size1.x/2, pos1.x + size1.x/2
  local bottom1, top1 = pos1.y - size1.y/2, pos1.y + size1.y/2
  local left2, right2 = pos2.x - size2.x/2, pos2.x + size2.x/2
  local bottom2, top2 = pos2.y - size2.y/2, pos2.y + size2.y/2
  if left1 > right2 then return false end
  if right1 < left2 then return false end
  if bottom1 > top2 then return false end
  if top1 < bottom2 then return false end
  return true
end

function Body:instance (obj, kind)
  
  local position = vec2:new{}
  local size     = vec2:new{1, 1}

  if not groups[kind] then
    groups[kind] = {}
  end

  groups[kind][obj] = true

  function obj:getKind ()
    return kind
  end

  function obj:getPosition ()
    return position:clone()
  end

  function obj:setPosition (pos)
    position = pos:clone()
  end

  function obj:getSize ()
    return size:clone()
  end

  function obj:setSize (pos)
    size = pos:clone()
  end

  function obj:move (diff)
    position:add(diff)
  end

  function obj:collisionsWith (other_kind)
    local collisions = {}
    if groups[other_kind] then
      for body in pairs(groups[other_kind]) do
        if body ~= self and checkCollision(self, body) then
          table.insert(collisions, body)
        end
      end
    end
    return ipairs(collisions)
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


local Bullet        = class:new{}
local Body          = require 'domain.Body'

function Bullet:instance (obj, hp, power, behaviour_name, ...)
  
  local behaviour = loadResource('behaviour', behaviour_name) (obj, ...)
  local done      = false
  local damage    = 0

  function obj:body ()
    return Body:get(Bullet:getId(self))
  end

  function obj:getPower ()
    return power
  end

  function obj:done ()
    done = true
  end

  function obj:isDone ()
    return done or damage >= hp
  end

  function obj:update ()
    local pos = self:body():getPosition()
    if math.abs(pos.x) > 30 or math.abs(pos.y) > 30 then
      self:done()
    end
    behaviour()
  end

  function obj:takeHitFrom (other)
    damage = damage + other:getPower()
  end

end

function Bullet:build (pos, body_kind, hp, power, behaviour_name, ...)
  local bullet, id = Bullet:create(true, hp, power, behaviour_name, ...)
  local body = Body:create(id, body_kind)
  body:setPosition(pos)
  return bullet
end

Bullet = require 'Domain' (Bullet)

return Bullet

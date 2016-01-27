
local Bullet        = class:new{}
local Body          = require 'domain.Body'

function Bullet:instance (obj, behaviour_name, ...)
  
  local behaviour = loadResource('behaviour', behaviour_name) (obj, ...)
  local done      = false

  function obj:body ()
    return Body:get(Bullet:getId(self))
  end

  function obj:done ()
    done = true
  end

  function obj:isDone ()
    return done
  end

  function obj:update ()
    local pos = self:body():getPosition()
    if math.abs(pos.x) > 30 or math.abs(pos.y) > 30 then
      self:done()
    end
    behaviour()
  end

end

function Bullet:build (pos, body_kind, behaviour_name, ...)
  local bullet, id = Bullet:create(true, behaviour_name, ...)
  local body = Body:create(id, body_kind)
  body:setPosition(pos)
  return bullet
end

Bullet = require 'Domain' (Bullet)

return Bullet

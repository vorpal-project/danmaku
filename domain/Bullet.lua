
local Bullet        = class:new{}
local BulletDomain  = require 'Domain' (Bullet)
local Body          = require 'domain.Body'

function Bullet:instance (obj, behaviour_name)
  
  local behaviour = loadResource('behaviour', behaviour_name) (obj)
  local done      = false

  function obj:body ()
    return Body:get(BulletDomain:getId(self))
  end

  function obj:done ()
    done = true
  end

  function obj:isDone ()
    return done
  end

  function obj:update ()
    behaviour()
  end

end

function Bullet:build (pos, body_kind, behaviour_name)
  local bullet, id = BulletDomain:create(true, behaviour_name)
  local body = Body:create(id, body_kind)
  body:setPosition(pos)
  return bullet
end

return BulletDomain

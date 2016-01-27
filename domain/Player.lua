
local Player        = class:new{}
local Body          = require 'domain.Body'
local PlayerDomain  = require 'Domain' (Player)

local singleton

function Player:singleton ()
  return singleton
end

function Player:instance (obj)

  assert(not singleton, "Can only have one player!")
  local spd = .1
  local shoot_delay = 0
  local shooting = false


  function obj:move (dir)
    local body = Body:get(PlayerDomain:getId(self))
    local abs = dir:map(math.abs)
    if abs.x > 0 then
      dir.x = dir.x/abs.x
    end
    if abs.y > 0 then
      dir.y = dir.y/abs.y
    end
    body:move(spd * dir)
  end

end

singleton = PlayerDomain:create(true)

return PlayerDomain

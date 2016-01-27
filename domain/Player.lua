
local Player = class:new{}

local singleton

function Player:instance (obj)

  assert(not singleton, "Can only have one player!")
  local spd = .1
  local shoot_delay = 0
  local shooting = false
  local moving = {
    up = false, down = false, left = false, right = false
  }

end

local PlayerDomain = require 'Domain' (Player)

singleton = PlayerDomain:create(true)

function Player:singleton ()
  return singleton
end

return PlayerDomain

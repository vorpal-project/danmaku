
local Player        = class:new{}
local Body          = require 'domain.Body'
local Bullet        = require 'domain.Bullet'

local singleton

function Player:singleton ()
  return singleton
end

function Player:instance (obj)

  assert(not singleton, "Can only have one player!")
  local spd = .1
  local shoot_delay = 0

  function obj:move (dir)
    local body = Body:get(Player:getId(self))
    local abs = dir:map(math.abs)
    if abs.x > 0 then
      dir.x = dir.x/abs.x
    end
    if abs.y > 0 then
      dir.y = dir.y/abs.y
    end
    body:move(spd * dir)
  end

  function obj:shoot ()
    if shoot_delay <= 0 then
      local pos = Body:get(Player:getId(self)):getPosition()
      Bullet:build(pos + vec2:new{-.3,1}, 'weak_shot', 1, 1, 'straight')
      Bullet:build(pos + vec2:new{.3,1}, 'weak_shot', 1, 1, 'straight')
      shoot_delay = 5
    else
      shoot_delay = shoot_delay - 1
    end
  end

end

Player    = require 'Domain' (Player)
singleton = Player:create(true)

return Player

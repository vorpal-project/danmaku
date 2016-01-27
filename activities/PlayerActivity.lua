
local PlayerActivity  = class:new{}
local Player          = require 'domain.Player'
local Body            = require 'domain.Body'

PlayerActivity:inherit(require 'Activity')

local function identity (...)
  return ...
end

local move_keys = {
  up = true, down = true, left = true, right = true
}

function PlayerActivity:instance (obj)
  
  self:super(obj)

  local player
  local moving = {
    up = false, down = false, left = false, right = false
  }
  local shooting = false

  local function getDir ()
    dir = vec2:new{}
    if moving.right and not moving.left then
      dir.x = 1
    elseif moving.left and not moving.right then
      dir.x = -1
    end
    if moving.up and not moving.down then
      dir.y = 1
    elseif moving.down and not moving.up then
      dir.y = -1
    end
    return dir
  end

  function obj.__accept:Load (engine)
    player = Player:singleton()
    Body:create(Player:getId(player), 'player')
    engine:setEventHook('keypressed', 'KeyPressed', identity)
    engine:setEventHook('keyreleased', 'KeyReleased', identity)
    self:addTask 'UpdatePlayer'
  end

  function obj.__accept:KeyPressed (key)
    if move_keys[key] then
      moving[key] = true
    elseif key == 'z' then
      shooting = true
    end
  end

  function obj.__accept:KeyReleased (key)
    if move_keys[key] then
      moving[key] = false
    elseif key == 'z' then
      shooting = false
    end
  end

  function obj.__task:UpdatePlayer ()
    while true do
      player:move(getDir())
      if shooting then
        player:shoot()
      end
      self:yield()
    end
  end

end

return PlayerActivity

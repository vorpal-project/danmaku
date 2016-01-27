
local PlayerActivity  = class:new{}
local Player          = require 'domain.Player'
local Body            = require 'domain.Body'

PlayerActivity:inherit(require 'Activity')

function PlayerActivity:instance (obj)
  
  self:super(obj)

  function obj.__accept:Load (engine)
    local player = Player:singleton()
    Body:create(Player:getId(player))
  end

end

return PlayerActivity

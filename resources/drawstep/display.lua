
local Body = require 'domain.Body'

local function triple (x)
  return x, x ,x
end

local kind = {}

function kind.player (graphics, engine, id)
  local grow = 1 + (engine:server'ODA':pulse(4) > 0.8 and 0.2 or 0)
  graphics.scale(grow, grow)
  graphics.setColor(triple(grow*128))
  graphics.polygon('fill', 0, .8, -.3, -.2, 0, 0)
  graphics.setColor(triple(grow*192))
  graphics.polygon('fill', 0, .8, 0, 0, .3, -.2)
  graphics.setColor(triple(grow*64))
  graphics.polygon('fill', 0, 0, .3, -.2, -.3, -.2)
end

local display = {}

function display.update (dt)
  -- nothing for now
end

function display.draw (graphics, engine)
  local W,H = graphics.getDimensions()
  graphics.push()
  graphics.translate(W/2, 7*H/8)
  graphics.scale(32, -32)
  for id,body in Body:all() do
    graphics.push()
    graphics.translate(body:getPosition())
    kind[body:getKind()] (graphics, engine, id)
    graphics.setColor(triple(255))
    graphics.pop()
  end
  graphics.pop()
end

return display

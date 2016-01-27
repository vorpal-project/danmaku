
local Body = require 'domain.Body'

local display = {}

local function triple (x)
  return x, x ,x
end

function display.update (dt)
  -- nothing for now
end

function display.draw (graphics)
  local W,H = graphics.getDimensions()
  graphics.push()
  graphics.translate(W/2, 7*H/8)
  graphics.scale(32, -32)
  for id,body in Body:all() do
    graphics.push()
    graphics.translate(body:getPosition())
    graphics.setColor(triple(128))
    graphics.polygon('fill', 0, .8, -.3, -.2, 0, 0)
    graphics.setColor(triple(192))
    graphics.polygon('fill', 0, .8, 0, 0, .3, -.2)
    graphics.setColor(triple(64))
    graphics.polygon('fill', 0, 0, .3, -.2, -.3, -.2)
    graphics.setColor(triple(255))
    graphics.pop()
  end
  graphics.pop()
end

return display

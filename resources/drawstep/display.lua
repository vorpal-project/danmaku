
local Body = require 'domain.Body'

local function triple (x)
  return x, x ,x
end

local drawkind = {}

function drawkind.player (graphics, engine, id)
  local grow = 1 + (engine:server'ODA':pulse(4) > 0.8 and 0.2 or 0)
  graphics.scale(grow, grow)
  graphics.setColor(triple(grow*128))
  graphics.polygon('fill', 0, .8, -.3, -.2, 0, 0)
  graphics.setColor(triple(grow*192))
  graphics.polygon('fill', 0, .8, 0, 0, .3, -.2)
  graphics.setColor(triple(grow*64))
  graphics.polygon('fill', 0, 0, .3, -.2, -.3, -.2)
end

function drawkind.weak_shot (graphics, engine, id)
  graphics.circle('fill', 0, 0, .1, 8)
end

function drawkind.evil_square (graphics, engine, id)
  graphics.setColor(200, 100, 100)
  graphics.polygon('fill', 0, 0, .5, .5, -.5, .5)
  graphics.setColor(250, 150, 150)
  graphics.polygon('fill', 0, 0, .5, -.5, .5, .5)
  graphics.setColor(120, 60, 60)
  graphics.polygon('fill', 0, 0, -.5, -.5, .5, -.5)
  graphics.setColor(150, 80, 80)
  graphics.polygon('fill', 0, 0, -.5, .5, -.5, -.5)
end

local display = {}

local draw_order = {
  'player', 'evil_square', 'weak_shot'
}

function display.update (dt)
  -- nothing for now
end

function display.draw (graphics, engine)
  local W,H = graphics.getDimensions()
  graphics.push()
  graphics.translate(W/2, 7*H/8)
  graphics.scale(32, -32)
  for _,kind in ipairs(draw_order) do
    for body in Body:forKind(kind) do
      local id = Body:getId(body)
      graphics.push()
      graphics.translate(body:getPosition():unpack())
      drawkind[body:getKind()] (graphics, engine, id)
      graphics.setColor(triple(255))
      graphics.pop()
    end
  end
  graphics.pop()
end

return display

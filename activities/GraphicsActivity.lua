
local GraphicsActivity = class:new{}

GraphicsActivity:inherit(require 'Activity')

function GraphicsActivity:instance (obj, ...)
  
  self:super(obj)

  function obj.__accept:Load (engine)
    local gfxserver = engine:server 'Graphics'
    gfxserver:resetSteps(1)
    gfxserver:setStep(1, 'display', true)
  end

end

return GraphicsActivity

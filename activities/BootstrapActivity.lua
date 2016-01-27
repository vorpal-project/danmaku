
local BootstrapActivity = class:new{}

BootstrapActivity:inherit(require 'Activity')

function BootstrapActivity:instance (obj, ...)
  
  self:super(obj)

  function obj.__accept:Load (engine)
    engine:loadServer 'ODA'
    self:switch(
      require 'activities.PlayerActivity' (),
      require 'activities.BulletActivity' (),
      require 'activities.GraphicsActivity' ()
    )
  end

end

return BootstrapActivity

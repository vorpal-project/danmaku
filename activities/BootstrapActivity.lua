
local BootstrapActivity = require 'lux.class' :new{}

BootstrapActivity:inherit(require 'Activity')

function BootstrapActivity:instance (obj, ...)
  
  self:super(obj)

  function obj.__accept:Load (engine)
    engine:loadServer 'ODA'
  end

end

return BootstrapActivity


local SoundtrackActivity  = class:new{}
local Body                = require 'domain.Body'

SoundtrackActivity:inherit(require 'Activity')

function SoundtrackActivity:instance (obj, ...)

  self:super(obj)

  local odaserver

  function obj.__accept:Load (engine)
    odaserver = engine:loadServer 'ODA'
    self:addTask 'SendCommands'
  end

  function obj.__accept:BulletHit ()
    odaserver:pushCommand('hit')
  end

  function obj.__task:SendCommands ()
    while true do
      odaserver:pushCommand('evilsquares', Body:getKindCount 'evil_square')
      self:yield()
    end
  end

end

return SoundtrackActivity

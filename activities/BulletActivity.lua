
local BulletActivity  = class:new{}
local Bullet          = require 'domain.Bullet'

BulletActivity:inherit(require 'Activity')

function BulletActivity:instance (obj)
  
  self:super(obj)

  function obj.__accept:Load (engine)
    self:addTask 'UpdateBullets'
  end

  function obj.__task:UpdateBullets ()
    while true do
      local done = {}
      for id,bullet in Bullet:all() do
        bullet:update()
        if bullet:isDone() then
          table.insert(done, id)
        end
      end
      for _,id in ipairs(done) do
        Body:destroy(id)
        Bullet:destroy(id)
      end
      self:yield()
    end
  end

end

return BulletActivity

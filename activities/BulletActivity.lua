
local BulletActivity  = class:new{}
local Body            = require 'domain.Body'
local Bullet          = require 'domain.Bullet'

BulletActivity:inherit(require 'Activity')

function BulletActivity:instance (obj)
  
  self:super(obj)

  function obj.__accept:Load (engine)
    self:addTask 'SpawnBullets'
    self:addTask 'UpdateBullets'
  end

  function obj.__task:SpawnBullets ()
    local rand = love.math.random
    while true do
      for delay = 1,rand(200,400) do
        self:yield()
      end
      for i=1,rand(1,3) do
        Bullet:build(vec2:new{rand(-12,12), 30}, 'evil_square', 'slide_to',
                     vec2:new{rand(-8,8), rand(6,12)})
      end
      self:yield()
    end
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

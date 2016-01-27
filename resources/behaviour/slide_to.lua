
return function (bullet, target)
  return function ()
    local body = bullet:body()
    body:move((target - body:getPosition())/100)
  end
end


return function (bullet)
  return function ()
    bullet:body():move(vec2:new{0, .5})
  end
end

local physics = require "physics"
physics.start()
physics.setGravity( 0, 1 )
local background = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
background:setFillColor( 1, 1, 1 )

local player = display.newCircle( display.contentCenterX, 10, 15 )
player:setFillColor( 0, 0, 0 )

local floor = display.newRect( display.contentCenterX, display.actualContentHeight-50, display.actualContentWidth, 10 )
floor:setFillColor( 0, 1, 0 )

local leftControl = display.newRect( 20, display.actualContentHeight-100, 20, 50 )
leftControl:setFillColor( 0, 0, 0 )
leftControl.name = "left"

local rightControl = display.newRect( display.actualContentWidth-20, display.actualContentHeight-100, 20, 50 )
rightControl:setFillColor( 0, 0, 0 )
rightControl.name = "right"

local function onTap( event)

  if (event.target.name == "left") then
  print( event.target.name )
  transition.to( player, {x = ( player.x - 100 ) })
  else
    transition.to( player, {x = ( player.x + 100 ) })
  end

end



rightControl:addEventListener("tap", onTap)
leftControl:addEventListener("tap", onTap)

physics.addBody( player )
physics.addBody( floor, "static" )

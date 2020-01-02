local physics = require "physics"
physics.start()
local background = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
background:setFillColor( 1, 1, 1 )

local player = display.newCircle( display.contentCenterX, 10, 15 )
player:setFillColor( 0, 0, 0 )

physics.addBody( player )

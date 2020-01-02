local physics = require "physics"
local step = display.actualContentWidth/3
local actions = 3

physics.start()
physics.setGravity( 0, 0.5 )



local background = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
background:setFillColor( 1, 1, 1 )

textActions = display.newText( "Movimentos : " .. actions, 50, 0, native.systemFont, 12 )
textActions:setFillColor( 0, 0, 0 )

local player = display.newCircle( display.contentCenterX, 10, 15 )
player:setFillColor( 0, 0, 0 )
player.name = "player"

local floor = display.newRect( display.contentCenterX, display.actualContentHeight-50, display.actualContentWidth, 10 )
floor:setFillColor( 0, 1, 0 )

local lane1 = display.newRect( step, display.contentCenterY, 5, display.actualContentHeight )
lane1:setFillColor( 1, 0, 0 )

local lane2 = display.newRect( step*2, display.contentCenterY, 5, display.actualContentHeight )
lane2:setFillColor( 1, 0, 0 )

local leftControl = display.newRect( 20, display.actualContentHeight-100, 20, 50 )
leftControl:setFillColor( 0, 0, 0 )
leftControl.name = "left"

local rightControl = display.newRect( display.actualContentWidth-20, display.actualContentHeight-100, 20, 50 )
rightControl:setFillColor( 0, 0, 0 )
rightControl.name = "right"

local function onTap( event)

  if actions > 0 then
    if (event.target.name == "left") and ( player.x > step ) then
      transition.to( player, {x = ( player.x - step ) })
    elseif (event.target.name == "right" and player.x < (step * 2)) then
        transition.to( player, {x = ( player.x + step ) })
    end

    actions = (actions - 1)
    textActions.text = "Movimentos: " .. actions

  end


end

function createObstacle()

  obstacle1 = display.newRect( 50, step, step-20, 5 )
  obstacle1.name = "obstacle1"
  obstacle1:setFillColor( 0, 0, 1 )

  obstacle2 = display.newRect( step + 50, step*2, step-20, 5 )
  obstacle2:setFillColor( 0, 0, 1 )
  obstacle2.name = "obstacle2"

end

local function onLocalCollision( self, event )

    if ( event.phase == "began" ) then
      if event.other.name == "player" then
        textEnd = display.newText( "Você perdeu!", display.contentCenterX, display.contentCenterY, native.systemFont, 32 )
        textEnd:setFillColor( 0, 0, 0 )
      end
    end
end

createObstacle()

rightControl:addEventListener("tap", onTap)
leftControl:addEventListener("tap", onTap)

physics.addBody( player, "dynamic" )
physics.addBody( floor, "static" )
physics.addBody( obstacle1, "static" )
physics.addBody( obstacle2, "static" )
obstacle2.collision = onLocalCollision
obstacle2:addEventListener( "collision" )

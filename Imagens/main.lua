local physics = require "physics"
local step = display.actualContentWidth/3
local actions = 3

physics.start()
physics.setGravity( 0, 0.5 )



local background = display.newImageRect( "bg.png", display.actualContentWidth, display.actualContentHeight )
background.x = display.contentCenterX
background.y = display.contentCenterY

textActions = display.newText( "Movimentos : " .. actions, 50, 0, native.systemFont, 12 )
textActions:setFillColor( 0, 0, 0 )

local player = display.newImage( "player.png" )
player.x = display.contentCenterX
player.y = 10
player.width = 40
player.height = 40
player.name = "player"

local floor = display.newImageRect( "floor.png", display.actualContentWidth+80, 80 )
floor.x = display.contentCenterX
floor.y = display.actualContentHeight-30


local leftControl = display.newImageRect( "leftButton.png" , 50, 50 )
leftControl.x = 30
leftControl.y = display.actualContentHeight-100
leftControl.name = "left"

local rightControl = display.newImageRect( "rightButton.png", 50, 50 )
rightControl.x = display.actualContentWidth-30
rightControl.y = display.actualContentHeight-100
rightControl.name = "right"

local function updateText()
  textActions.text = "Movimentos: " .. actions
end

local function onTap( event)

  if actions > 0 then
    if (event.target.name == "left") and ( player.x > step ) then
      transition.to( player, {x = ( player.x - step ) })
    elseif (event.target.name == "right" and player.x < (step * 2)) then
        transition.to( player, {x = ( player.x + step ) })
    end
    actions = (actions - 1)
    updateText()

  end
end

function createObstacle()

  obstacle1 = display.newImage( "ob1.png" )
  obstacle1.x = 50
  obstacle1.y = step
  obstacle1.width = step-20
  obstacle1.height = 20
  obstacle1.name = "obstacle1"

  obstacle2 = display.newImageRect( "ob1.png", step-20, 20 )
  obstacle2.x = step+50
  obstacle2.y = step*2
  obstacle2.name = "obstacle2"

end

local function onLocalCollision( self, event )

    if ( event.phase == "began" ) then
      if event.other.name == "player" then
        textEnd = display.newText( "Você perdeu!", display.contentCenterX, display.contentCenterY, native.systemFont, 32 )
        textEnd:setFillColor( 0, 0, 0 )
        actions = 0
        updateText()
      end
    end
end

createObstacle()

rightControl:addEventListener("tap", onTap)
leftControl:addEventListener("tap", onTap)

physics.addBody( player, "dynamic", { density=1.0, friction=0.3, bounce=0.2 } )
physics.addBody( floor, "static" )
physics.addBody( obstacle1, "static" )
physics.addBody( obstacle2, "static" )
obstacle2.collision = onLocalCollision
obstacle2:addEventListener( "collision" )

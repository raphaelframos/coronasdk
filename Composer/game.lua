local composer = require( "composer" )

local scene = composer.newScene()

local physics = require "physics"
local step = display.actualContentWidth/3
local actions = 3
display.setStatusBar( display.HiddenStatusBar )
physics.start()
physics.setGravity( 0, 0.1 )

local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

local function gotoGame()
    composer.gotoScene( "game" )
end

function scene:create( event )
	local sceneGroup = self.view

  local background = display.newImageRect( backGroup, "Img/bg.png", display.actualContentWidth, display.actualContentHeight )
  background.x = display.contentCenterX
  background.y = display.contentCenterY

  textActions = display.newText( uiGroup, "Movimentos : " .. actions, 50, -10, native.systemFont, 14 )
  textActions:setFillColor( 0, 0, 0 )

  local player = display.newImage( mainGroup, "Img/player.png" )
  player.x = display.contentCenterX
  player.y = 10
  player.width = 40
  player.height = 40
  player.name = "player"

  local floor = display.newImageRect( backGroup, "Img/floor.png", display.actualContentWidth+80, 80 )
  floor.x = display.contentCenterX
  floor.y = display.actualContentHeight-30


  local leftControl = display.newImageRect( uiGroup, "Img/leftButton.png" , 50, 50 )
  leftControl.x = 30
  leftControl.y = display.actualContentHeight-100
  leftControl.name = "left"
  leftControl.alpha = 0.7

  local rightControl = display.newImageRect( uiGroup, "Img/rightButton.png", 50, 50 )
  rightControl.x = display.actualContentWidth-30
  rightControl.y = display.actualContentHeight-100
  rightControl.name = "right"
  rightControl.alpha = 0.7

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

    obstacle1 = display.newImage( "Img/ob1.png" )
    obstacle1.x = 50
    obstacle1.y = step
    obstacle1.width = step-20
    obstacle1.height = 20
    obstacle1.name = "obstacle1"

    obstacle2 = display.newImageRect( "Img/ob1.png", step-20, 20 )
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
  obstacle1.collision = onLocalCollision
  obstacle1:addEventListener( "collision" )
  obstacle2.collision = onLocalCollision
  obstacle2:addEventListener( "collision" )

end



function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end

function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene

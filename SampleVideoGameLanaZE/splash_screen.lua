-----------------------------------------------------------------------------------------
--
-- splash_screen.lua
-- Created by: Your Name
-- Date: Month Day, Year
-- Description: This is the splash screen of the game. It displays the 
-- company logo that...
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-- Name the Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Create Scene Object
local scene = composer.newScene( sceneName )

--hide status bar
display.setStatusBar(display.HiddenStatusBar)

----------------------------------------------------------------------------------------
-- SOUNDS
-----------------------------------------------------------------------------------------

local BarbieSound = audio.loadSound("Sounds/Barbie.mp3")
local BarbieSoundChannel

----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------


--VARIABLES--
local scrollSpeed = 3
local scrollSpeed2 = 5

local textObject
local backgroundImage
local companyLogo

----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------



--Functions:Move the company logo
--this function adds the scroll speed to the x-value of the logo
local function MoveLogo(event)
    --add the scroll speed to the x-value of the logo
    companyLogo.x = companyLogo.x - scrollSpeed
    --change the transparency of the logo every that it goes faster and fades out
    companyLogo.alpha = companyLogo.alpha - 0.0000000000000008
end

--Functions:Move the text object
--this function adds the scroll speed to the x-value of the text object
local function MoveText(event)
    --add the scroll speed to the x-value of the text
    textObject.x = textObject.x + scrollSpeed2
    --change the transparency of the text every that it goes faster and fades out
    textObject.alpha = textObject.alpha + 0.03
end


-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu" )
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- set the background to be black
    display.setDefault("background", 0, 0, 0)

    --create a backgrond image
    backgroundImage = display.newImageRect("Images/background.jpg", display.contentWidth*3, display.contentHeight*3)
    
    --create Go Go Little Pink Subject abd set it's color
    textObject = display.newText("Go Go Little Pink", 0, 100, nil, 80)
    textObject:setTextColor(165/255, 0/255, 160/255)
    textObject.alpha = 0

    --create the company logo and set its x and y of the logo
    companyLogo = display.newImageRect("Images/CompanyLogoLana@2x.png", 400, 500)
    companyLogo.x = 1000
    companyLogo.y = 570
    companyLogo.alpha = 1

    sceneGroup:insert( backgroundImage )
    sceneGroup:insert( companyLogo )
    sceneGroup:insert( textObject )
    
end 
--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- Call the MoveLogo and MoveText functions as soon as we enter the frame.
        Runtime:addEventListener("enterFrame", MoveLogo)
        Runtime:addEventListener("enterFrame", MoveText)

        BarbieSoundChannel = audio.play(BarbieSound)

        -- Go to the main menu screen after the given time.
        timer.performWithDelay ( 4000, gotoMainMenu)          
        
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        Runtime:removeEventListener("enterFrame", MoveLogo)
        Runtime:removeEventListener("enterFrame", MoveText)
        -- stop the jungle sounds channel for this screen
        audio.stop(BarbieSoundChannel)
    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene

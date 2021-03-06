---------- Declare libraries and globals ----------

local physics = require "physics"
local ouya_c = require("OuyaController")
-- local ouya = require("plugin.ouya")
local OptionsMenu = require("OptionsMenu")
local Clock = require("Clock")


display.setStatusBar( display.HiddenStatusBar )
mRand = math.random; -- without the (), this caches the random() function
local rainRate = 3.5;
local theBox;
local isOuya = true;
local theBG;
local dimBg;
local BG;
local overlay1;
local sourcePan;
local overlay2;
local dropGroup;
local titleScreen;
local offsetSpeed;
local rainDirection = 0;
local mychannel, mysource;
local initializeGame  --forward declaration

local optionsMenuScreen;
local settingsPrompt;

local theClock;
local wanderDestinationX =  mRand(1920);
local wanderDestinationY =  mRand(1080)
print (wanderDestinationX);
print(wanderDestinationY);
local wanderSpeed = .1;
local thunderFrameCount = 0;
local thunderCounter =  mRand(4);
local lastInteractionTime = os.time();
local ouyaXVelocity = 0;
local ouyaYVelocity= 0;
local w = 1920;
local h = 1080;
local debugText;

--load sprites here

--load sfx here
rainSFXTierOne = audio.loadSound("lightRain.mp3");
rainSFXTierTwo = audio.loadSound("medRain.mp3");
rainSFXTierThree = audio.loadSound("heavyRain3.mp3");
rainSFXTierFour = audio.loadSound("heaviestRain2.mp3");
thunderOne = audio.loadSound("thunderOne.mp3")
thunderTwo = audio.loadSound("thunderTwo.mp3");
thunderThree = audio.loadSound("thunderThree.mp3");
thunderFour = audio.loadSound("thunderFour.mp3");
local drops = {};  
---------- END Declare libraries and globals ----------


---------- INIT GAM`E FUNCTION. (Run every time game is launched and reset) ----------
local function recalculateRain(locx,locy, anim)
 --recalculate alpha of bg
     local percentageOfScreenHeight = math.abs(locy / h);
     local newAlpha = 120 * percentageOfScreenHeight;
     -- print((120-newAlpha)/255)
     transition.to(theBG, {alpha=(120-newAlpha)/255, time=500});
   --  theBG:setFillColor(51,0,102, 120-newAlpha);


  --recalculate rainrate
  rainRate = 30 * percentageOfScreenHeight;
  offsetSpeed = 500 * percentageOfScreenHeight;
  --recalculate rain direction:
  local screenWidthOffset = locx - w/2;
  rainDirection = screenWidthOffset;

  --recalculate audio panning
  local rainDirectionFraction = (rainDirection / (w/2)) * 5
  al.Source(mysource1, al.POSITION,  rainDirectionFraction, 0.0, math.abs(rainDirectionFraction))
  al.Source(mysource2, al.POSITION,  rainDirectionFraction, 0.0, math.abs(rainDirectionFraction))
al.Source(mysource3, al.POSITION,  rainDirectionFraction, 0.0, math.abs(rainDirectionFraction))
al.Source(mysource4, al.POSITION,  rainDirectionFraction, 0.0, math.abs(rainDirectionFraction))
al.Source(mysource5, al.POSITION,  rainDirectionFraction, 0.0, math.abs(rainDirectionFraction))
al.Source(mysource6, al.POSITION,  rainDirectionFraction, 0.0, math.abs(rainDirectionFraction))
al.Source(mysource7, al.POSITION,  rainDirectionFraction, 0.0, math.abs(rainDirectionFraction))
al.Source(mysource8, al.POSITION,  rainDirectionFraction, 0.0, math.abs(rainDirectionFraction))
  --recalculate each track's volume
  local tierOnePercentage = ((locy)/(h/3))/2
  audio.setVolume(tierOnePercentage, { channel=1})
  local tierTwoPercentage = (locy - h/3) / (h/3);
  audio.setVolume( tierTwoPercentage, { channel=2 } )

 local tierThreePercentage = (locy - (h*2/3)) / (h/4);
  audio.setVolume( tierThreePercentage, { channel=3 } )

  local tierFourPercentage = (locy - (h*4/5)) / (h/5);
  audio.setVolume( tierFourPercentage, { channel=4 } )
-- print ("tier four volume set to " .. tierFourPercentage)
  local thunderPercentage = (locy / h) * 2
   audio.setVolume( thunderPercentage, { channel=5 } )
    audio.setVolume( thunderPercentage, { channel=6 } )
     audio.setVolume( thunderPercentage, { channel=7 } )
     audio.setVolume( thunderPercentage, { channel=8 } )
  --recalculate the overlay
  if (anim == 1) then
  transition.to(overlay1, {y=-percentageOfScreenHeight*(2220-h), time=100});
  transition.to(overlay2, {y=-percentageOfScreenHeight*(2220-h) + overlay1.height, time=100});
else
  overlay1.y = -percentageOfScreenHeight*(2220-h);
  overlay2.y = -percentageOfScreenHeight*(2220-h) + overlay1.height;
end
  -- overlay1.y = -percentageOfScreenHeight*(2305-768);
  -- overlay2.y = -percentageOfScreenHeight*(2305-768) + overlay1.height;
  -- print("changing overlay.y to " .. overlay1.y);
end 


local function ouyaListener( event )

  --add your button specific code here
  -- buttonNameLabel.text = "Button Name: " ..event.buttonName
  -- debugText.text = event.buttonName .. " " .. event.phase;
  -- buttonStateLabel.text = "Button State: " ..event.phase
  if (optionsMenuScreen.activated) then
    if event.buttonName == "menu" and event.phase == "pressed" then
      optionsMenuScreen:deactivate();
      updateLastInteractionTime();
      print("deactivating")
    end
     if event.buttonName == "back" and event.phase == "pressed" then
      optionsMenuScreen:deactivate();
      updateLastInteractionTime();
      print("deactivating")
    end
      if (event.buttonName == "a" and event.phase == "pressed") then
        -- ouyaSDK.asyncLuaOuyaRequestPurchase(onSuccess, onSuccess, onSuccess, "donate_justrain");
        -- plugin_ouya.asyncLuaOuyaRequestPurchase(onSuccess,onFailure,onCancel,"donate_justrain");
    
        -- plugin_ouya.asyncLuaOuyaRequestPurchase(onSuccess, onFailure, onCancel, "donate_justrain");
        -- ouyaSDK.asyncLuaOuyaRequestPurchase(onSuccess, onFailure, onCancel, "donate_justrain");
        ouyaSDK.asyncLuaOuyaRequestPurchase(onSuccess, onFailure, onCancel, "donate_justrain");
      end
    if event.buttonName == "up" and event.phase == "pressed" then
      optionsMenuScreen:selectPrev();
      updateLastInteractionTime();
    end
     if event.buttonName == "down" and event.phase == "pressed" then
      optionsMenuScreen:selectNext();
      updateLastInteractionTime();
    end
    if event.buttonName == "center" and event.phase == "pressed" then
      optionsMenuScreen:toggleOption();
      updateLastInteractionTime();
    end



  else
    if event.buttonName == "menu" and event.phase == "pressed" then
     
      optionsMenuScreen:activate();
      updateLastInteractionTime();
      print("activating")
    end

if event.buttonName == "up" and event.phase == "pressed" then
ouyaYVelocity = -10;
updateLastInteractionTime();
end
if event.buttonName == "up" and event.phase =="released" then
ouyaYVelocity = 0;
updateLastInteractionTime();
  end
if event.buttonName == "down" and event.phase == "pressed" then
ouyaYVelocity =  10;
updateLastInteractionTime();
end
if event.buttonName == "down" and event.phase =="released" then
ouyaYVelocity = 0;
updateLastInteractionTime();
  end
if event.buttonName == "left" and event.phase == "pressed" then
ouyaXVelocity = -10;
updateLastInteractionTime();
end
if event.buttonName == "left" and event.phase =="released" then
ouyaXVelocity = 0;
updateLastInteractionTime();
  end

if event.buttonName == "right" and event.phase == "pressed" then
ouyaXVelocity =  10;
updateLastInteractionTime();
end
if event.buttonName == "right" and event.phase =="released" then
ouyaXVelocity = 0;
updateLastInteractionTime();
  end
print("ouyavelocity is " .. ouyaXVelocity);
  --Usable buttons as of build #971
  --O, U, A, D-Pad, Left Thumbstick
  recalculateRain(theBox.x, theBox.y, 0);

  end
  --EXAMPLE:
  --if event.buttonName == "o" and event.phase == "pressed" then
  --  player.jump()
  --elseif event.buttonName == "u" and event.phase == "pressed" then
  --  player.punch()
  --end

end


function manageTouch(event)

  if (event.phase == "began") then
    -- print("touch began");
    updateLastInteractionTime();
    physics.addBody(theBox, {density = 1, friction = .3, bounce = .01, isSensor=true});
    theBox.bodyType = "static"
    theBox.x = event.x;
    theBox.y = event.y;
    recalculateRain(theBox.x, theBox.y, 1)
  
end

if (event.phase == "moved") then
  updateLastInteractionTime();
  -- make sure that the overlay doesn't slide past the end of the screen
if (event.y < h) then
  if (event.y>0) then
  -- print("thing onscreen");
 -- print(event.x);
 theBox.x = event.x;
 theBox.y = event.y;
recalculateRain(theBox.x, theBox.y, 0)
  end
end
end
if (event.phase == "ended") then
updateLastInteractionTime();
-- print("touch ended");
theBox.x = event.x;
theBox.y = event.y;
transition.to(theBox, {time=500, alpha = 0.0} )
recalculateRain(theBox.x, theBox.y, 0)
physics.removeBody( theBox );
end

if (rainRate < 1) then

  rainRate = 1

end

end

---------- RUN TITLE SCREEN (first function that gets run) -----------
onSuccess = function (jsonData)
debugText.text = "something happened at least success"
  end
 onFailure = function(errorCode, errorMessage)
debugText.text = "something happened at least failure"
  end
onCancel = function()
debugText.text = "something happened at least cancel"
  end

function requestPurchase()
 
debugText.text="requesting products..."
 -- plugin_ouya.asyncLuaOuyaRequestPurchase(onSuccess, onSuccess, onSuccess, "donate_justrain");
 products = {"donate_justrain"};
 -- plugin_ouya.asyncLuaOuyaRequestProducts(onSuccess, onFailure, onCancel, products);
 ouyaSDK.asyncLuaOuyaRequestPurchase(onSuccess, onFailure, onCancel, "donate_justrain");
 debugText.text="bueler?"
end

local function runTitleScreen()

  local function registerOuyaID()
    -- plugin_ouya.developerId = "7750f484-f49d-4a4d-8e37-5ef3efbf5eba";
  --ouyaSDK.ouyaSetDeveloperId("7750f484-f49d-4a4d-8e37-5ef3efbf5eba")
    
     -- timer.performWithDelay(10000,requestPurchase)
   
  end
   
  timer.performWithDelay(5000,registerOuyaID)
    
    initializeGame(); 
    --display title screen graphics, create start buttons, etc., launch animations
   
   
    local function startRain()

      if (titleScreen ~= nil) then
      titleScreen:removeSelf();
      titleScreen = nil;
      --initializeGame() -- for now, just initialize the game
      end
    end
    -- function titleScreen:tap(event)
    --   print ("tapped");


    --   -- transition.to(titleScreen, {time=1000, alpha=0.0, onComplete=startRain})
    -- end

    -- local function startButton:tap( event ) 

    --     --remove title screen group
    --     --remove self, etc.

    -- end
    
  end

---------- END TITLE SCREEN FUNCTION ----------

-- 
----------APP BEGINS HERE----------
--

local function manageClock()
  -- print("manage clock being run")
  theClock:update(optionsMenuScreen.options[1].toggle)
end

function updateLastInteractionTime()
  lastInteractionTime = os.time();
end

local function manageAutoDim()
  local timeSinceLastInteraction = os.time() - lastInteractionTime;
  -- print(timeSinceLastInteraction)

  if (optionsMenuScreen.options[3].toggle == "on") then
    if (timeSinceLastInteraction > (60*5)) then

      dimBg.alpha = 0.8;
    else
      dimBg.alpha = 0;
    end
  end

end

local function manageExtraThunder()

  if (optionsMenuScreen.options[4].toggle == "on") then
  print (thunderFrameCount)
  thunderFrameCount = thunderFrameCount + 1;
if (thunderFrameCount % 300 == 0) then
  print("playing a thunder")
  thunderCounter = thunderCounter + 1;
  local whichThunder = thunderCounter % 4;

  if (whichThunder == 0) then
    mychannel5, mysource5 = audio.play(thunderOne, { channel=5, loops=1})
    print("playing a thunder ONE")
  elseif (whichThunder == 1) then
    mychannel6, mysource6 = audio.play(thunderTwo, { channel=6, loops=1})
    print("playing a thunder TWO")
  elseif (whichThunder == 2) then
    mychannel7, mysource7 = audio.play(thunderThree, { channel=7, loops=1})
    print("playing a thunder THREE")
    elseif (whichThunder ==3 ) then
      print("playing a thunder FOUR")
    mychannel8, mysource8 = audio.play(thunderFour,{channel=8, loops=1})
  end
 end
end
end
local function manageWanderMode()

  if (optionsMenuScreen.options[2].toggle == "on") then
    print ("the boxx and y are " .. theBox.x)
    print (theBox.y)
    print ('wanderdestX is ' .. wanderDestinationX)
     print ('wanderdestY is ' .. wanderDestinationY)

    if (wanderDestinationX < theBox.x) then
      theBox.x = theBox.x - wanderSpeed;
    elseif (wanderDestinationX > theBox.x) then
      theBox.x = theBox.x + wanderSpeed;
    end

    if (wanderDestinationY < theBox.y) then
      theBox.y = theBox.y - wanderSpeed;
    
    elseif (wanderDestinationY > theBox.y) then
       theBox.y = theBox.y + wanderSpeed;
    
    end

    if (math.abs(wanderDestinationX - theBox.x) < 2 and math.abs(wanderDestinationY - theBox.y) < 2) then
      --generate a new wanderDestination
      wanderDestinationX = mRand(1920)
      wanderDestinationY = mRand(1080)
      print ("wander destination X is now " .. wanderDestinationX);
      print ("wander destination X is now " .. wanderDestinationY);
    end
  end
end

local function fireSplish(whereX, whereY)
  local splish = display.newImageRect("splish.png", 10, 2);
   dropGroup:insert(splish);
  local function splishRemove()

    splish:removeSelf();
    splish=nil;

  end


  splish.x = whereX;
  splish.y = whereY;
  transition.to(splish, {time=100, alpha=0.0, xScale=4.0, onComplete=splishRemove})
end
local function runMain()
-- ouyaText:toFront();
  manageClock();
  manageAutoDim()
  manageExtraThunder()
--print( display.fps )
theBox.x = theBox.x + ouyaXVelocity;
theBox.y = theBox.y + ouyaYVelocity;

  manageWanderMode();
if (theBox.x >= w) then
  theBox.x = w;
end
if (theBox.x <= 0) then
  theBox.x = 0
end
if (theBox.y >= h) then
  theBox.y = h;
end
if (theBox.y <= 0) then
  theBox.y = 0
end

recalculateRain(theBox.x,theBox.y, 0);
-- Add new drops at the rate and direction that is current, with a random start value

for i = 1, rainRate do

  local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
     self.isVisible = false;
                -- self = nil;
    end
  end


    local dropCollisionFilter ={ groupIndex = -2 }
    local drop = display.newImageRect("rain.png", 3, 17);
    dropGroup:insert(drop);
    drop:setReferencePoint(display.BottomCenterReferencePoint)
    local randomDropLength = (100 + mRand(500))/100;
    drop.yScale = randomDropLength;
    local randomXVelFactor = mRand(-50,50)
    physics.addBody(drop, {density = 1, friction = .3, bounce = .01, filter=dropCollisionFilter});
    drop:setLinearVelocity(rainDirection+randomXVelFactor, offsetSpeed + 800 + mRand(200)); --rainDirection will range from -512 to 512
    local rotationAngle = math.deg(math.atan2(-(rainDirection+randomXVelFactor),900)); 
    --rotationAngle = 0;
    --print (rotationAngle);
    drop.rotation = rotationAngle;
    --give the drop a random end value
    drop.endValue = mRand(h-180,h-20);
    drop.alpha = 0.8;
    sourcePan = rainDirection / 2.5;
    drop.x = mRand(-320,w+300) - sourcePan;
    drop.y = 0;
    
    drop.collision = onLocalCollision
    drop:addEventListener( "collision", drop )
    table.insert( drops, drop )


  end




-- Go through all the rain drops, check for offscreen, if so, remove them from the table, the screen, and fire a 'plink'
    -- for i=#drops,1,-1 do
    --     if (drops[i] ~= nil) then
    --         if(drops[i].y > 600 ) then

    --             drops[i]:removeSelf();
    --             drops[i] = nil;
    --         end
    --     end
    -- end

    for i = #drops, 1, -1 do
      if drops[i].y > drops[i].endValue then
      if drops[i].isVisible then 
        fireSplish(drops[i].x, drops[i].endValue);
      end
      local child = table.remove(drops, i)
      if child ~= nil then
        display.remove(child)
        child = nil
      end
    end
  end

if (titleScreen ~=nil ) then
  -- titleScreen:toFront();
end

end
--
----------END APP START----------
--


--
----------AUXILLIARY FUNCTIONS---------- 
--

local function memCheck()
    -- local result = audio.usedChannels
    -- print(result);
     -- local mem = collectgarbage("count")
     -- print(mem);
     -- print(system.getInfo( "textureMemoryUse" ))
   end

   local function onSystemEvent( event )

    local function initCallback( event )

      if event.data then

        GC = true;
      else
        GC = false;
      end

      print ("GC is " .. GC);
    end
  end
  initializeGame = function()


    -- reset variables here, set things into motion
    physics.start();
    physics.setGravity(0,0);  
    
     --physics.setDrawMode ("hybrid");
    system.setIdleTimer( false )  -- disable (turn off) the idle timer
    Runtime:addEventListener("touch", manageTouch)
    Runtime:addEventListener("enterFrame", runMain);
    -- create the BG

    offsetSpeed = 0;
    -- theBG = display.newRect(-500,0,2024,768);
    theBG = display.newRect(-500,0,w,h);
    theBG:setFillColor(51,0,102, 255);
    theBG.alpha = 60/255

    BG = display.newImageRect("home.png",1920,1080);
    BG:setReferencePoint(display.TopCenterReferencePoint)
    BG.y = 0;
    BG.x = w/2;
    BG.width = w; 
    BG.height = h

    overlay1 = display.newImage("overlay1c.png",true);

    overlay1:setReferencePoint(display.TopCenterReferencePoint)
    overlay1.x = w/2;
    overlay1.y=0;
    overlay1.width = w;
   
    overlay2 = display.newImage("overlay2c.png",true);

    overlay2:setReferencePoint(display.TopCenterReferencePoint)
    overlay2.x = w/2;
    overlay2.y=overlay1.height;
    overlay2.width = w;
     -- overlay2.alpha = 0;

    overlay3 = display.newImage("overlay3c.png",true);
    overlay3:setReferencePoint(display.TopCenterReferencePoint)
    overlay3.x = w/2;
    overlay3.y=overlay1.height;
    overlay3.width = w;
     -- overlay3.alpha = 0;

    --create the box

    theBox = display.newCircle(w/2 - 25 , h/2 - 25, 25, 25)
    theBox:setReferencePoint(display.CenterReferencePoint)
    theBox.strokeWidth = 3
    theBox:setFillColor(76, 76, 230)
    theBox:setStrokeColor(76,76,230)
    theBox.alpha = 0.0;

    dropGroup = display.newGroup();
    
    --create the clock
    theClock = Clock.new();

     titleScreen = display.newImageRect("title.png",1500,800);
    titleScreen:setReferencePoint(display.CenterReferencePoint);
    titleScreen.x = w/2;
    -- titleScreen.x = 2;
    titleScreen.y = h/2;
    -- titleScreen:toFront();
    titleScreen:addEventListener("tap", titleScreen)
    transition.to(titleScreen,{time=1000, delay=5000, alpha=0.0});
    
    -- create the menu options
    settingsPrompt = display.newGroup();
    settingsPrompt.alpha = 0;
    local menuIcon = display.newImage("m-key.png",150,900)
    local menuText = display.newText("MENU", 200, 899, "Knockout-HTF29-JuniorLiteweight", 40)
    settingsPrompt:insert(menuIcon);
    settingsPrompt:insert(menuText);
    transition.to(settingsPrompt,{time=1000, delay=1000, alpha=1.0});
    transition.to(settingsPrompt,{time=1000, delay=8000, alpha=0.0});
    optionsMenuScreen = OptionsMenu.new();
   

    dimBg = display.newRect(0,0,1920,1080)
    dimBg:setFillColor(0,0,0);
    dimBg.alpha = 0;

    debugText = display.newText("hi", 300, 50, "Knockout-HTF29-JuniorLiteweight", 40) -- HTF29-JuniorLiteweight
    debugText.alpha = 0;
   print(optionsMenuScreen.activated);
   -- optionsMenuScreen:activate();
    --play the sound
    mychannel1, mysource1 = audio.play(rainSFXTierOne, { channel=1, loops=-1})
    audio.setVolume( 0.4, { channel=1 } ) -- was 4
    mychannel2, mysource2 = audio.play(rainSFXTierTwo, { channel=2, loops=-1})
    audio.setVolume( 0.5, { channel=2 } ) -- was 5
    mychannel3, mysource3 = audio.play(rainSFXTierThree, { channel=3, loops=-1})
    audio.setVolume( 0.0, { channel=3 } )
     mychannel4, mysource4 = audio.play(rainSFXTierFour, { channel=4, loops=-1})
    audio.setVolume( 0.0, { channel=4 } )

    al.Source(mysource1, al.POSITION,  0.0, 0.0, 0.0)
    al.Source(mysource2, al.POSITION,  0.0, 0.0, 0.0)
    al.Source(mysource3, al.POSITION,  0.0, 0.0, 0.0)
    al.Source(mysource4, al.POSITION,  0.0, 0.0, 0.0)

    al.Listener(al.POSITION,  0.0, 0.0, 5.0)
  end

---------- END INIT GAME FUNCTION ----------

runTitleScreen();
--
----------END AUXILLIARY FUNCTIONS---------
--

--
----------ADD GLOBAL LISTENERS---------
--

--Runtime:addEventListener( "system", onSystemEvent )

Runtime:addEventListener("enterFrame", memCheck);
--set the event listener for the controller
ouya_c:setListener( ouyaListener )
  
-- 
----------END ADD GLOBAL LISTENERS
--
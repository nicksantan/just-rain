--OptionsMenu.lua
--A class for the main Just Rain options menu

module(..., package.seeall)

local OptionsMenu = {}
 
function OptionsMenu.new()
  
  local optionsMenu = display.newGroup();
  local bg = display.newRect(600,750,1400,450)
  local minTextAlpha = 1.0; -- was 0.6
  local minToggleBoxAlpha = 0.1;
  local textYStart = 300;
  local textYSpacing = 50;
  local textXStart = 400;
  local backHotZone = display.newRect(display.screenOriginX, display.screenOriginY, display.contentWidth, display.contentHeight);
    backHotZone:setFillColor(255,255,255);
    backHotZone.alpha = 0;
    backHotZone.isHitTestable = true;
    optionsMenu:insert(backHotZone);
     local function backTouch(self, event)
    if (event.phase == "began") then
optionsMenu:deactivate();
--menuHotZone.isHitTestable = true;
end
   end

   local function bgTouch(self, event)
    print("bg touched")
   return true;
   end
    backHotZone.touch = backTouch;
 backHotZone:addEventListener( "touch",  backHotZone )
    optionsMenu:insert(backHotZone);
  bg:setReferencePoint(display.centerReferencePoint);
  bg.x = display.contentCenterX
  bg.y = display.contentCenterY - 65;
  bg:setFillColor(0,0,0,255)
  bg.alpha = 0.8;
  bg.isHitTestable = true;
  bg.touch = bgTouch;
  bg:addEventListener( "touch",  bg )
  optionsMenu:insert(bg);

  optionsMenu.alpha = 0;
  optionsMenu.activated = false;
  optionsMenu.selection = 1;

local function onToggleTouch(self, event)
    if (event.phase == "began") then
    if (optionsMenu.options[self.id].toggle == "off") then
      if (self.id == 7) then
        timeSleepTimerSet = os.time();
        print("SETTING TIME SLEEP TIMER SET")
      end
      
      if (self.id == 5) then
        native.setProperty( "windowMode", "fullScreen" )
      end

      optionsMenu.options[self.id].toggle = "on"
      optionsMenu.options[self.id].toggleBox.alpha = 1.0;
    else
      if (self.id == 5) then
        native.setProperty( "windowMode", "normal" )
      end
      optionsMenu.options[self.id].toggle = "off"
       optionsMenu.options[self.id].toggleBox.alpha = minToggleBoxAlpha;
    end
  end
  return true
  end

local backPrompt = display.newGroup();
    -- backPrompt.alpha = 1.0;
       
   --  local donateIcon = display.newImage("ouyadonate.png", 150,750)
   --  local donateText = display.newText("DONATE $0.99",200,750, "Knockout-HTF29-JuniorLiteweight", 40)

   --  local selectIcon = display.newImage("ouyaselect.png", 150,800)
   --  local selectText = display.newText("SELECT",200,800, "Knockout-HTF29-JuniorLiteweight", 40)

   --  local backIcon = display.newImage("ouyaback.png",150,850)
   --  local backText = display.newText("BACK", 200, 850, "Knockout-HTF29-JuniorLiteweight", 40)

   -- -- backPrompt:insert(backHotZone)
   --  backPrompt:insert(backIcon);
   --  backPrompt:insert(backText);
   --  backPrompt:insert(selectIcon);
   --  backPrompt:insert(selectText)
   --  backPrompt:insert(donateIcon);
   --  backPrompt:insert(donateText);
    -- transition.to(backPrompt,{time=1000, delay=1000, alpha=1.0});
  
 optionsMenu:insert(backPrompt);
  local optionClockText = display.newText("Clock", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionClockText:setReferencePoint(display.TopLeftReferencePoint);
  optionClockText.alpha = 1.0;
  optionClockText.x = textXStart;
  optionClockText.y = textYStart;


  local optionClockToggleBox = display.newRect(1510,650,30,30);
  optionClockToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionClockToggleBox.alpha = minToggleBoxAlpha;
  optionClockToggleBox.y = textYStart ;
  optionClockToggleBox.id = 1;

  optionClockToggleBox.touch = onToggleTouch
  optionClockToggleBox:addEventListener( "touch", optionClockToggleBox )

   local optionWanderText =  display.newText("Wander Mode (rain changes direction and intensity over time)", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionWanderText:setReferencePoint(display.TopLeftReferencePoint);
  optionWanderText.alpha = minTextAlpha;
    optionWanderText.x = textXStart;
  optionWanderText.y = textYStart + textYSpacing

    local optionTwoToggleBox = display.newRect(1510,670,30,30);
  optionTwoToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionTwoToggleBox.alpha = minToggleBoxAlpha;
  optionTwoToggleBox.y = textYStart  + textYSpacing;
  optionTwoToggleBox.id = 2
   optionTwoToggleBox.touch = onToggleTouch
optionTwoToggleBox:addEventListener( "touch", optionTwoToggleBox )

   local optionAutoDimText = display.newText("Auto-dim after 5 minutes of inactivity", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionAutoDimText:setReferencePoint(display.TopLeftReferencePoint);
  optionAutoDimText.alpha = minTextAlpha;
  optionAutoDimText.x = textXStart;
  optionAutoDimText.y = textYStart + textYSpacing * 2;

    local optionThreeToggleBox = display.newRect(1510,690,30,30);
  optionThreeToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionThreeToggleBox.alpha = minToggleBoxAlpha;
   optionThreeToggleBox.y = textYStart  + textYSpacing * 2;
   optionThreeToggleBox.id = 3
    optionThreeToggleBox.touch = onToggleTouch
optionThreeToggleBox:addEventListener( "touch", optionThreeToggleBox )

   local optionExtraThunderText = display.newText("Extra Thunder", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionExtraThunderText:setReferencePoint(display.TopLeftReferencePoint);
  optionExtraThunderText.alpha = minTextAlpha;
   optionExtraThunderText.x = textXStart;
  optionExtraThunderText.y = textYStart + textYSpacing * 3;

    local optionFourToggleBox = display.newRect(1510,710,30,30);
  optionFourToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionFourToggleBox.alpha = minToggleBoxAlpha;
  optionFourToggleBox.y = textYStart  + textYSpacing * 3;
  optionFourToggleBox.id = 4;
   optionFourToggleBox.touch = onToggleTouch
optionFourToggleBox:addEventListener( "touch", optionFourToggleBox )

local optionFullscreen = display.newText("Fullscreen Mode", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionFullscreen:setReferencePoint(display.TopLeftReferencePoint);
optionFullscreen.alpha = minTextAlpha;
 optionFullscreen.x = textXStart;
optionFullscreen.y = textYStart + textYSpacing * 4;

  local optionFiveToggleBox = display.newRect(1510,730,30,30);
optionFiveToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionFiveToggleBox.alpha = 1.0;
optionFiveToggleBox.y = textYStart  + textYSpacing * 4;
optionFiveToggleBox.id = 5;
 optionFiveToggleBox.touch = onToggleTouch
optionFiveToggleBox:addEventListener( "touch", optionFiveToggleBox )

local optionMonochomeMode = display.newText("Monochrome Mode", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionMonochomeMode:setReferencePoint(display.TopLeftReferencePoint);
optionMonochomeMode.alpha = minTextAlpha;
 optionMonochomeMode.x = textXStart;
optionMonochomeMode.y = textYStart + textYSpacing * 5;

  local optionSixToggleBox = display.newRect(1510,730,30,30);
optionSixToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionSixToggleBox.alpha = minToggleBoxAlpha;
optionSixToggleBox.y = textYStart  + textYSpacing * 5;
optionSixToggleBox.id = 6;
 optionSixToggleBox.touch = onToggleTouch
optionSixToggleBox:addEventListener( "touch", optionSixToggleBox )

local optionSleepTimer = display.newText("Sleep Timer (App shuts off after 1 hour of inactivity)", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionSleepTimer:setReferencePoint(display.TopLeftReferencePoint);
optionSleepTimer.alpha = minTextAlpha;
 optionSleepTimer.x = textXStart;
optionSleepTimer.y = textYStart + textYSpacing * 6;

  local optionSevenToggleBox = display.newRect(1510,750,30,30);
optionSevenToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionSevenToggleBox.alpha = minToggleBoxAlpha;
optionSevenToggleBox.y = textYStart  + textYSpacing * 6;
optionSevenToggleBox.id = 7;
 optionSevenToggleBox.touch = onToggleTouch
optionSevenToggleBox:addEventListener( "touch", optionSevenToggleBox )

  optionsMenu:insert(optionClockText)
  optionsMenu:insert(optionClockToggleBox)
  optionsMenu:insert(optionWanderText)
  optionsMenu:insert(optionTwoToggleBox)
  optionsMenu:insert(optionAutoDimText)
  optionsMenu:insert(optionThreeToggleBox)
  optionsMenu:insert(optionExtraThunderText)
  optionsMenu:insert(optionFourToggleBox)
  optionsMenu:insert(optionFullscreen)
  optionsMenu:insert(optionFiveToggleBox)
  optionsMenu:insert(optionMonochomeMode)
  optionsMenu:insert(optionSixToggleBox)
  optionsMenu:insert(optionSleepTimer)
  optionsMenu:insert(optionSevenToggleBox)
  
  optionsMenu.options = {
  {text = optionClockText, toggle = "off", toggleBox = optionClockToggleBox},
  {text = optionWanderText, toggle = "off", toggleBox = optionTwoToggleBox},
  {text = optionAutoDimText, toggle = "off", toggleBox = optionThreeToggleBox},
  {text = optionExtraThunderText, toggle = "off", toggleBox = optionFourToggleBox},
  {text = optionFullscreen, toggle = "on", toggleBox = optionFiveToggleBox},
  {text = optionMonochomeMode, toggle = "off", toggleBox = optionSixToggleBox},
  {text = optionSleepTimer, toggle = "off", toggleBox = optionSevenToggleBox},

}
  function optionsMenu:activate()
  	 transition.to(self, {time = 500, alpha = 1.0})
  	 self.activated = true;
  end

  function optionsMenu:deactivate()
  	transition.to(self, {time = 500, alpha = 0.0})
  	self.activated = false;
  end

  function optionsMenu:selectPrev()
  	self.selection = self.selection - 1;

  	if (self.selection < 1) then
  		self.selection = 1;
  	end

  	print(self.options[self.selection][2])
  	for i=1,#self.options do
  		if (i ~= self.selection) then
  			self.options[i]["text"].alpha = minTextAlpha;
  		end
  	end
  	self.options[self.selection]["text"].alpha = 1.0;
  	
  end

  function optionsMenu:selectNext()
  	self.selection = self.selection + 1;

  	if (self.selection > #self.options) then
  		self.selection = #self.options;
  	end

  	print(self.options[self.selection].toggle)
  	for i=1,#self.options do
  		if (i ~= self.selection) then
  			self.options[i]["text"].alpha = minTextAlpha;
  		end
  	end
  	self.options[self.selection]["text"].alpha = 1.0;
  	
  end

  function optionsMenu:toggleOption()
  	if (self.options[self.selection].toggle == "off") then
  		self.options[self.selection].toggle = "on"
      self.options[self.selection].toggleBox.alpha = 1.0;
   	else
   		self.options[self.selection].toggle = "off"
       self.options[self.selection].toggleBox.alpha = minToggleBoxAlpha;
   	end
  	
   	print(self.options[self.selection].toggle);

  end

 
       
  return optionsMenu
        
end
 
return OptionsMenu

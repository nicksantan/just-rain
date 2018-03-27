--OptionsMenu.lua
--A class for the main Just Rain options menu

module(..., package.seeall)
-- local extendedPurchased = false;
local OptionsMenu = {}
 
function OptionsMenu.new(extended)
  -- local extendedPurchased = extended;
  local optionsMenu = display.newGroup();
  local bg = display.newRect(600,400,display.actualContentWidth,display.actualContentHeight)
  local minTextAlpha = 1;
  local minToggleBoxAlpha = 0.1;
  local textYStart = 80;
  local textYSpacing = 70;
  local textXStart = 50;
  bg:setReferencePoint(display.centerReferencePoint);
  bg.x = display.contentCenterX
  bg.y = display.contentCenterY;
  bg:setFillColor(0,0,0,255)
  bg.alpha = 0.8;
  optionsMenu:insert(bg);
  optionsMenu.alpha = 0;
  optionsMenu.activated = false;
  optionsMenu.selection = 1;

local function onToggleTouch(self, event)
  if (extendedPurchased or optionsMenu.options[self.id].extended == false) then
    if (event.phase == "began") then
      if (optionsMenu.options[self.id].toggle == "off") then
            if (self.id == 6) then
          timeSleepTimerSet = os.time();
          print("SETTING TIME SLEEP TIMER SET")
        end
        optionsMenu.options[self.id].toggle = "on"
        optionsMenu.options[self.id].toggleBox.alpha = 1.0;

    
       
      else
        optionsMenu.options[self.id].toggle = "off"
        optionsMenu.options[self.id].toggleBox.alpha = minToggleBoxAlpha;

       

      end
    end
  end
end

local backPrompt = display.newGroup();

    -- backPrompt.alpha = 1.0;
    local backHotZone = display.newRect(display.screenOriginX, display.contentHeight - 200, 200, 200);
    backHotZone:setFillColor(255,0,255);
    backHotZone.alpha = 0;
    backHotZone.isHitTestable = true;

    -- local selectIcon = display.newImage("ouyaselect.png", 150,800)
    -- local selectText = display.newText("SELECT",200,789, "Knockout-HTF29-JuniorLiteweight", 40)
    local backIcon = display.newImage("amazonback.png",display.screenOriginX + 50,650)
    local backText = display.newText("Back", display.screenOriginX + 100, 649, "Knockout-HTF29-JuniorLiteweight", 40)
  

 -- backPrompt.alpha = 1.0;
    local purchaseHotZone = display.newRect(display.actualContentWidth-600, display.contentHeight - 200, 600, 200);
    purchaseHotZone:setFillColor(255,255,255);
    purchaseHotZone.alpha = 0.0;
    purchaseHotZone.isHitTestable = true;
    if (extendedPurchased == true) then
purchaseHotZone.isHitTestable = false;
  end

    -- local selectIcon = display.newImage("ouyaselect.png", 150,800)
    -- local selectText = display.newText("SELECT",200,789, "Knockout-HTF29-JuniorLiteweight", 40)
    -- local purchaseIcon = display.newImage("amazonback.png",display.pixelHeight,650)
    -- purchaseIcon:setReferencePoint(display.CenterRightReferencePoint);
    -- purchaseIcon.x = display.screenOriginX + display.actualContentWidth;


    local purchaseText = display.newText("Purchase Extended Features", display.actualContentWidth - 560, 649, "Knockout-HTF29-JuniorLiteweight", 40)
    purchaseText:setReferencePoint(display.TopRightReferencePoint)
    purchaseText.x = display.screenOriginX + display.actualContentWidth - 50;
  

 if (extendedPurchased == true) then
purchaseIcon.alpha = 0;
purchaseText.alpha = 0;
purchaseHotZone.alpha = 0;
purchaseHotZone.isHitTestable = false;

end


   backPrompt:insert(backIcon);
    backPrompt:insert(backText);
    backPrompt:insert(backHotZone);
    backPrompt:insert(purchaseHotZone);
    -- backPrompt:insert(purchaseIcon);
    backPrompt:insert(purchaseText)
   
 local function purchaseTouch(self, event)
    if (event.phase == "began") then

    purchaseItem();
end
   end
      purchaseHotZone.touch = purchaseTouch;
 purchaseHotZone:addEventListener( "touch",  purchaseHotZone )

   local function backTouch(self, event)
    if (event.phase == "began") then
optionsMenu:deactivate();
menuHotZone.isHitTestable = true;
end
   end
      backHotZone.touch = backTouch;
 backHotZone:addEventListener( "touch",  backHotZone )
    -- backPrompt:insert(selectIcon);
    -- backPrompt:insert(selectText)
    -- transition.to(backPrompt,{time=1000, delay=1000, alpha=1.0});
  
  optionsMenu:insert(backPrompt);

    local muteSoundText = display.newText("Mute Sounds", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  muteSoundText:setReferencePoint(display.TopLeftReferencePoint);
  muteSoundText.alpha = 1.0;
  muteSoundText.x = textXStart;
  muteSoundText.y = textYStart;
  
  local muteSoundToggleBox = display.newRect(890,640,50,50);
  muteSoundToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  muteSoundToggleBox.alpha = minToggleBoxAlpha;
  muteSoundToggleBox.y = textYStart;
  muteSoundToggleBox.id = 1;
   muteSoundToggleBox.touch = onToggleTouch
muteSoundToggleBox:addEventListener( "touch", muteSoundToggleBox )


  local optionClockText = display.newText("Clock", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionClockText:setReferencePoint(display.TopLeftReferencePoint);
  optionClockText.alpha = minTextAlpha;
  optionClockText.x = textXStart;
  optionClockText.y = textYStart + textYSpacing;
  
  local optionClockToggleBox = display.newRect(890,650,50,50);
  optionClockToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionClockToggleBox.alpha = minToggleBoxAlpha;
  optionClockToggleBox.y = textYStart + textYSpacing;
  optionClockToggleBox.id = 2;

  -- optionClockToggleBox:addEventListener()
  

  optionClockToggleBox.touch = onToggleTouch
optionClockToggleBox:addEventListener( "touch", optionClockToggleBox )

   local optionWanderText =  display.newText("Wander Mode (rain changes direction and intensity over time)", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionWanderText:setReferencePoint(display.TopLeftReferencePoint);
  optionWanderText.alpha = minTextAlpha;
    optionWanderText.x = textXStart;
  optionWanderText.y = textYStart + textYSpacing * 2


    local optionTwoToggleBox = display.newRect(890,670,50,50);
  optionTwoToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionTwoToggleBox.alpha = minToggleBoxAlpha;
  optionTwoToggleBox.y = textYStart + textYSpacing * 2;
  optionTwoToggleBox.id = 3

   optionTwoToggleBox.touch = onToggleTouch
optionTwoToggleBox:addEventListener( "touch", optionTwoToggleBox )

   local optionAutoDimText = display.newText("Auto-dim after 5 minutes of inactivity", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionAutoDimText:setReferencePoint(display.TopLeftReferencePoint);
  optionAutoDimText.alpha = minTextAlpha;
  optionAutoDimText.x = textXStart;
  optionAutoDimText.y = textYStart + textYSpacing * 3;

    local optionThreeToggleBox = display.newRect(890,690,50,50);
  optionThreeToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionThreeToggleBox.alpha = minToggleBoxAlpha;
   optionThreeToggleBox.y = textYStart + textYSpacing * 3;
   optionThreeToggleBox.id = 4
    optionThreeToggleBox.touch = onToggleTouch
optionThreeToggleBox:addEventListener( "touch", optionThreeToggleBox )

local optionExtraThunderText = display.newText("Extra Thunder", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionExtraThunderText:setReferencePoint(display.TopLeftReferencePoint);
optionExtraThunderText.alpha = minTextAlpha;
optionExtraThunderText.x = textXStart;
optionExtraThunderText.y = textYStart + textYSpacing * 4

local optionFourToggleBox = display.newRect(890,710,50,50);
optionFourToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionFourToggleBox.alpha = minToggleBoxAlpha;
optionFourToggleBox.y = textYStart + textYSpacing * 4;
optionFourToggleBox.id = 5;

optionFourToggleBox.touch = onToggleTouch
optionFourToggleBox:addEventListener( "touch", optionFourToggleBox )

local optionSleepTimerText = display.newText("Sleep Timer (App will shut off after one hour)", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionSleepTimerText:setReferencePoint(display.TopLeftReferencePoint);
optionSleepTimerText.alpha = minTextAlpha;
optionSleepTimerText.x = textXStart;
optionSleepTimerText.y = textYStart + textYSpacing * 5

local optionFiveToggleBox = display.newRect(890,710,50,50);
optionFiveToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionFiveToggleBox.alpha = minToggleBoxAlpha;
optionFiveToggleBox.y = textYStart + textYSpacing * 5;
optionFiveToggleBox.id = 6;

optionFiveToggleBox.touch = onToggleTouch
optionFiveToggleBox:addEventListener( "touch", optionFiveToggleBox )

local optionBlackAndWhiteText = display.newText("Monochrome Mode", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
optionBlackAndWhiteText:setReferencePoint(display.TopLeftReferencePoint);
optionBlackAndWhiteText.alpha = minTextAlpha;
optionBlackAndWhiteText.x = textXStart;
optionBlackAndWhiteText.y = textYStart + textYSpacing * 6

local optionSixToggleBox = display.newRect(890,710,50,50);
optionSixToggleBox:setReferencePoint(display.TopLeftReferencePoint);
optionSixToggleBox.alpha = minToggleBoxAlpha;
optionSixToggleBox.y = textYStart + textYSpacing * 6;
optionSixToggleBox.id = 7;

optionSixToggleBox.touch = onToggleTouch
optionSixToggleBox:addEventListener( "touch", optionSixToggleBox )


optionsMenu:insert(muteSoundText)
optionsMenu:insert(muteSoundToggleBox)
optionsMenu:insert(optionClockText)
optionsMenu:insert(optionClockToggleBox)
optionsMenu:insert(optionWanderText)
optionsMenu:insert(optionTwoToggleBox)
optionsMenu:insert(optionAutoDimText)
optionsMenu:insert(optionThreeToggleBox)
optionsMenu:insert(optionExtraThunderText)
optionsMenu:insert(optionFourToggleBox)
optionsMenu:insert(optionFiveToggleBox)
optionsMenu:insert(optionSleepTimerText)
optionsMenu:insert(optionSixToggleBox)
optionsMenu:insert(optionBlackAndWhiteText)
  
  optionsMenu.options = {
  {text = muteSoundText, toggle = "off", toggleBox = muteSoundToggleBox, extended = false},
  {text = optionClockText, toggle = "off", toggleBox = optionClockToggleBox, extended = false},
  {text = optionWanderText, toggle = "off", toggleBox = optionTwoToggleBox, extended = true},
  {text = optionAutoDimText, toggle = "off", toggleBox = optionThreeToggleBox, extended = true},
  {text = optionExtraThunderText, toggle = "off", toggleBox = optionFourToggleBox, extended = true},
  {text = optionSleepTimerText, toggle = "off", toggleBox = optionFiveToggleBox, extended = true},
  {text = optionBlackAndWhiteText, toggle = "off", toggleBox = optionSixToggleBox, extended = true},

}
  function optionsMenu:activate()
  	if (extendedPurchased == true) then 
      transition.to(self, {time = 500, alpha = 1.0})
    else 
        transition.to(self, {time = 500, alpha = 1.0})
        -- optionClockText.alpha = 0.2;
        -- muteSoundText.alpha = 0.2;
        optionWanderText.alpha = 0.2;
        optionAutoDimText.alpha = 0.2;
        optionExtraThunderText.alpha = 0.2;

      for i=1,#self.options do
        if (self.options[i]["extended"]) then
          self.options[i]["text"].alpha =0.2
        end
      end

    end
      self.activated = true;
  end

  function optionsMenu:activateOptions()
    -- transition.to(self, {time = 500, alpha = 1.0})
    optionClockText.alpha = 0.8
    muteSoundText.alpha = 0.8
    optionWanderText.alpha = 0.8
    optionAutoDimText.alpha = 0.8
    optionExtraThunderText.alpha = 0.8
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
    if (extendedPurchased == true) then
    print('toggle')
    	if (self.options[self.selection].toggle == "off") then
    		self.options[self.selection].toggle = "on"
        self.options[self.selection].toggleBox.alpha = 1.0;
     	else
     		self.options[self.selection].toggle = "off"
         self.options[self.selection].toggleBox.alpha = minToggleBoxAlpha;
     	end
    	
     	print(self.options[self.selection].toggle);
      else
        print("toggle blocked")
      end
  end

 
       
  return optionsMenu
        
end
 
return OptionsMenu

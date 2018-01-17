--OptionsMenu.lua
--A class for the main Just Rain options menu

module(..., package.seeall)

local OptionsMenu = {}
 
function OptionsMenu.new()
  
  local optionsMenu = display.newGroup();
  local bg = display.newRect(600,400,display.actualContentWidth,display.actualContentHeight)
  local minTextAlpha = 0.6;
  local minToggleBoxAlpha = 0.1;
  local textYStart = 100;
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
    if (event.phase == "began") then
    if (optionsMenu.options[self.id].toggle == "off") then
      optionsMenu.options[self.id].toggle = "on"
      optionsMenu.options[self.id].toggleBox.alpha = 1.0;
    else
      optionsMenu.options[self.id].toggle = "off"
       optionsMenu.options[self.id].toggleBox.alpha = minToggleBoxAlpha;
    end
  end
  end

local backPrompt = display.newGroup();

    -- backPrompt.alpha = 1.0;
    local backHotZone = display.newRect(display.screenOriginX, display.contentHeight - 200, 300, 200);
    backHotZone:setFillColor(255,255,255);
    backHotZone.alpha = 0.0;
    backHotZone.isHitTestable = true;

    -- local selectIcon = display.newImage("ouyaselect.png", 150,800)
    -- local selectText = display.newText("SELECT",200,789, "Knockout-HTF29-JuniorLiteweight", 40)
    local backIcon = display.newImage("amazonback.png",display.screenOriginX + 50,650)
    local backText = display.newText("BACK", display.screenOriginX + 100, 649, "Knockout-HTF29-JuniorLiteweight", 40)
  

 -- backPrompt.alpha = 1.0;
    local purchaseHotZone = display.newRect(display.actualContentWidth-300, display.contentHeight - 200, 300, 200);
    purchaseHotZone:setFillColor(255,255,255);
    purchaseHotZone.alpha = 0.0;
    purchaseHotZone.isHitTestable = true;
    if (extendedPurchased == true) then
purchaseHotZone.isHitTestable = false;
  end

    -- local selectIcon = display.newImage("ouyaselect.png", 150,800)
    -- local selectText = display.newText("SELECT",200,789, "Knockout-HTF29-JuniorLiteweight", 40)
    local purchaseIcon = display.newImage("amazonback.png",display.actualContentWidth - 215,650)
    local purchaseText = display.newText("PURCHASE EXTENDED FEATURES", display.actualContentWidth - 650, 649, "Knockout-HTF29-JuniorLiteweight", 40)
  

 if (extendedPurchased == true) then
purchaseIcon.alpha = 0;
purchaseText.alpha = 0;
end


   backPrompt:insert(backIcon);
    backPrompt:insert(backText);
    backPrompt:insert(backHotZone);
    backPrompt:insert(purchaseHotZone);
    backPrompt:insert(purchaseIcon);
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
  
  local muteSoundToggleBox = display.newRect(900,650,30,30);
  muteSoundToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  muteSoundToggleBox.alpha = minToggleBoxAlpha;
  muteSoundToggleBox.y = textYStart + 20;
  muteSoundToggleBox.id = 1;
   muteSoundToggleBox.touch = onToggleTouch
muteSoundToggleBox:addEventListener( "touch", muteSoundToggleBox )


  local optionClockText = display.newText("Clock", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionClockText:setReferencePoint(display.TopLeftReferencePoint);
  optionClockText.alpha = minTextAlpha;
  optionClockText.x = textXStart;
  optionClockText.y = textYStart + textYSpacing;
  
  local optionClockToggleBox = display.newRect(900,650,30,30);
  optionClockToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionClockToggleBox.alpha = minToggleBoxAlpha;
  optionClockToggleBox.y = textYStart + 20 + textYSpacing;
  optionClockToggleBox.id = 2;

  -- optionClockToggleBox:addEventListener()
  

  optionClockToggleBox.touch = onToggleTouch
optionClockToggleBox:addEventListener( "touch", optionClockToggleBox )

   local optionWanderText =  display.newText("Wander Mode (rain changes direction and intensity over time)", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionWanderText:setReferencePoint(display.TopLeftReferencePoint);
  optionWanderText.alpha = minTextAlpha;
    optionWanderText.x = textXStart;
  optionWanderText.y = textYStart + textYSpacing * 2


    local optionTwoToggleBox = display.newRect(900,670,30,30);
  optionTwoToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionTwoToggleBox.alpha = minToggleBoxAlpha;
  optionTwoToggleBox.y = textYStart + 20 + textYSpacing * 2;
  optionTwoToggleBox.id = 3

   optionTwoToggleBox.touch = onToggleTouch
optionTwoToggleBox:addEventListener( "touch", optionTwoToggleBox )

   local optionAutoDimText = display.newText("Auto-dim after 5 minutes of inactivity", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionAutoDimText:setReferencePoint(display.TopLeftReferencePoint);
  optionAutoDimText.alpha = minTextAlpha;
  optionAutoDimText.x = textXStart;
  optionAutoDimText.y = textYStart + textYSpacing * 3;

    local optionThreeToggleBox = display.newRect(900,690,30,30);
  optionThreeToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionThreeToggleBox.alpha = minToggleBoxAlpha;
   optionThreeToggleBox.y = textYStart + 20 + textYSpacing * 3;
   optionThreeToggleBox.id = 4
    optionThreeToggleBox.touch = onToggleTouch
optionThreeToggleBox:addEventListener( "touch", optionThreeToggleBox )

   local optionExtraThunderText = display.newText("Extra Thunder", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionExtraThunderText:setReferencePoint(display.TopLeftReferencePoint);
  optionExtraThunderText.alpha = minTextAlpha;
   optionExtraThunderText.x = textXStart;
  optionExtraThunderText.y = textYStart + textYSpacing * 4

    local optionFourToggleBox = display.newRect(900,710,30,30);
  optionFourToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionFourToggleBox.alpha = minToggleBoxAlpha;
  optionFourToggleBox.y = textYStart + 20 + textYSpacing * 4;
  optionFourToggleBox.id = 5;

   optionFourToggleBox.touch = onToggleTouch
optionFourToggleBox:addEventListener( "touch", optionFourToggleBox )

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
  
  optionsMenu.options = {
  {text = muteSoundText, toggle = "off", toggleBox = muteSoundToggleBox},
  {text = optionClockText, toggle = "off", toggleBox = optionClockToggleBox},
  {text = optionWanderText, toggle = "off", toggleBox = optionTwoToggleBox},
  {text = optionAutoDimText, toggle = "off", toggleBox = optionThreeToggleBox},
  {text = optionExtraThunderText, toggle = "off", toggleBox = optionFourToggleBox},

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

--OptionsMenu.lua
--A class for the main Just Rain options menu

module(..., package.seeall)

local OptionsMenu = {}
 
function OptionsMenu.new()
  
  local optionsMenu = display.newGroup();
  local bg = display.newRect(600,400,1400,400)
  local minTextAlpha = 0.6;
  local minToggleBoxAlpha = 0.1;
  local textYStart = 300;
  local textYSpacing = 50;
  local textXStart = 400;
  bg:setReferencePoint(display.centerReferencePoint);
  bg.x = display.contentCenterX
  bg.y = display.contentCenterY - 125;
  bg:setFillColor(0,0,0,255)
  bg.alpha = 0.8;
  optionsMenu:insert(bg);
  optionsMenu.alpha = 0;
  optionsMenu.activated = false;
  optionsMenu.selection = 1;

local backPrompt = display.newGroup();
    -- backPrompt.alpha = 1.0;

    local donateIcon = display.newImage("ouyadonate.png", 150,750)
    local donateText = display.newText("DONATE $0.99",200,750, "Knockout-HTF29-JuniorLiteweight", 40)

    local selectIcon = display.newImage("ouyaselect.png", 150,800)
    local selectText = display.newText("SELECT",200,800, "Knockout-HTF29-JuniorLiteweight", 40)

    local backIcon = display.newImage("ouyaback.png",150,850)
    local backText = display.newText("BACK", 200, 850, "Knockout-HTF29-JuniorLiteweight", 40)

    backPrompt:insert(backIcon);
    backPrompt:insert(backText);
    backPrompt:insert(selectIcon);
    backPrompt:insert(selectText)
    backPrompt:insert(donateIcon);
    backPrompt:insert(donateText);
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
  optionClockToggleBox.y = textYStart + 20;

   local optionWanderText =  display.newText("Wander Mode (rain changes direction and intensity over time)", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionWanderText:setReferencePoint(display.TopLeftReferencePoint);
  optionWanderText.alpha = minTextAlpha;
    optionWanderText.x = textXStart;
  optionWanderText.y = textYStart + textYSpacing

    local optionTwoToggleBox = display.newRect(1510,670,30,30);
  optionTwoToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionTwoToggleBox.alpha = minToggleBoxAlpha;
  optionTwoToggleBox.y = textYStart + 20 + textYSpacing;

   local optionAutoDimText = display.newText("Auto-dim after 5 minutes of inactivity", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionAutoDimText:setReferencePoint(display.TopLeftReferencePoint);
  optionAutoDimText.alpha = minTextAlpha;
  optionAutoDimText.x = textXStart;
  optionAutoDimText.y = textYStart + textYSpacing * 2;

    local optionThreeToggleBox = display.newRect(1510,690,30,30);
  optionThreeToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionThreeToggleBox.alpha = minToggleBoxAlpha;
   optionThreeToggleBox.y = textYStart + 20 + textYSpacing * 2;

   local optionExtraThunderText = display.newText("Extra Thunder", 1450, 650, "Knockout-HTF29-JuniorLiteweight", 40)
  optionExtraThunderText:setReferencePoint(display.TopLeftReferencePoint);
  optionExtraThunderText.alpha = minTextAlpha;
   optionExtraThunderText.x = textXStart;
  optionExtraThunderText.y = textYStart + textYSpacing * 3;

    local optionFourToggleBox = display.newRect(1510,710,30,30);
  optionFourToggleBox:setReferencePoint(display.TopLeftReferencePoint);
  optionFourToggleBox.alpha = minToggleBoxAlpha;
  optionFourToggleBox.y = textYStart + 20 + textYSpacing * 3;

  optionsMenu:insert(optionClockText)
  optionsMenu:insert(optionClockToggleBox)
  optionsMenu:insert(optionWanderText)
  optionsMenu:insert(optionTwoToggleBox)
  optionsMenu:insert(optionAutoDimText)
  optionsMenu:insert(optionThreeToggleBox)
  optionsMenu:insert(optionExtraThunderText)
  optionsMenu:insert(optionFourToggleBox)
  
  optionsMenu.options = {
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

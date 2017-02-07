--Clock.lua
--A class for the clock object in Just Rain

module(..., package.seeall)

local Clock = {}
 
function Clock.new()
  
  local clock = display.newGroup();
  local dateDisplay = display.newText("Monday January 1", 1820,800, "Knockout-HTF29-JuniorLiteweight", 60);
  local timeDisplay = display.newText("12:00 PM", 1820, 980, "Knockout-HTF29-JuniorLiteweight", 160)
  timeDisplay:setReferencePoint(display.bottomRightReferencePoint)
  timeDisplay.x = 1520;
  timeDisplay.y = 880;
  dateDisplay:setReferencePoint(display.bottomRightReferencePoint)
  dateDisplay.x = 1490;
  dateDisplay.y = 780;
  local maxAlpha = 0.75;

  
  clock:insert(timeDisplay);
  clock:insert(dateDisplay)
  local date = string.upper(os.date("%A %B %d"))
  dateDisplay.text = date;
  function clock:update(onOrOff)
    -- print(onOrOff)
    if (onOrOff == "on") then
      clock.alpha = maxAlpha;
    else
      clock.alpha = 0.0;
    end

    local hour = os.date( "%I" )    -- returns table of date & time values
    if (tonumber(hour) < 10) then
        hour = hour:sub(2) 
    end
    local minute = os.date("%M %p")
    
    
    timeDisplay.text = hour..":"..minute;
  end

  return clock
        
end
 
return Clock

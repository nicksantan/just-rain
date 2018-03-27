local FPSCalculator = {}
FPSCalculator.__index = FPSCalculator

--- Private functions --------------

function FPSCalculator:calculateFPS()
            
    self.frameCounter = self.frameCounter + 1
    local currentTimestampMs = system.getTimer()
        
    if (not self.lastCalculationTimestampMs) then
        self.lastCalculationTimestampMs = currentTimestampMs
    end
        
    local deltaTimeMs = currentTimestampMs - self.lastCalculationTimestampMs
    
    -- Calculate average fps for the specified time period    
    if ( deltaTimeMs >= self.timeBetweenCalculationsMs ) then        
        local fps = self.frameCounter / (deltaTimeMs / 1000) 
          print(fps)
        self.frameCounter = 0
        self.lastCalculationTimestampMs = currentTimestampMs
        
        local fpsRatio = fps/display.fps
      
        if ((not self.fpsRatioWarningThreshold) or (fpsRatio <= self.fpsRatioWarningThreshold)) then
            self.callback(fps, fpsRatio)
        end
    end
end

--- Public functions --------------

function FPSCalculator:start()    
    if (self.isStarted) then
        return
    end
    
    -- Reset some state
    self.isStarted = true
    self.frameCounter = 0
    self.lastCalculationTimestampMs = nil
    
    -- Setup the calculation function
    self.calculationFunction = function() self:calculateFPS() end
    Runtime:addEventListener("enterFrame", self.calculationFunction)
end

function FPSCalculator:stop()
    self.isStarted = false,
    Runtime:removeEventListener("enterFrame", self.calculationFunction)
end

--[[
callback(fps, fpsRatio) - Required. A callback function with params:
  fps - The average frame rate during the last calculation period
  fpsRatio - The ratio between actual fps and target fps (fps/display.fps)  
params - Optional table of configuration params. The following params are allowed and are optional.
  timeBetweenCalculationsMs - How often to calculate fps. Default = 1000 ms.
  fpsRatioWarningThreshold - A number between 0-1. If specified, the callback will only be called if fpsRatio drops below this threshold number.
  
--]]
function FPSCalculator.new(callback, params) 
    
    params = params or {}
    
    local newCalculator = {
        isStarted = false,
        frameCounter = 0,
        lastCalculationTimestampMs = nil,
        calculationFunction = nil, -- Will be set when start() is called
        
        callback = callback,
        timeBetweenCalculationsMs = params.timeBetweenCalculationsMs or 1000,
        fpsRatioWarningThreshold = params.fpsRatioWarningThreshold,        
    }
    
    setmetatable(newCalculator, FPSCalculator)    
    
    return newCalculator    
end


return FPSCalculator
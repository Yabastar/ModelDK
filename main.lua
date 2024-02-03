local Pine3D = require("/Pine3D")
local PrimeUI = require("/PrimeUI")

local ThreeDFrame = Pine3D.newFrame()
ThreeDFrame:setCamera(-1, 0, -1, 0, 45, -45)

local objects = {}

-- create a grid of boxes with the specified grid size
local size = 3
for x = 1, size do
  for y = 1, size do
    for z = 1, size do
      objects[#objects+1] = ThreeDFrame:newObject("models/box", x, y-size*2, z)
    end
  end
end

local function main()
	while true do
	  -- render the scene
	  ThreeDFrame:drawObjects(objects)
	  ThreeDFrame:drawBuffer()
	
	  -- wait for user input
	  local event, key, x, y = os.pullEvent()
		
	  -- check if the event was a click
	  if event == "mouse_click" then
	    -- pass the rendered objects with the coordinates of the clicked pixel
	    local objectIndex, polyIndex = ThreeDFrame:getObjectIndexTrace(objects, x, y)
	    if objectIndex then -- check if an object was clicked
		clicked = [objectIndex,polyIndex]
	    end
	  end
	end
end

local function ui()
	PrimeUI.clear()
	PrimeUI.borderBox(term.current(), 4, 6, 40, 10)
end

parallel.waitForAny(main,ui)

local elementX, elementY, elementZ

local arrow = nil

function createArrowPos(theElement)
	if (isElement(theElement)) then
		elementX, elementY, elementZ = getElementPosition(theElement)
		destroyArrow()
		createArrow()
	end
end

function createArrow()
	local px, py, pz = getElementPosition(localPlayer)
	arrow = createObject(1318, px, py, pz)
	setElementCollisionsEnabled(arrow, false)
	addEventHandler("onClientRender", root, rotArrow)
end

function destroyArrow()
	if (isElement(arrow)) then
		destroyElement(arrow)
		removeEventHandler("onClientRender", root, rotArrow)
	end
end

function rotArrow()
	local px, py, pz = getElementPosition(localPlayer)
	if (px ~= nil and py ~= nil and pz ~= nil) then
		local rot = findRotation(px, py, elementX, elementY)
		setElementPosition(arrow, px, py, pz + 1)
		setElementRotation(arrow, 0, 90, rot)
	end
end

function findRotation(x1, y1, x2, y2)
  local X = math.abs(x2 - x1)
  local Y = math.abs(y2 - y1)
  Rotm = math.deg(math.atan2(Y, X))
  if x1 <= x2 and y1 < y2 then
    Rotm = 90 - Rotm
  elseif x2 <= x1 and y1 < y2 then
    Rotm = 270 + Rotm
  elseif x1 <= x2 and y2 <= y1 then
    Rotm = 90 + Rotm
  elseif x2 < x1 and y2 <= y1 then
    Rotm = 270 - Rotm
  end
  return 630 - Rotm
end
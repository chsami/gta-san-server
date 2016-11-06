function getListItem(i, gridlist)
	if (gridlist == nil) then
		if (guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), i ) ~= "") then
			local item = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1] ), i )
			return item
		end
	else
		if (guiGridListGetItemText ( GUIEditor.gridlist[gridlist], guiGridListGetSelectedItem ( GUIEditor.gridlist[gridlist] ), i ) ~= "") then
			local item = guiGridListGetItemText ( GUIEditor.gridlist[gridlist], guiGridListGetSelectedItem ( GUIEditor.gridlist[gridlist] ), i )
			return item
		end
	end
	return nil
end


function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

local px, py, pz = nil
local vx, vy, vz = nil
local distanceFromVehicle = nil
local carBlip = nil
local loginName = nil
local valueElement = nil

function resetLineVariables()
	px, py, pz = nil
	vx, vy, vz = nil
	destroyElement(carBlip)
end

function handleDrawDXLine()
	if (isLoggedIn()) then
		px, py, pz = getElementPosition(localPlayer)
		vx, vy, vz = getElementPosition(valueElement)
		distanceFromVehicle = getDistanceBetweenPoints3D ( px, py, pz, vx, vy, vz )
		if (distanceFromVehicle >= 15) then
			dxDrawLine3D ( px, py, pz, vx, vy , vz, tocolor ( 0, 255, 0, 220 ))
		else
			handleHideLine()
		end
	end
end

function handleShowLine(_, theElement)
	if (source == localPlayer) then
		if (vz == nil) then
			if (isLoggedIn()) then
				valueElement = theElement
				vx, vy, vz = getElementPosition(valueElement)
				--vx = x
				--vy = y
				--vz = z
				carBlip = createBlip(vx, vy, vz, 19)
				addEventHandler("onClientRender", root, handleDrawDXLine)
			end
		else
			handleHideLine()
		end
	end
end
addEvent("showLine", true)
addEventHandler("showLine", localPlayer, handleShowLine)

function handleHideLine()
	removeEventHandler("onClientRender", root, handleDrawDXLine)
	resetLineVariables()
end

function getLoginFromServer(_, name)
	if (source == localPlayer) then
		if (name ~= nil) then
			loginName = name
		end
	end
end

addEvent("loginName", true)
addEventHandler("loginName", localPlayer, getLoginFromServer)

function getLoginName()
	return loginName
end

function resetDimension()
	if (getElementDimension(localPlayer) > 0) then
		setElementDimension(localPlayer, 0)
	end
end

function randomFloat(min, max, precision)
   local range = max - min
   local offset = range * math.random()
   local unrounded = min + offset

   if not precision then
      return unrounded
   end

   local powerOfTen = 10 ^ precision
   return math.floor(unrounded * powerOfTen + 0.5) / powerOfTen
end


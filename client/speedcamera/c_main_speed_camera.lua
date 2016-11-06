local camera_1 = createObject(1622, 1149.5, -1384, 18.7)
local camera_2 = createObject(1622, 1321.5, -1561.9, 18.3)

local speed_col_1 = createColRectangle ( 1071, -1409, 100, 20)
local speed_col_2 = createColRectangle ( 1291, -1695, 30, 150)

exports.customblips:createCustomBlip ( 1144, -1389, 15, 15, "conf/images/blips/speedcamera.png" )
exports.customblips:createCustomBlip ( 1318, -1544, 15, 15, "conf/images/blips/speedcamera.png" )
local speedTicket = false

function getSpeedTicket()
	return speedTicket
end


function setSpeedTicket(par_speedTicket)
	speedTicket = par_speedTicket
end

function checkSpeed()
	if not (getSpeedTicket()) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		if (vehicle) then
			local speedx, speedy, speedz = getElementVelocity ( vehicle )
					 
			-- use pythagorean theorem to get actual velocity
			-- raising something to the exponent of 0.5 is the same thing as taking a square root.
			local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
			 
			-- multiply by 50 to obtain the speed in metres per second
			local mps = actualspeed * 50
			 
			-- other useful conversions
			-- kilometres per hour
			--Font size resolution bug & Posx, posY
			local kmh = math.floor(actualspeed * 180)
			if (kmh > 100) then
				outputChatBox("You've got a speed ticket of 5000$ for going over 100 km/h", 255, 0, 0)
				setSpeedTicket(true)
				fadeCamera(false, 0.5, 255, 255, 255)
				triggerServerEvent("paySpeedTicket", localPlayer)
				setTimer(function()
					fadeCamera(true, 0.5, 255, 255, 255)
					setSpeedTicket(false)
				end, 250, 1)
			end
		end
	end
end


function addGlassParticle(r,g,b,a,scale,count)
	local x,y,z = getElementPosition(localPlayer)
         fxAddGlass(x,y,z,250,250, 250, 250,2,1)
end
addCommandHandler("addGlass",addGlassParticle)

addCommandHandler("debris", function()
    local x, y, z = getElementPosition(localPlayer)
    local randomColor, randomAmount = math.random(0, 255), math.random(4, 8)
    fxAddDebris(x, y, z, randomColor, randomColor, randomColor, 255, 1.0, randomAmount)
end)


addEventHandler("onClientColShapeHit", speed_col_1, checkSpeed)
addEventHandler("onClientColShapeHit", speed_col_2, checkSpeed)
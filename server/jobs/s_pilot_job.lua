local pilote_vehicle_marker = createMarker ( 1981, -2628, 12.5, "cylinder", 6, 50, 200, 0, 200)

local passengers_marker_1 = createMarker ( 2064, -2591, 12.5, "cylinder", 6, 255, 0, 0, 80)
local passengers_marker_2 = createMarker ( 2074, -2493, 12.5, "cylinder", 6, 255, 0, 0, 80)

local destination_marker_1 = createMarker ( -1253, -45, 13, "cylinder", 6, 255, 0, 0, 80)

local destination_marker_2 = createMarker ( 803, 1139, 27, "cylinder", 6, 255, 0, 0, 80)

local destination_marker_3 = createMarker ( 1537, 1468, 9.60, "cylinder", 6, 255, 0, 0, 80)

local posX = {-1253, 803, 1537}
local posY = {-45, 1139, 1468}
local posZ = {13, 27, 9.60}

local distance = {}

function calculateFlightDistance(p)
	if (isElement(p)) then
		local x, y, z = getElementPosition(p)
		for i=1, 3 do
			distance[i] = round(getDistanceBetweenPoints3D(x,y,z,posX[i],posY[i],posZ[i]), 0)
		end
	end
end

function isInPlane(p)
	if (isElement(p)) then
		if (getPedOccupiedVehicle(p)) then
			local vehicle = getElementModel(getPedOccupiedVehicle(p))
			if (vehicle == 593 or vehicle == 511 or vehicle == 519 or vehicle == 577) then
			return true
			end
		end
	end
	return false
end


function handlePassengersMarker_1(p)
	if (isElement(p)) then
		if (isLoggedIn(p)) then
			if (isInPlane(p)) then
				if (getElementData(p, "load_passengers") == "passengers") then
					setElementFrozen(getPedOccupiedVehicle(p), true)
					outputChatBox("Loading passengers...", p)
					setElementData(p, "load_passengers", "hold")
					setTimer(function()
						outputChatBox("passengers succesfully loaded, move on to the next check!", p)
						setElementData(p, "load_passengers", "passengers_2")
						setElementFrozen(getPedOccupiedVehicle(p), false)
						calcPassengers(p)
					end, 5000, 1)
				else
					triggerClientEvent(p, "notificationMessage", p, drawNotificationMessage, "You already loaded your passengers")
				end
			end
		end
	end
end

function handlePassengersMarker_2(p)
	if (isElement(p)) then
		if (isLoggedIn(p)) then
			if (isInPlane(p)) then
				if (getElementData(p, "load_passengers") == "passengers_2") then
					calculateFlightDistance(p)
					triggerClientEvent("showFlightInformation", p, showFlightDestinations, distance)
					setElementFrozen(getPedOccupiedVehicle(p), true)
					outputChatBox("Loading passengers...", p)
					setElementData(p, "load_passengers", "hold")
					setTimer(function()
						outputChatBox("passengers succesfully loaded, you are ready to take up!", p)
						setElementFrozen(getPedOccupiedVehicle(p), false)
						setElementData(p, "load_passengers", "Take-off")
						calcPassengers(p)
					end, 5000, 1)
				else
					triggerClientEvent(p, "notificationMessage", p, drawNotificationMessage, "You have to load from the first checkPoint")
				end
			end
		end
	end
end

function handleDestinationMarker_1(p)
	if (isElement(p)) then
		if (isLoggedIn(p)) then
			if (isInPlane(p)) then
				if (getElementData(p, "load_passengers") == "Take-off" and getElementData(p, "total_passengers") > 0) then
						calcProfit(p, distance[1])
				end
			end
		end
	end
end

function handleDestinationMarker_2(p)
	if (isElement(p)) then
		if (isLoggedIn(p)) then
			if (isInPlane(p)) then
				if (getElementData(p, "load_passengers") == "Take-off" and getElementData(p, "total_passengers") > 0) then
						calcProfit(p, distance[2])
				end
			end
		end
	end
end

function handleDestinationMarker_3(p)
	if (isElement(p)) then
		if (isLoggedIn(p)) then
			if (isInPlane(p)) then
				if (getElementData(p, "load_passengers") == "Take-off" and getElementData(p, "total_passengers") > 0) then
						calcProfit(p, distance[3])
				end
			end
		end
	end
end

function handlePilotVehicleMarker(p)
	if (isElement(p)) then
		if (isLoggedIn(p)) then
			if (getElementType(p) == "player") then
				if not (getPedOccupiedVehicle(p)) then
					if (source == pilote_vehicle_marker) then
						if (getCurrentJob(p) == "pilot") then
							triggerClientEvent(p, "createSpawnVehiclesGui", p, createSpawnVehiclesGui, "Dodo", "Beagle", "Shamal", "AT400")
						else
							triggerClientEvent(p, "notificationMessage", p, drawNotificationMessage, "You have to be a pilot to work here!")
						end
					end
				end
			end
		end
	end
end

function calcPassengers(thePlayer)
	local passenger_counter = 0
	local calc_passengers = math.random(1, 100) --for now we do this random, later on we see how big the plane is and how many people can fit in it TODO
	local passenger_counter = passenger_counter + calc_passengers + tonumber(getElementData(thePlayer, "total_passengers"))
	setElementData(thePlayer, "total_passengers", passenger_counter)
	outputChatBox("You managed to board " ..passenger_counter.. " people on the plane!", thePlayer)
end

function calcProfit(thePlayer, cmdName, distance)
	local profit = getPilotSalary() * getElementData(thePlayer, "total_passengers") + (distance/2)
	local pilotPoint = getJobAttribute(thePlayer, "pilot", getJobExperienceIndex())
	pilotPoint = pilotPoint + 1
	outputChatBox("You started unloading the passengers...", thePlayer)
	setElementFrozen(getPedOccupiedVehicle(thePlayer), true)
	setTimer(function()
		givePlayerMoney(thePlayer, profit)
		setElementData(thePlayer,"total_passengers", 0)
		setElementData(thePlayer, "load_passengers", "passengers")
		setJobAttribute(thePlayer, "pilot", getJobExperienceIndex(), pilotPoint)
		setElementFrozen(getPedOccupiedVehicle(thePlayer), false)
		outputChatBox("Congratulations you made " ..profit.."$ and +1 pilot point!", thePlayer, 255, 0, 0)
		destroyTempVehicle(thePlayer)
	end, 5000, 1)
	setTimer(function()
		setElementPosition(thePlayer, 1922, -2669, 13.7)
	end, 6000, 1)
end



addCommandHandler("plane", calcProfit)


--SERVER EVENTS--

addEventHandler( "onMarkerHit", pilote_vehicle_marker, handlePilotVehicleMarker )
addEventHandler( "onMarkerHit", passengers_marker_1, handlePassengersMarker_1 )
addEventHandler( "onMarkerHit", passengers_marker_2, handlePassengersMarker_2 )
addEventHandler( "onMarkerHit", destination_marker_1, handleDestinationMarker_1 )
addEventHandler( "onMarkerHit", destination_marker_2, handleDestinationMarker_2 )
addEventHandler( "onMarkerHit", destination_marker_3, handleDestinationMarker_3 )
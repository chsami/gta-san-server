--Taxi job not for players only for NPCS


local taxi_is_ready = false
local taxi_timer = 17
local seat = 1
local taxi_players


local destinations_price = {["LS-Airport"] = 200, ["Countryside"] = 200}
local destination = {
	name = { }
}


local taxi_1_man = createPed(7, 1269, -1313, 13.6)
setElementRotation ( taxi_1_man, 369,-4.7, 810)
function startTaxi_man_anim()
	setElementPosition(taxi_1_man, 1269, -1313, 13.6)
	setElementRotation ( taxi_1_man, 369,-4.7, 810)
	local counter = 0
	local theTimer = nil
	theTimer = setTimer(function()
		if not (isPedInVehicle(taxi_1_man)) then
			if (counter == 0) then
				setPedAnimation(taxi_1_man, "SMOKING", "M_smkstnd_loop", -1, true, false, false, true)
				counter = counter + 1
			elseif(counter == 1) then
				setPedAnimation(taxi_1_man, "SMOKING", "M_smklean_loop", -1, true, false, false, true)
				counter = counter + 1
			else
				setPedAnimation(taxi_1_man, "SMOKING", "M_smk_tap", -1, true, false, false, true)
				counter = 0
			end
		else
			killTimer(theTimer)
		end
	end, 6000, 0)
end


local taxi_1 = createVehicle( 420, 1266, -1316, 13.45)
setVehicleDamageProof(taxi_1, true)
function moveTaxi(x, y, z , move)
	if (taxi_1) then
		setVehicleEngineState(taxi_1, true)
		isVehicleDamageProof ( taxi_1 , true)
		setElementFrozen(taxi_1, false)
		theTimer = setTimer(function()
			if (taxi_1) then
				setElementVelocity ( taxi_1, x, y, z )
			else
				setElementFrozen(taxi_1, true)
				killTimer(theTimer)
			end
		end, 200, 20)
	end
end


local taxi_1_marker = createMarker(1266, -1310, 14.5, "arrow", 2, 255, 0, 0, 150)

local player_destination = {}

local taxi_display = nil
local taxi_display_item = nil





function handleTaxiTimer()
	startTaxi_man_anim()
	setElementFrozen(taxi_1, true)
	destination.name["LS-Airport"] = {
		x = 1694,
		y = -2321,
		z = 13.8
	}
	destination.name["Countryside"] = {
		x = -1053,
		y = -1248,
		z = 128.4
	}
	taxi_players = createTeam ( "taxi_players")
	local theTimer = nil
	theTimer = setTimer(function()
		if (taxi_timer == 5) then
			warpPedIntoVehicle(taxi_1_man, taxi_1, 0)
			taxi_timer = taxi_timer - 1
		elseif (taxi_timer > 0) then
			taxi_timer = taxi_timer - 1
		else
			taxi_timer = 100
			depart()
		end
	end, 500, 0)
end


function handleTaxi1Marker(hitElement)
	if (isElement(hitElement) and isLoggedIn(hitElement) and getElementType(hitElement) == "player")  then
		triggerClientEvent(hitElement, "showTaxiDestInterface", hitElement, drawTaxiDestinationInterface)
	end
end

function handlePlayerTravelTaxi(destination , price)
	if (client == source) then
		if (destinations_price[destination] == price) then
			if (getPlayerMoney(client) >= price) then
				if (seat < 3) then
					player_destination[client] = destination
					warpPedIntoVehicle(client, taxi_1, seat )
					seat  = seat + 1
					setPlayerTeam ( client, taxi_players) -- add the player to the new team
					addTextItem(client)
					updateTaxiTimer(client)
					takePlayerMoney(client, price)
					outputChatBox("You payed the taxi driver $" ..price.." and stepped into the car.", client, 0, 150, 150)
				else
					outputChatBox("Taxi is full!", client, 255, 0, 0)
				end
			else
				outputChatBox("You need atleast $" ..price.." to travel to : " ..destination, client, 255, 0, 0)
			end
		else
			outputChatBox("Cheat detected", client)
		end
	end
end


function depart()
	local players = getPlayersInTeam ( taxi_players )
	for i = 1, #players do
		startTaxiTour(players[i])
	end
end

function handleTaxiTourPlayer(p, count)
	if (isElement(p) and isLoggedIn(p)) then
		if (isPedInVehicle(p)) then
			local vehicle = nil
			vehicle = getPedOccupiedVehicle(p)
			setTimer(function()
			if (vehicle == taxi_1 and count == 0) then
				fadeCamera(p, true, 5)
				outputChatBox("We have reached LS-AIRPORT...", p)
				textItemSetText(taxi_display_item, "Location : LS-AIRPORT")
			end
			end, 2500, 1)
			if (count == 1) then
				if (vehicle == taxi_1) then
					fadeCamera(p, true, 3)
					outputChatBox("We have reached the Countryside...", p)
					textItemSetText(taxi_display_item, "Location : Countryside")
				end
			elseif(count == 2) then
				if (vehicle == taxi_1) then
					fadeCamera(p, true, 3)
					outputChatBox("We have reached Los Santos...", p)
					textItemSetText(taxi_display_item, "Location : Los Santos")
				end
			elseif(count == 3) then
				if (vehicle == taxi_1) then
					fadeCamera(p, true, 3)
					resetPlayerTaxiAttributes(p)
					removePedFromVehicle ( p )
					removePedFromVehicle(taxi_1_man)
					setElementPosition(p, 1274, -1314, 13.6)
					startTaxi_man_anim()
				end
			end
		end
	end
end

function handlePlayerFading(p)
	if (isElement(p) and isLoggedIn(p)) then
		if (isPedInVehicle(p)) then
			local fTimer = nil
			fTimer = setTimer(function()
				vehicle = getPedOccupiedVehicle(p)
				if (vehicle == taxi_1) then
						fadeCamera(p, false, 3)
				else
					killTimer(fTimer)
					outputChatBox("fading timer killed!", p)
				end
			end, 9000, 0)
		end
	end
end

function startTaxiTour(p)
	if (p ~= nil and isElement(p)) then
		fadeCamera(p, false, 2)
		handleTaxiTourPlayer(p, 0)
		handlePlayerFading(p)
		triggerClientEvent(p,"setElementGhostModeOn", p, setElementGhostModeOn)
		setTimer(function()
			local count = 0
			local theTimer = nil
			setElementPosition(taxi_1, destination.name["LS-Airport"].x, destination.name["LS-Airport"].y, destination.name["LS-Airport"].z)
			setElementRotation ( taxi_1, 0, 0, 990)
			count = count + 1
			moveTaxi(0.12, 0, 0, true)
			theTimer = setTimer(function()
				if (count == 1) then
					handleTaxiTourPlayer(p, count)
					setElementPosition(taxi_1, destination.name["Countryside"].x, destination.name["Countryside"].y, destination.name["Countryside"].z)
					setElementRotation ( taxi_1, 0, 0, 1080)
					count = count + 1
					moveTaxi(0, 0.12, 0, true)
				elseif (count == 2) then
					handleTaxiTourPlayer(p, count)
					setElementPosition(taxi_1, 1266, -1360, 13.6)
					count = count + 1
					moveTaxi(0, 0.12, 0, true)
				elseif (count == 3) then
					handleTaxiTourPlayer(p, count)
					count = 0
					seat = 1
					--moveTaxi(0, 0.1, 0, false)
					killTimer(theTimer)
				end
			end, 10000, 0)
		end, 2000, 1)
	end
end

addEvent("playerTravelTaxi", true)

addEventHandler("onMarkerHit", taxi_1_marker, handleTaxi1Marker)


function resetPlayerTaxiAttributes(p)
	if (isElement(p) and isLoggedIn(p)) then
		player_destination[p] = nil
		if (seat > 1) then
		seat = seat - 1
		end
		setPlayerTeam(p, nil)
		deleteTextItem(p)
		fadeCamera(p, true, 3)
	end
end

function handleExitTaxi(p)
	if (isElement(p) and isLoggedIn(p)) then
		resetPlayerTaxiAttributes(p)
	end
end


function handleEnterTaxi(p)
	if (isElement(p) and isLoggedIn(p)) then
		if (getElementModel(source) == getElementModel(taxi_1)) then
			outputChatBox("This vehicle is locked.", p, 255, 0, 0)
			cancelEvent()
		end
	end
end

function deleteTextItem(p)
	if (isElement(p)) then
		if (taxi_display ~= nil and taxi_display ~= nil) then
			textDisplayRemoveObserver ( taxi_display, p )
			textDisplayRemoveText ( taxi_display, taxi_display_item )
			taxi_display = nil
			taxi_display_item = nil
		end
	end
end


function addTextItem(p)
	if (isElement(p)) then
		if not (taxi_display) then
			-- Create a text display.
			taxi_display = textCreateDisplay ()
			-- Add a player as an observer, i.e. this player will see all text items that are on this display
			textDisplayAddObserver ( taxi_display, p )
			-- Create a new text item with the text 'Hello World' and a priority of 'low' and colored red.
			taxi_display_item = textCreateTextItem ( "Taxi departure : " ..taxi_timer, 0.7, 0.7, "medium", 255, 255, 255, 200, 2, "left", "top", 255)
			-- Add the newly created text item to the display
			textDisplayAddText ( taxi_display, taxi_display_item )
		end
	end
end

function updateTaxiTimer(p)
	if (isElement(p) and isLoggedIn(p)) then
		local vehicle = nil
		local theTimer = nil
		theTimer = setTimer(function()
			 vehicle = getPedOccupiedVehicle(p)
			if (taxi_timer > 0 and vehicle == taxi_1) then
				textItemSetText(taxi_display_item, "Taxi departure : " ..taxi_timer)
			else
				killTimer(theTimer)
			end
		end, 600, 0)
	end
end

addEventHandler("onVehicleExit", taxi_1, handleExitTaxi)
addEventHandler("onVehicleStartEnter", taxi_1, handleEnterTaxi)
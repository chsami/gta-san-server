
function playerConnect()
	fadeCamera(source, true)
	setCameraMatrix(source,math.random (0,3000),math.random (-1000,1000),80.3,2770.2, -2437.6, 13.6)
end




function startWorld()
	logoutAll()
	outputChatBox("World started succesfully...")
	setGameSpeed ( 4 ) --1.3
	handleTaxiTimer()
	local column = "CREATE TABLE IF NOT EXISTS servername_players (userid INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, x INTEGER, y INTEGER, z INTEGER, dimension INTEGER, interior INTEGER, skin INTEGER, cocaine INTEGER, pota_salt INTEGER, hydro_acid INTEGER, money INTEGER, crack_produced INTEGER, water_bottles INTEGER, crack_created INTEGER, police_level INTEGER, farmer_level INTEGER, criminal_level INTEGER, pilot_level INTEGER, police_experience INTEGER, farmer_experience INTEGER, criminal_experience INTEGER, pilot_experience INTEGER, weaponSlot0 INTEGER, weaponSlot1 INTEGER, weaponSlot2 INTEGER, weaponSlot3 INTEGER, weaponSlot4 INTEGER, weaponSlot5 INTEGER, weaponSlot6 INTEGER, weaponSlot7 INTEGER, weaponSlot8 INTEGER, weaponSlot9 INTEGER, weaponSlot10 INTEGER, weaponSlot11 INTEGER, weaponAmmo0 INTEGER, weaponAmmo1 INTEGER, weaponAmmo2 INTEGER, weaponAmmo3 INTEGER, weaponAmmo4 INTEGER, weaponAmmo5 INTEGER, weaponAmmo6 INTEGER, weaponAmmo7 INTEGER, weaponAmmo8 INTEGER, weaponAmmo9 INTEGER, weaponAmmo10 INTEGER, weaponAmmo11 INTEGER, jail_timer INTEGER, health INTEGER, stamina INTEGER, muscles INTEGER, permit_car INTEGER, permit_fight INTEGER, permit_fly INTEGER, permit_life INTEGER, permit_store INTEGER, wantedLevel INTEGER, friends TEXT, job_name TEXT, vehicle_penalty INTEGER, criminal_cooldown INTEGER, materials INTEGER, crafted_materials INTEGER)"
	local updateColumn = "INSERT INTO servername_players (username, x, y , z, dimension, interior, skin, cocaine, pota_salt, hydro_acid, money, crack_produced, water_bottles, crack_created, police_level, farmer_level, criminal_level, pilot_level, police_experience, farmer_experience, criminal_experience, pilot_experience, weaponslot0, weaponslot1, weaponslot2, weaponslot3, weaponslot4, weaponslot5, weaponslot6, weaponslot7, weaponslot8, weaponslot9, weaponslot10, weaponslot11, weaponAmmo0, weaponAmmo1, weaponAmmo2, weaponAmmo3, weaponAmmo4, weaponAmmo5, weaponAmmo6, weaponAmmo7, weaponAmmo8, weaponAmmo9, weaponAmmo10, weaponAmmo11, jail_timer, health, stamina, muscles, permit_car, permit_fight, permit_fly, permit_life, permit_store, wantedLevel, friends, job_name, vehicle_penalty, criminal_cooldown, materials, crafted_materials) SELECT username, x , y, z, dimension, interior, skin, cocaine, pota_salt, hydro_acid, money, crack_produced, water_bottles, crack_created, police_level, farmer_level, criminal_level, pilot_level, police_experience, farmer_experience, criminal_experience, pilot_experience, weaponslot0, weaponslot1, weaponslot2, weaponslot3, weaponslot4, weaponslot5, weaponslot6, weaponslot7, weaponslot8, weaponslot9, weaponslot10, weaponslot11, weaponAmmo0, weaponAmmo1, weaponAmmo2, weaponAmmo3, weaponAmmo4, weaponAmmo5, weaponAmmo6, weaponAmmo7, weaponAmmo8, weaponAmmo9, weaponAmmo10, weaponAmmo11, jail_timer, health, stamina, muscles,permit_car, permit_fight, permit_fly, permit_life, permit_store, wantedLevel, friends, job_name, vehicle_penalty, criminal_cooldown, materials, crafted_materials FROM TempOldTable"
	local tableCreation = executeSQLQuery(column)
	local checkTableCreation = executeSQLQuery("SELECT * FROM sqlite_master WHERE name ='servername_players' and type='table'")
	if next(checkTableCreation) then --check if the table has something in it
		executeSQLQuery("ALTER TABLE servername_players RENAME TO TempOldTable")
		executeSQLQuery(column)
		executeSQLQuery(updateColumn)
		executeSQLQuery("DROP TABLE TempOldTable")
	else
		outputChatBox("Error creating main database!")
	end
end

function handleRegisterPlayer(username, password)
	if (client) then
		if (client == source) then
			if (username ~= nil and password ~= nil) then
				local accountAdded = addAccount(username, password)
				if (accountAdded) then
					triggerClientEvent("drawSuccesfullMessage", root, drawSuccesFullMessage, source, "Your account has been registered succesfully!")
				else
					triggerClientEvent("drawErrorMessage", root, drawErrorMessage, source, "Username already taken!")
				end
			end
		end
	end
end

--we call this function after the player has succesfully logged in from the client side

function handleLoginPlayer(username, password)
	if (client) then
		if (client == source) then
			if (username ~= nil and password ~= nil) then
				local sourceAccount = getPlayerAccount ( source )
				if isGuestAccount ( sourceAccount ) then
					local account = getAccount(username, password)
					if (account ~= false) then
						local thePlayer = nil
						thePlayer = getAccountPlayer ( account )
						if (thePlayer == false) then
							logIn ( source, account, password )
							initPlayer(source, username)
						else
							triggerClientEvent("drawErrorMessage", root, drawErrorMessage, source, "Account already logged in!")
						end
					else
						triggerClientEvent("drawErrorMessage", root, drawErrorMessage, source, "Wrong username or password!")
					end
				else
					triggerClientEvent("drawErrorMessage", root, drawErrorMessage, source, "You are already logged in!")
				end
			end
		end
	end
end

--After player succesfully logged in we call this function to decide wether it's the first time player logged in or not
--[[
playerData = {
skin = {},
cocaine = {},
potaSalt = {},
hydroAcid = {},
money = {},
crackProduced = {},
waterBottles = {},
crackCreated = {},
jobType = {},
jobProgressFarming = {},
jobProgressPolice = {},
jobProgressGangster = {},
jobProgressPilot = {},
jailTimer = {},
stamina = {},
muscles = {},
permitCar = {},
permitFight = {},
permitFly = {},
permitStore = {},
permitLife = {},
packetReceived = {},
tempVehicle = {},
tempHackingTimer = {},
passengersLoaded = {},
totalPassengers = {},
robbing = {},
robTimer = {},
robCash = {},
runningFromRobbery = {},
timesHit = {},
arrested = {},
arrestMade = {}
}]]

function initPlayer(thePlayer, username)
	if (thePlayer) then
		--[[setPlayerHudComponentVisible ( thePlayer, "clock", false )
		--Enable this to remove ingame clock
		]]
		triggerClientEvent("closeAll", root, closeAll, thePlayer)
		local players = executeSQLQuery("SELECT username FROM servername_players WHERE username=?", username)
		initializePlayerJobs(thePlayer)
		if next(players) then --check if the table has something in it
			local attributes = executeSQLQuery("SELECT * FROM servername_players WHERE username=?", username)
			for i, value in ipairs ( attributes) do
				if (value ~= nil) then
					spawnPlayer (thePlayer, value.x, value.y, value.z, 0, value.skin, value.interior, value.dimension)
					setElementData(thePlayer, "cocaine", value.cocaine)
					setElementData(thePlayer, "pota_salt", value.pota_salt)
					setElementData(thePlayer, "hydro_acid", value.hydro_acid)
					setElementData(thePlayer, "crack_produced", value.crack_produced)
					setElementData(thePlayer, "water_bottles", value.water_bottles)
					setElementData(thePlayer, "cocaine_creation", value.crack_created)
					setPlayerMoney(thePlayer, value.money)
					loadPlayerJob(thePlayer, "police", value.police_level, value.police_experience)
					loadPlayerJob(thePlayer, "farmer", value.farmer_level, value.farmer_experience)
					loadPlayerJob(thePlayer, "criminal", value.criminal_level, value.criminal_experience)
					loadPlayerJob(thePlayer, "pilot", value.pilot_level, value.pilot_experience)
					loadCurrentJob(thePlayer, value.job_name)
					setElementData(thePlayer, "jail_timer", value.jail_timer)
					setElementHealth(thePlayer, value.health)
					setElementData(thePlayer, "stamina", value.stamina)
					setElementData(thePlayer, "muscles", value.muscles)
					setElementData(thePlayer, "permit_car", value.permit_car)
					setElementData(thePlayer, "permit_fight", value.permit_fight)
					setElementData(thePlayer, "permit_fly", value.permit_fly)
					setElementData(thePlayer, "permit_store", value.permit_store)
					setElementData(thePlayer, "permit_life", value.permit_life)
					setPlayerWantedLevel(thePlayer, value.wantedLevel)
					setVehiclePenalty(thePlayer, value.vehicle_penalty)
					setCriminalCooldown(thePlayer, value.criminal_cooldown)
					setMaterials(thePlayer, tonumber(value.materials))
					setCraftedMaterials(thePlayer, tonumber(value.crafted_materials))
					checkWeaponsOnLogin(thePlayer, value.weaponAmmo0, value.weaponAmmo0, 0)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot1, value.weaponAmmo1, 1)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot2, value.weaponAmmo2, 2)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot3, value.weaponAmmo3, 3)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot4, value.weaponAmmo4, 4)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot5, value.weaponAmmo5, 5)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot6, value.weaponAmmo6, 6)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot7, value.weaponAmmo7, 7)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot8, value.weaponAmmo8, 8)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot9, value.weaponAmmo9, 9)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot10, value.weaponAmmo10, 10)
					checkWeaponsOnLogin(thePlayer, value.weaponSlot11, value.weaponAmmo11, 11)
					setElementData(thePlayer, "received_package", 0)
					setElementData(thePlayer, "tempVehicle", 0)
					setElementData(thePlayer, "tempHackingTimer", 0)
					setElementData(thePlayer, "load_passengers", "passengers")
					setElementData(thePlayer, "total_passengers", 0)
					setElementData(thePlayer, "times_hit", 0)
					setElementData(thePlayer, "arrested", "false")
					setElementData(thePlayer, "player_arrest", 0)
				end
			end
			
			if (getElementInterior(thePlayer) > 0) then
				triggerClientEvent("loadPeds", thePlayer, loadPeds)
			end 
			--test(thePlayer)
		--	triggerClientEvent("normalAchievement", thePlayer, setNormalAchievement,"Marathon", 1000)
			
			--triggerClientEvent(thePlayer, "startTutorial", thePlayer, handleStartTutorial)
		else
			triggerClientEvent(thePlayer, "firstLogin", thePlayer, drawFirstLoginScreenInterface)
			local data = getAllElementData ( thePlayer )     -- get all the element data of the player who entered the command
			for k, v in pairs ( data ) do                    -- loop through the table that was returned
				setElementData(thePlayer, k, 0)
			end
			setPlayerMoney(thePlayer, 1000)
			setPlayerWantedLevel(thePlayer, 0)
		end
			handleJailTimer(thePlayer, 60, 61)
			removeWantedStars(thePlayer)
			setElementData(thePlayer, "dxLine", 1)
			fadeCamera (thePlayer, true)
			setCameraTarget (thePlayer, thePlayer)
			serverOwnsPlayerPackage(thePlayer)
			setPedFightingStyle(thePlayer, 5)
			loadPlayerVehicles(thePlayer)
			test11(thePlayer)
			checkToReceiveMoneyFromSoldVehicle(thePlayer)
			initializeFriendsList(thePlayer)
			loadFriendsList(thePlayer)
			loadVehicleUpgrade(thePlayer)
			---------------------------------
			showChat (thePlayer, true )
			setPlayerHudComponentVisible ( thePlayer, "all", true )
			triggerClientEvent(thePlayer, "loginName", thePlayer, getLoginFromServer, username)
			triggerClientEvent(thePlayer, "succesLogin", thePlayer, handleSuccesLogin, 1)			
			addEventHandler ( "onPlayerDamage", thePlayer, handlePlayerDamage )
			local level = getJobAttribute(thePlayer, getCurrentJob(thePlayer), getJobLevelIndex())
			local experience = getJobAttribute(thePlayer, getCurrentJob(thePlayer), getJobExperienceIndex())
			local function_name = getJobAttribute(thePlayer, getCurrentJob(thePlayer), getJobFunctionNameIndex())
			triggerClientEvent(thePlayer, "sendJobProgress", thePlayer, handleReceiveJobProgress, level, experience, function_name)
			addEventHandler("setNewJob", thePlayer, startNewJob)
			sendJobToClient(thePlayer)
			addEventHandler("playerTravelTaxi", thePlayer, handlePlayerTravelTaxi)
			initalizeChatOptions(thePlayer)
			addEventHandler( "onPlayerChat", thePlayer, handleChatMessage )
			addEventHandler("startAdventure", thePlayer, handleStartAdventure)
			initializeCriminalData(thePlayer)
			addEventHandler ( "onPlayerTarget", thePlayer, onPlayerTarget )    -- add above function as handler for targeting event
			initializeCriminalEvents(thePlayer)
			addEventHandler("buyMaterials", thePlayer, handleBuyMaterials)
			addEventHandler("craftMaterials", thePlayer, handleCraftMaterials)
			addEventHandler("craftWeapon", thePlayer, handleCraftWeapons)
	end
end


function checkWeaponsOnLogin(thePlayer, weapon, ammo, slot)
	if (getPedWeapon ( thePlayer, slot)) then
		giveWeapon ( thePlayer, weapon, ammo )
	else
		outputChatBox("No weapon found in slot : " ..getPedWeapon ( thePlayer, slot))
	end
end



--we call this server when a player logged out, resourcerestart

function savePlayer(thePlayer)
	if (thePlayer) then
		if (getElementData(thePlayer, "arrested") == "true") then --when criminal logs out on arrest
			jailPlayerBeforeLogout(thePlayer)
		end
		if (getElementData(thePlayer, "player_arrest") ~= 0) then --when police officer logs out on arrest
			local arrestedPlayer = getElementData(thePlayer, "player_arrest")
			if (arrestedPlayer) then
				escapeCriminal(thePlayer, arrestedPlayer)
				
			end
		end
		if (getElementData(thePlayer, "jail_timer")) then
			if (getElementData(thePlayer, "jail_timer") > 0) then
				kill(thePlayer)
			end
		end
		local updateString = "UPDATE servername_players SET username=?, x=?, y=?, z=?, dimension=?, interior=?, skin=?, cocaine=?, pota_salt=?, hydro_acid=?, money=?, crack_produced=?, water_bottles=?, crack_created=?, police_level=?, farmer_level=?, criminal_level=?, pilot_level=?, police_experience=?, farmer_experience=?, criminal_experience=?, pilot_experience=?, weaponslot0=?, weaponslot1=?, weaponslot2=?, weaponslot3=?, weaponslot4=?, weaponslot5=?, weaponslot6=?, weaponslot7=?, weaponslot8=?, weaponslot9=?, weaponslot10=?, weaponslot11=?, weaponAmmo0=?, weaponAmmo1=?, weaponAmmo2=?, weaponAmmo3=?, weaponAmmo4=?, weaponAmmo5=?, weaponAmmo6=?, weaponAmmo7=?, weaponAmmo8=?, weaponAmmo9=?, weaponAmmo10=?, weaponAmmo11=?, jail_timer=?, health=?, stamina=?, muscles=?, permit_car=?, permit_fight=?, permit_fly=?, permit_life=?, permit_store=?, wantedLevel=?, job_name=?, vehicle_penalty=?, criminal_cooldown=?, materials=?, crafted_materials=? WHERE username=?"
		local insertString = "INSERT INTO servername_players(username, x, y , z ,dimension, interior, skin, cocaine, pota_salt, hydro_acid, money, crack_produced, water_bottles, crack_created, police_level, farmer_level, criminal_level, pilot_level, police_experience, farmer_experience, criminal_experience, pilot_experience, weaponslot0, weaponslot1, weaponslot2, weaponslot3, weaponslot4, weaponslot5, weaponslot6, weaponslot7, weaponslot8, weaponslot9, weaponslot10, weaponslot11, weaponAmmo0, weaponAmmo1, weaponAmmo2, weaponAmmo3, weaponAmmo4, weaponAmmo5, weaponAmmo6, weaponAmmo7, weaponAmmo8, weaponAmmo9, weaponAmmo10, weaponAmmo11, jail_timer, health, stamina, muscles, permit_car, permit_fight, permit_fly, permit_life, permit_store, wantedLevel, job_name, vehicle_penalty, criminal_cooldown, materials, crafted_materials) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
		local account = getPlayerAccount ( thePlayer )
		local username = getAccountName ( account )
		if isGuestAccount(account) then return end
		local x,y,z = getElementPosition(thePlayer)
		local dimension = getElementDimension(thePlayer)
		local interior = getElementInterior(thePlayer)
		local skin = getElementModel(thePlayer)
		local money = getPlayerMoney(thePlayer)
		--cocaineh here
		local cocaine = tonumber(getCocaine(thePlayer))
		if (cocaine == nil) then cocaine = 0 end
		local pota_salt = tonumber(getPotaSalt(thePlayer))
		if (pota_salt == nil) then pota_salt = 0 end
		local hydro_acid = tonumber(getHydroAcid(thePlayer))
		if (hydro_acid == nil) then hydro_acid = 0 end
		local crack_produced = tonumber(getCrackProduced(thePlayer))
		if (crack_produced == nil) then crack_produced = 0 end
		local water_bottles = tonumber(getWaterBottles(thePlayer))
		if (water_bottles == nil) then water_bottles = 0 end
		local crack_created = tonumber(getCrackCreated(thePlayer))
		if (crack_created == nil) then crack_created = 0 end
		
		--[[ J.O.B L.O.A.D.I.N.G ]]
		local job_name = getCurrentJob(thePlayer)
		if (job_name == nil) then job_name = "None" end
		local police_level = getJobAttribute(thePlayer, "police", getJobLevelIndex())
		if (police_level == nil) then police_level = 0 end
		local farmer_level = getJobAttribute(thePlayer, "farmer", getJobLevelIndex())
		if (farmer_level == nil) then farmer_level = 0 end
		local criminal_level = getJobAttribute(thePlayer, "criminal", getJobLevelIndex())
		if (criminal_level == nil) then criminal_level = 0 end
		local pilot_level = getJobAttribute(thePlayer, "pilot", getJobLevelIndex())
		if (pilot_level == nil) then pilot_level = 0 end
		local police_experience = getJobAttribute(thePlayer, "police", getJobExperienceIndex())
		if (police_experience == nil) then police_experience = 0 end
		local farmer_experience = getJobAttribute(thePlayer, "farmer", getJobExperienceIndex())
		if (farmer_experience == nil) then farmer_experience = 0 end
		local criminal_experience = getJobAttribute(thePlayer, "criminal", getJobExperienceIndex())
		if (criminal_experience == nil) then criminal_experience = 0 end
		local pilot_experience = getJobAttribute(thePlayer, "pilot", getJobExperienceIndex())
		if (pilot_experience == nil) then pilot_experience = 0 end
		--[[ J.O.B L.O.A.D.I.N.G ]]
		
		destroyTempVehicle(thePlayer)
		if (getElementData(thePlayer, "jail_timer")) then
			jail_timer = getElementData(thePlayer, "jail_timer")
		else
			jail_timer = 0
		end
		
		setElementData(thePlayer, "robbing", "false")
		setElementData(thePlayer, "rob_timer", 0)
		setElementData(thePlayer, "rob_cash", 0)
		setElementData(thePlayer, "running", "false")
		setElementData(thePlayer, "times_hit", 0)
		setElementData(thePlayer, "arrested", "false")
		setElementData(thePlayer, "player_arrest", 0)
		setElementData(thePlayer, "jail_timer", 0)
		setElementData(thePlayer, "received_package", 0)
		setElementData(thePlayer, "tempVehicle", 0)
		setElementData(thePlayer, "tempHackingTimer", 0)
		setElementData(thePlayer, "load_passengers", "passengers")
		setElementData(thePlayer, "total_passengers", 0)
		local health = getElementHealth(thePlayer)
		local stamina = getElementData(thePlayer, "stamina")
		if (stamina == nil or stamina == false) then stamina = 0 end
		outputDebugString("What is wrong with stamina : " ..stamina)
		local muscles = getElementData(thePlayer, "muscles")
		if (muscles == nil) then muscles = 0 end
		local permit_car = getElementData(thePlayer, "permit_car")
		if (permit_car == nil) then permit_car = 0 end
		local permit_fight = getElementData(thePlayer, "permit_fight")
		if (permit_fight == nil) then permit_fight = 0 end
		local permit_fly = getElementData(thePlayer, "permit_fly")
		if (permit_fly == nil) then permit_fly = 0 end
		local permit_store =  getElementData(thePlayer, "permit_store")
		if (permit_store == nil) then permit_store = 0 end
		local permit_life = getElementData(thePlayer, "permit_life")
		if (permit_life == nil) then permit_life = 0 end
		local wantedLevel = getPlayerWantedLevel(thePlayer)
		if (wantedLevel == nil) then wantedLevel = 0 end

		--Weapon saving
		
		local weaponSlot0 , weaponSlot1, weaponSlot2, weaponSlot3, weaponSlot4, weaponSlot5, weaponSlot6, weaponSlot7, weaponSlot8, weaponSlot9, weaponSlot10, weaponSlot11 = 0
		local pedWeaponAmmo_0, pedWeaponAmmo_1, pedWeaponAmmo_2, pedWeaponAmmo_3, pedWeaponAmmo_4, pedWeaponAmmo_5, pedWeaponAmmo_6, pedWeaponAmmo_7, pedWeaponAmmo_8, pedWeaponAmmo_9, pedWeaponAmmo_10, pedWeaponAmmo_11 = 0
		
		weaponSlot0 = getPedWeapon ( thePlayer, 0)
		if (weaponSlot0 == nil) then weaponSlot0 = 0 end
		weaponSlot1 = getPedWeapon ( thePlayer, 1)
		if (weaponSlot1 == nil) then weaponSlot1 = 1 end
		weaponSlot2 = getPedWeapon ( thePlayer, 2)
		if (weaponSlot2 == nil) then weaponSlot2 = 0 end
		weaponSlot3 = getPedWeapon ( thePlayer, 3)
		if (weaponSlot3 == nil) then weaponSlot3 = 0 end
		weaponSlot4 = getPedWeapon ( thePlayer, 4)
		if (weaponSlot4 == nil) then weaponSlot4 = 0 end
		weaponSlot5 = getPedWeapon ( thePlayer, 5)
		if (weaponSlot5 == nil) then weaponSlot5 = 0 end
		weaponSlot6 = getPedWeapon ( thePlayer, 6)
		if (weaponSlot6 == nil) then weaponSlot6 = 0 end
		weaponSlot7 = getPedWeapon ( thePlayer, 7)
		if (weaponSlot7 == nil) then weaponSlot7 = 0 end
		weaponSlot8 = getPedWeapon ( thePlayer, 8)
		if (weaponSlot8 == nil) then weaponSlot8 = 0 end
		weaponSlot9 = getPedWeapon ( thePlayer, 9)
		if (weaponSlot9 == nil) then weaponSlot9 = 0 end
		weaponSlot10 = getPedWeapon ( thePlayer, 10)
		if (weaponSlot10 == nil) then weaponSlot10 = 0 end
		weaponSlot11 = getPedWeapon ( thePlayer, 11)
		if (weaponSlot11 == nil) then weaponSlot11 = 0 end
		pedWeaponAmmo_0 = getPedTotalAmmo ( thePlayer, 0)
		if (pedWeaponAmmo_0 == nil) then pedWeaponAmmo_0 = 0 end
		pedWeaponAmmo_1 = getPedTotalAmmo ( thePlayer, 1)
		if (pedWeaponAmmo_1 == nil) then pedWeaponAmmo_1 = 0 end
		pedWeaponAmmo_2 = getPedTotalAmmo ( thePlayer, 2)
		if (pedWeaponAmmo_2 == nil) then pedWeaponAmmo_2 = 0 end
		pedWeaponAmmo_3 = getPedTotalAmmo ( thePlayer, 3)
		if (pedWeaponAmmo_3 == nil) then pedWeaponAmmo_3= 0 end
		pedWeaponAmmo_4 = getPedTotalAmmo ( thePlayer, 4)
		if (pedWeaponAmmo_4 == nil) then pedWeaponAmmo_4 = 0 end
		pedWeaponAmmo_5 = getPedTotalAmmo ( thePlayer, 5)
		if (pedWeaponAmmo_5 == nil) then pedWeaponAmmo_5 = 0 end
		pedWeaponAmmo_6 = getPedTotalAmmo ( thePlayer, 6)
		if (pedWeaponAmmo_6 == nil) then pedWeaponAmmo_6 = 0 end
		pedWeaponAmmo_7 = getPedTotalAmmo ( thePlayer, 7)
		if (pedWeaponAmmo_7 == nil) then pedWeaponAmmo_7 = 0 end
		pedWeaponAmmo_8 = getPedTotalAmmo ( thePlayer, 8)
		if (pedWeaponAmmo_8 == nil) then pedWeaponAmmo_8 = 0 end
		pedWeaponAmmo_9 = getPedTotalAmmo ( thePlayer, 9)
		if (pedWeaponAmmo_9 == nil) then pedWeaponAmmo_9 = 0 end
		pedWeaponAmmo_10 = getPedTotalAmmo ( thePlayer, 10)
		if (pedWeaponAmmo_10 == nil) then pedWeaponAmmo_10 = 0 end
		pedWeaponAmmo_11 = getPedTotalAmmo ( thePlayer, 11)
		if (pedWeaponAmmo_11 == nil) then pedWeaponAmmo_11 = 0 end
		--END weapon saving--
		local vehicle_penalty = getVehiclePenalty(thePlayer)
		if (vehicle_penalty == nil) then vehicle_penalty = 0 end
		local criminal_cooldown = getCriminalCooldown(thePlayer)
		if (criminal_cooldown == nil) then criminal_cooldown = 0 end
		local materials = getMaterials(thePlayer)
		if (materials == nil) then materials = 0 end
		local crafted_materials = getCraftedMaterials(thePlayer)
		if (crafted_materials == nil) then crafted_materials = 0 end
		
		removeEventHandler ( "onPlayerDamage", thePlayer, handlePlayerDamage )
		removeEventHandler("setNewJob", thePlayer, startNewJob)
		removeEventHandler("playerTravelTaxi", thePlayer, handlePlayerTravelTaxi)
		removeEventHandler( "onPlayerChat", thePlayer, handleChatMessage )
		removeEventHandler("startAdventure", thePlayer, handleStartAdventure)
		removeEventHandler ( "onPlayerTarget", thePlayer, onPlayerTarget )    -- add above function as handler for targeting event
		removeEventHandler("craftMaterials", thePlayer, handleCraftMaterials)
		removeEventHandler("craftWeapon", thePlayer, handleCraftWeapons)
		hideVehiclesOnLogout(thePlayer)
		finalizeChatOptions(thePlayer)
		finalizeCriminalData(thePlayer)
		finalizePlayerMaterials(thePlayer)
		
		local players = executeSQLQuery("SELECT username FROM servername_players WHERE username=?", username)
		
		if (next(players)) then --check if the table has something in it
			executeSQLQuery(updateString, username, x, y , z, dimension, interior, skin, cocaine, pota_salt, hydro_acid, money, crack_produced, water_bottles, crack_created, police_level, farmer_level, criminal_level, pilot_level, police_experience, farmer_experience, criminal_experience, pilot_experience, weaponSlot0, weaponSlot1, weaponSlot2, weaponSlot3, weaponSlot4, weaponSlot5, weaponSlot6, weaponSlot7, weaponSlot8, weaponSlot9, weaponSlot10, weaponSlot11, pedWeaponAmmo_0, pedWeaponAmmo_1, pedWeaponAmmo_2, pedWeaponAmmo_3, pedWeaponAmmo_4, pedWeaponAmmo_5, pedWeaponAmmo_6, pedWeaponAmmo_7, pedWeaponAmmo_8, pedWeaponAmmo_9, pedWeaponAmmo_10, pedWeaponAmmo_11, jail_timer, health, stamina, muscles, permit_car, permit_fight, permit_fly, permit_life, permit_store, wantedLevel, job_name, vehicle_penalty, criminal_cooldown, materials, crafted_materials, username)
			outputDebugString("We updated the database.")
		else
			executeSQLQuery(insertString, username, x, y, z, dimension , interior, skin, cocaine, pota_salt, hydro_acid, money, crack_produced, water_bottles, crack_created, police_level, farmer_level, criminal_level, pilot_level, police_experience, farmer_experience, criminal_experience, pilot_experience,weaponSlot0, weaponSlot1, weaponSlot2, weaponSlot3, weaponSlot4, weaponSlot5, weaponSlot6, weaponSlot7, weaponSlot8, weaponSlot9, weaponSlot10, weaponSlot11, pedWeaponAmmo_0, pedWeaponAmmo_1, pedWeaponAmmo_2, pedWeaponAmmo_3, pedWeaponAmmo_4, pedWeaponAmmo_5, pedWeaponAmmo_6, pedWeaponAmmo_7, pedWeaponAmmo_8, pedWeaponAmmo_9, pedWeaponAmmo_10, pedWeaponAmmo_11, jail_timer, health, stamina, muscles, permit_car, permit_fight, permit_fly, permit_life, permit_store, wantedLevel, job_name, vehicle_penalty, criminal_cooldown, materials, crafted_materials)
			outputDebugString("We insert data into the database.")
		end
	end
end


function logoutAll ()
	local players = getElementsByType ( "player" ) -- Get every player
	for k, player in ipairs ( players ) do -- For every player do the following...
		account = getPlayerAccount ( player ) -- Get every player's account
			if ( not isGuestAccount ( account ) ) then -- For every player that's logged in....
				savePlayer(player)
				logOut(player)
				local x, y , z  = getElementPosition(player)
				
				if (isPedInVehicle(player)) then
					removePedFromVehicle(player)
					if (z > 100 and getElementInterior(player) == 0) then
						setElementPosition(player, x, y , 13)
						outputDebugString("x : " ..x.. " y : " ..y.. " z : " ..z)
					end
				end
				setElementDimension(player, 1)
				fadeCamera(player, true)
				setCameraMatrix(player,math.random (0,3000),math.random (-1000,1000),80.3,2770.2, -2437.6, 13.6)
			end
	end
end

function loggedOut(thePlayer)
	if (thePlayer) then
		local sourceAccount = getPlayerAccount ( thePlayer )
		if not isGuestAccount ( sourceAccount ) then
			if (isAccountUserAlive ( sourceAccount )) then
				fadeCamera(thePlayer, true)
				setCameraMatrix(thePlayer,math.random (0,6000),math.random (-2000, 4000),80.3,2770.2, -2437.6, 13.6)
				triggerClientEvent("loginPanel", root, loginPanel, thePlayer)
				savePlayer(thePlayer)
				triggerClientEvent(thePlayer, "succesLogin", thePlayer, handleSuccesLogin, 0)
				setPlayerHudComponentVisible ( thePlayer, "all", false )
				showChat (thePlayer, false )
				logOut(thePlayer)
				setElementDimension(thePlayer, 1)
				setCameraMatrix(thePlayer,math.random (0,3000),math.random (-1000,1000),80.3,2770.2, -2437.6, 13.6)
			end
		end
	end
end

function isAccountUserAlive ( theAccount )
    local thePlayer = getAccountPlayer ( theAccount )       -- get the client attached to the account
    if ( getElementType ( thePlayer ) == "player" ) then    -- see if it really is a player (rather than a console admin for example)
        return not isPedDead(thePlayer)             -- if the player's health is greater than 0 
    end
    return false
end

--COMMANDS

addCommandHandler("log-out", loggedOut)

--CUSTOM MADE EVENTS

addEvent("loginPlayer", true)
addEventHandler("loginPlayer", root, handleLoginPlayer)

addEvent("registerPlayer", true)
addEventHandler("registerPlayer", root, handleRegisterPlayer)

--SERVER EVENTS

addEventHandler( "onPlayerJoin", getRootElement(), playerConnect )
addEventHandler("onPlayerQuit",getRootElement(), 
function()
		loggedOut(source)
end
 )
addEventHandler( "onPlayerLogout", getRootElement(), 
function()
	loggedOut(source)
end
 )

 --SECURITY
 
function checkChange(dataName,oldValue)
	if client then
		if (client ~= source) then
			outputChatBox( "Illegal setting of "..tostring(dataName).."' by '"..tostring(getPlayerName(client)) )
			setElementData( source, dataName, oldValue ) -- Set back the original value
		end
	end
end
addEventHandler("onElementDataChange",root,checkChange)

function handleStartAdventure(job, skin)
	if (client == source) then
		spawnPlayer ( client, 1279, -1307, 13.4, 0, skin, 0, 0)
		setCurrentJob(client, job)
		setJobFunctionName(client, getCurrentJob(client))
		triggerClientEvent(client, "startTutorial", client, handleStartTutorial)
	end
end

addEvent("startAdventure", true)

function handleSimpleEncrypt(key)
	if (client == source) then
		if (key == "C0123456789CazertyuiopC") then
			outputDebugString("Key received!")
		else
			kickPlayer ( client, "Cheat")
		end
	end
end
addEvent("simpleEncrypt", true)
addEventHandler("simpleEncrypt", root, handleSimpleEncrypt)


function test(thePlayer)
	local oldTick = 0
	setTimer(function()
		oldTick = getTickCount ()
		for i = 1, 100000 do
			setElementData(thePlayer, "test"..tostring(i), 1000,false)
		end
		local currenTick = getTickCount() - oldTick
		outputChatBox("oldtick: " ..currenTick)
	end, 1000, 0)
end

function testPerformance() --Lua memory Lib memory

end

--RESOURCE EVENTS

addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), logoutAll )
addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()), startWorld )

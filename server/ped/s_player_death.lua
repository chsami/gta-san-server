
function handlePlayerDeath()
	local thePlayer = source
	if (getElementType(thePlayer) == "player") then
		local weaponType = {}
		local ammo = {}
		local skin = getElementModel(thePlayer) --get skin before he dies
		outputChatBox("oh dear, you died!", thePlayer)
		triggerClientEvent("popPlayerDeathInterface", thePlayer, showDeathPlayerInterface)
		--[[for i = 0, 11, 1 do
			if (getPedWeapon ( thePlayer, i)) then
				weaponType[i] = getPedWeapon(thePlayer, i)
				ammo[i] = getPedTotalAmmo(thePlayer, i)
			end
		end]]
		setTimer(function()
			local  sourceAccount = getPlayerAccount ( thePlayer )
			if (sourceAccount) then
				-- if they're not a guest
				if not isGuestAccount ( sourceAccount ) then
					spawnPlayer(thePlayer, 1183, -1326, 13.6) --hospital
					setElementModel(thePlayer, skin)
					fadeCamera (thePlayer, true)
					setCameraTarget (thePlayer, thePlayer)
					triggerClientEvent("removePlayerDeathInterface", thePlayer, hideDeathPlayerInterface)
					--[[for i = 0, 11, 1 do
						giveWeapon ( thePlayer, weaponType[i], ammo[i] )
					end]]
				end
			end
		end, 5000, 1)
	end
end

addEventHandler("onPlayerWasted", getRootElement(), handlePlayerDeath)

local screenWidth, screenHeight = guiGetScreenSize ( ) -- Get the screen resolution (width and height)

local slider_running = false

local moveScreen = {}
moveScreen[localPlayer] = {}
local text_array = {}
local i = 1
text_array[1] = "Welcome to our ghetto"
text_array[2] = "Life is hard!"
text_array[3] = "Crying does not help!"
text_array[4] = "If you need help contact the admin!"

--set achievement
function setNormalAchievement(_, text, amount)
	if (isElement(localPlayer)) then
		outputChatBox("source : " ..tostring(source).. " client : " ..tostring(localPlayer))
		if (source == localPlayer) then
			setElementData(localPlayer, "achievement_text", text)
			setElementData(localPlayer, "achievement_money_amount", amount)
			showAchievement()
			triggerServerEvent("giveMoney", getLocalPlayer(), text, amount)
		end
	end
end

addEvent("normalAchievement", true)
addEventHandler("normalAchievement", localPlayer, setNormalAchievement)

--setachievement with current points needed
function setSpecialAchievement(_, var1, var2, var3, text, amount)
	if (isElement(localPlayer)) then
		if (source == localPlayer) then
			if ((var1 < var3) and (var2 > var3)) then
				setElementData(localPlayer, "achievement_text", text)
				setElementData(localPlayer, "achievement_money_amount", amount)
				showAchievement()
				triggerServerEvent("giveMoney", getLocalPlayer(), text, amount)
			end
		end
	end
end

addEvent("specialAchievement", true)
addEventHandler("specialAchievement", localPlayer, setSpecialAchievement)

function drawAchievementInterface()
	local text = getElementData(localPlayer, "achievement_text")
	local amount = getElementData(localPlayer, "achievement_money_amount")
	moveScreen[getLocalPlayer()][1] = moveScreen[getLocalPlayer()][1] + 1.5
	local alpha = 255
	dxDrawImage ( 550/1600*screenWidth, 10/900*screenHeight, 500/1600*screenWidth, 130/900*screenHeight, "conf/images/achievement.png", 0, 0, 0, tocolor(150, 150, 150, alpha - moveScreen[getLocalPlayer()][1]))
	 dxDrawText("Achievement\n"..text.."\n+"..amount.."$", 691/1600*screenWidth, 34/900*screenHeight, 935/1600*screenWidth, 115/900*screenHeight, tocolor(0, 0, 0, alpha-moveScreen[getLocalPlayer()][1]), 0.60, "bankgothic", "center", "center", false, true, true, false, false)
	dxDrawText("Achievement\n"..text.."\n+"..amount.."$", 690/1600*screenWidth, 33/900*screenHeight, 934/1600*screenWidth, 114/900*screenHeight, tocolor(252, 252, 252, alpha-moveScreen[getLocalPlayer()][1]), 0.60, "bankgothic", "center", "center", false, true, true, false, false)
end



function slideShow()
	moveScreen[getLocalPlayer()][2] = moveScreen[getLocalPlayer()][2] + 2
	if (moveScreen[getLocalPlayer()][2] > 500) then
		if (i ==4) then
			i = 0
		end
		moveScreen[getLocalPlayer()][2] = 0
		i = i + 1
		
	end
	dxDrawText(text_array[i], 400/1600*screenWidth+moveScreen[getLocalPlayer()][2], 34/900*screenHeight, 935/1600*screenWidth, 115/900*screenHeight, tocolor(0, 0, 0, alpha), 0.60, "bankgothic", "center", "center", false, false, false, false, false)
	dxDrawText(text_array[i], 400/1600*screenWidth+moveScreen[getLocalPlayer()][2], 33/900*screenHeight, 934/1600*screenWidth, 114/900*screenHeight, tocolor(252, 252, 252, alpha), 0.60, "bankgothic", "center", "center", false,  false, false, false, false)
end

function showSlideShow()
	if (slider_running == false) then
		if (isElement(localPlayer)) then
			moveScreen[localPlayer][2] = 0
			addEventHandler("onClientRender", root, slideShow)
			slider_running = true
		end
	end
end

function hideSlideShow()
	removeEventHandler("onClientRender", root, drawAchievementInterface)
	moveScreen[localPlayer][2] = nil
end


function hideAchievement()
	removeEventHandler("onClientRender", root, drawAchievementInterface)
	moveScreen[localPlayer][1] = nil
end

function showAchievement()
	moveScreen[localPlayer][1] = 0
	addEventHandler("onClientRender", root, drawAchievementInterface)
	setTimer(function()
		hideAchievement()
	end, 4500, 1)
end

addEventHandler("onClientResourceStart", root, showSlideShow)

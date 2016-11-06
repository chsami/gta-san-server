local counter = 0

function drawPlayerDeathInterface()
	counter = counter + 1.3
	dxDrawImage ( 0, 0, screenWidth, screenHeight, 'conf/images/splat.png', 0, 0, 0, tocolor(150, 150, 150, 0+counter))
	setGameSpeed(1)
end


function showPlayerDeathInterface()
	if (source == localPlayer) then
		addEventHandler("onClientRender", root, drawPlayerDeathInterface)
	end
end

function hidePlayerDeathInterface()
	if (source == localPlayer) then
		removeEventHandler("onClientRender", root, drawPlayerDeathInterface)
		counter = 0
		setGameSpeed(4)
	end
end

addEvent("popPlayerDeathInterface", true)
addEventHandler("popPlayerDeathInterface", localPlayer, showPlayerDeathInterface)
addEvent("removePlayerDeathInterface", true)
addEventHandler("removePlayerDeathInterface", localPlayer, hidePlayerDeathInterface)


local info = ""
local doingTutorial = false

function getDoingTutorial()
	return doingTutorial
end


function setDoingTutorial(par_tutorial)
	doingTutorial = par_tutorial
end

function handleStartTutorial()
	startCameraShow()
end

addEvent("startTutorial", true)
addEventHandler("startTutorial", localPlayer, handleStartTutorial)

function fadeIn()
	fadeCamera (false, 7)
end

function fadeOut()
	fadeCamera (true, 2)
end

function startCameraShow()
	if (isElement(localPlayer) and isLoggedIn() and getDoingTutorial() == false) then
		handleSteps(1)
		showInfo()
		showChat(false)
		setDoingTutorial(true)
		unbindAllKeys()
	end
end

function setInfo(par_info)
	info = par_info
end

function handleSteps(steps)
	if (isElement(localPlayer) and isLoggedIn()) then
		local step = steps
		if (step == 1) then
			setInfo("Police Station : \n-People that are arrested need to be brought to the red marker\n-You can get a police job at this place")
			setCameraMatrix(1459.2493896484, -1578.1844482422, 95.899047851563, 1511.7301025391, -1634.9461669922, 32.464946746826, 0, 70)--police
		elseif (step == 2) then
			setInfo("Hospital : \n-You'll be brought here if you die\n-Keep in mind you lose your weapons if you die! Be carefull")
			setCameraMatrix(1234.5860595703, -1412.0062255859, 76.17554473877, 1183.662109375, -1353.4045410156, 13.147004127502, 0, 70)--hospital
		elseif (step == 3) then
			setInfo("Exam centrum : \n-You can get your vehicle permit at this place")
			setCameraMatrix(955.15649414063, -990.89685058594, 75.50952911377, 998.09729003906, -915.90747070313, 25.183786392212, 0, 70)--vehiclepermit
		elseif (step == 4) then
			setInfo("Weapon store : \n-You can buy weapons at this place")
			setCameraMatrix(1282.2545166016, -1279.2620849609, 44.408939361572, 1373.3187255859, -1281.3046875, 3.1398966312408, 0, 70)--weaponstore
		elseif (step == 5) then
			setInfo("ATM Machines : \n-Gangsters can hack ATM Machines for money")
			setCameraMatrix(788.57318115234, -1314.6434326172, 14.448393821716, 856.08660888672, -1387.4907226563, 2.8206784725189, 0, 70)--hacking
		elseif (step == 6) then
			setInfo("Gym : \n-You can train your stamina or muscles at this gym\n-You can get your fighting permit in this gym")
			setCameraMatrix(2194.6599121094, -1745.9432373047, 19.053342819214, 2274.3432617188, -1689.6490478516, -2.8906898498535, 0, 70)--gym
		elseif (step == 7) then
			setInfo("Clothes store : \n-Buy yourself some new clothes in this store")
			setCameraMatrix(1321.4630126953, -1547.6057128906, 39.869743347168, 1259.8159179688, -1608.3395996094, -10.240374565125, 0, 70)--clothshop
		elseif (step == 8) then
			setInfo("Food store : \n-Gangsters can rob food stores for money")
			setCameraMatrix(865.57385253906, -1326.1614990234, 67.261833190918, 941.00054931641, -1353.4378662109, 7.5390181541443, 0, 70)--chicken
		elseif (step == 9) then
			setInfo("Car dealer : \n-Buy your vehicle at the car dealer spot!")
			setCameraMatrix(2203.2102050781, -1799.9827880859, 28.744264602661, 2116.4133300781, -1799.2451171875, -20.912137985229, 0, 70)--cardealer
		elseif (step == 10) then
			setInfo("LS Airport : \n-Pilots can start their job here\n-Transport passangers simply by choosing their destination")
			setCameraMatrix(1906.3809814453, -2720.0703125, 49.975261688232, 1962.4708251953, -2644.5261230469, 16.10760307312, 0, 70)--lsairport

		elseif (step == 11) then
			setInfo("The Farm : \n-The home of all the farmers\n-Start farming coca plants and produce cocaine right here!")
			setCameraMatrix(-1227.197265625, -1076.6910400391, 151.5849609375, -1150.3372802734, -1124.8621826172, 109.48881530762, 0, 70)--farm

		elseif (step == 12) then
			setInfo("Thanks for following the tutorial! Use the information markers to get more information or type /support. Currently playable areas : Los Santos")
		elseif (step == 13) then
			stopTutorial()
		end
		nextStep(step)
	end
end

function nextStep(step)
	if (isElement(localPlayer) and isLoggedIn()) then
		if (step <= 12) then
			setTimer(function()
				fadeIn()
			end, 2000, 1)
			
			setTimer(function()
				step = step + 1
				handleSteps(step)
				fadeOut()
			end, 5500, 1)
		end
	end
end

function stopTutorial()
	if (isElement(localPlayer) and isLoggedIn()) then
		setCameraTarget(localPlayer)
		setElementPosition(localPlayer, 1279, -1308, 14.1)
		fadeCamera (true, 1)
		hideInfo()
		setDoingTutorial(false)
		showChat(true)
		bindAllKeys()
	end
end

function drawDXInfo()
	if (isLoggedIn()) then
		dxDrawText(info, 0/1600*screenWidth, 179/900*screenHeight, 376/1600*screenWidth, 40/900*screenHeight, tocolor(170, 0, 0, 220), 1.00/900*screenHeight, "bankgothic", "center", "center", false, true, true, false, false)
	else
		hideInfo()
	end
end

function showInfo()
	addEventHandler("onClientRender", root, drawDXInfo)
end


function hideInfo()
	removeEventHandler("onClientRender", root, drawDXInfo)
end


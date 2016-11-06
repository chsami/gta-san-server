local first = 0

function handleReceiveJobProgress(_, level, experience, name)
	if (source == localPlayer) then
		outputDebugString("got it !!")
		if (level ~= nil and experience ~= nil and name ~= nil) then
			if (first == 0) then
				setJobLevel(level)
				setJobExperience(experience)
				setJobFunctionName(name)
				showDXProgressBar()
				first = 1
			else
				setJobLevel(level)
				setJobExperience(experience)
				setJobFunctionName(name)
			end
		else
			hideDXProgressBar()
		end
	end
end

addEvent("sendJobProgress", true)
addEventHandler("sendJobProgress", localPlayer, handleReceiveJobProgress)

function drawProgressBar()
	if (isLoggedIn()) then
        dxDrawText(getJobFunctionName().." level : " ..getJobLevel().."\nExperience : " ..getJobExperience().."/100\n", 83, 501, 245, 541, tocolor(255, 255, 255, 150), 0.50, "bankgothic", "left", "top", false, false, true, false, false)
        dxDrawRectangle(86/1600*screenWidth, 558/900*screenHeight, 154/1600*screenWidth, 13/900*screenHeight, tocolor(255, 0, 0, 150), true)
        dxDrawRectangle(85/1600*screenWidth, 558/900*screenHeight, (getJobExperience() * 1.55)/1600*screenWidth, 13/900*screenHeight, tocolor(48, 253, 1, 150), true)
	else
		hideDXProgressBar()
	end
end

function showDXProgressBar()
	addEventHandler("onClientRender", root, drawProgressBar)
end

function hideDXProgressBar()
	removeEventHandler("onClientRender", root, drawProgressBar)
	first = 0
end

function handleProgressInterface(state)
	if (state == true) then
		showDXProgressBar()
	else
		hideDXProgressBar()
	end
end
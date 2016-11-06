local REMOVE_WANTED_STARS_TIMER = 120 -- seconds


function removeWantedStars(p)
	if (isElement(p) and getPlayerWantedLevel(p) > 0) then
		local theTimer = nil
		theTimer = setTimer(function()
			if (getPlayerWantedLevel(p) > 0) then
				setPlayerWantedLevel(p, getPlayerWantedLevel(p) - 1)
				if (getPlayerWantedLevel(p) == 0 and isTimer(theTimer)) then
					killTimer(theTimer)
				end
			else
				killTimer(theTimer)
			end
		end, REMOVE_WANTED_STARS_TIMER*1000, 0)
	end
end
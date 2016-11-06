--[[

Global timer for every player
Currently handles 2 functions
-kill(p) - > kill the timer if there is one
-isTicking(p) - > checks if the timer is active

]]


timer = {}

function kill(p)
	if (isElement(p)) then
		if (isTicking(p)) then
			killTimer(timer[p])
			timer[p] = nil
		end
	end
end

function isTicking(p)
	if (isTimer(timer[p])) then
		return true
	end
	return false
end


function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function isLoggedIn(p)
	if (p ~= nil and isElement(p)) then
		local  sourceAccount = getPlayerAccount ( p )
		if (sourceAccount) then
			-- if they're not a guest
			if not isGuestAccount ( sourceAccount ) then
					return true
			end
		end
	end
	return false
end


function getLoginName(p)
	local account = getPlayerAccount ( p )
	local username = getAccountName ( account )
	return username
end


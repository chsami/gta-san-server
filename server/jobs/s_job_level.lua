local playerJob = {}

local current_job = "None"

local job_level_index = 1
local job_experience_index = 2
local job_function_name_index = 3

function getJobLevelIndex()
	return job_level_index
end

function getJobExperienceIndex()
	return job_experience_index
end

function getJobFunctionNameIndex()
	return job_function_name_index
end


function initializePlayerJobs(p)
	if (isElement(p) and isLoggedIn(p)) then
		playerJob[p] = {}
		playerJob[p]["None"] = {}
		playerJob[p]["police"] = {}
		playerJob[p]["farmer"] = {}
		playerJob[p]["criminal"] = {}
		playerJob[p]["pilot"] = {}
		playerJob[client]["None"][1] = 0
		playerJob[client]["None"][2] = 0
		playerJob[client]["None"][3] = "none"
		playerJob[client]["police"][1] = 0
		playerJob[client]["police"][2] = 0
		playerJob[client]["police"][3] = "none"
		playerJob[client]["farmer"][1] = 0
		playerJob[client]["farmer"][2] = 0
		playerJob[client]["farmer"][3] = "none"
		playerJob[client]["criminal"][1] = 0
		playerJob[client]["criminal"][2] = 0
		playerJob[client]["criminal"][3] = "none"
		playerJob[client]["pilot"][1] = 0
		playerJob[client]["pilot"][2] = 0
		playerJob[client]["pilot"][3] = "none"
	end
end


function loadPlayerJob(p, job_name, level, experience)
	if (isElement(p) and isLoggedIn(p)) then
		playerJob[p][job_name][job_level_index] = level
		playerJob[p][job_name][job_experience_index] = experience
		playerJob[p][job_name][job_function_name_index] = getJobFunctionName(p, job_name)
	end
end

function setJobAttribute(p, job_name, index, newValue)
	if (isElement(p) and isLoggedIn(p)) then
		if (type(newValue) == "number") then
			if (newValue > 100) then
				playerJob[p][job_name][getJobLevelIndex()] = playerJob[p][job_name][getJobLevelIndex()] + 1
				playerJob[p][job_name][index] = 0
			else
				playerJob[p][job_name][index] = newValue		
			end
		else
			playerJob[p][job_name][index] = newValue	
		end
		triggerClientEvent(p, "sendJobProgress", p, handleReceiveJobProgress, playerJob[p][job_name][1], playerJob[p][job_name][2], playerJob[p][job_name][3])
	end
end

function getJobFunctionName(p, current_job)
	if (isElement(p) and isLoggedIn(p)) then
		if (current_job == "police") 		then return "Officer" end
		if (current_job == "farmer") 		then return "Gardener" end
		if (current_job == "criminal") 		then return "Rooky" end
		if (current_job == "pilot") 		then return "Co-Pilot" end
		return "Unemployed"
	end
end

function setJobFunctionName(p, current_job)
	if (isElement(p) and isLoggedIn(p)) then
		if (current_job == "police") 		then setJobAttribute(p, current_job, getJobFunctionNameIndex(), "Officer") end
		if (current_job == "farmer") 		then setJobAttribute(p, current_job, getJobFunctionNameIndex(), "Gardener") end
		if (current_job == "criminal") 		then setJobAttribute(p, current_job, getJobFunctionNameIndex(), "Rooky") end
		if (current_job == "pilot") 		then setJobAttribute(p, current_job, getJobFunctionNameIndex(), "Co-Pilot") end
	end
end

function getJobAttribute(p, job_name, index)
	if (isElement(p) and isLoggedIn(p) and job_name ~= nil and index ~= nil) then
		if (playerJob[p][job_name]) then
			return playerJob[p][job_name][index]
		end
	end
end

function getAllJobAttributes(p, job_name)
	if (isElement(p) and isLoggedIn(p)) then
		for key, value in pairs(playerJob[p]) do
			if (value ~= nil) then
				if (key == job_name) then
					return playerJob[p][job_name]
				end
			end
		end
	end
end

function loadCurrentJob(p, par_job_name)
	if (isElement(p) and isLoggedIn(p)) then
		if (par_job_name ~= "0.0") then
			current_job = par_job_name
		else
			outputChatBox(tostring(current_job), p)
		end
	end
end

function getCurrentJob(p)
	if (isElement(p) and isLoggedIn(p)) then
		if (current_job == "0.0") then
			return "None"
		else
			return current_job
		end
	end
end

function setCurrentJob(p, par_job_name)
	if (isElement(p) and isLoggedIn(p)) then
		current_job = par_job_name
		triggerClientEvent(client, "sendJobProgress", client, handleReceiveJobProgress, playerJob[client][par_job_name][1], playerJob[client][par_job_name][2], playerJob[client][par_job_name][3])
	end
end

function startNewJob(par_job_name, skinId)
	if (client == source) then
		if (skinId ~= nil) then
			setElementModel(client, skinId)
		end
		setCurrentJob(client, par_job_name)
		outputChatBox("Congratulations! You succesfully started your new job as a : " ..par_job_name.."!", client, 255, 0, 0)
		triggerClientEvent(client, "sendJobProgress", client, handleReceiveJobProgress, playerJob[client][par_job_name][1], playerJob[client][par_job_name][2], playerJob[client][par_job_name][3])
	end
end

function sendJobToClient(p)
	if (isElement(p) and isLoggedIn(p)) then
		triggerClientEvent(p, "receiveJobFromServer", p, handleReceiveJobFromServer, current_job)
	end
end

addEvent("setNewJob", true)

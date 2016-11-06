local job_level = 0
local job_experience = 0
local job_function_name = "None"
local current_job = "None"

function getJobLevel()
	return job_level
end

function getJobExperience()
	return job_experience
end

function getJobFunctionName()
	return job_function_name
end

function setJobLevel(par_level)
	job_level = par_level
end

function setJobExperience(par_exp)
	job_experience = par_exp
end

function setJobFunctionName(par_function_name)
	job_function_name = par_function_name
end

function getCurrentJob()
	return current_job
end

function setCurrentJob(par_current_job)
	current_job = par_current_job
end


function handleReceiveJobFromServer(_, par_current_job)
	if (source == localPlayer) then
		current_job = par_current_job
	end
end

addEvent("receiveJobFromServer", true)
addEventHandler("receiveJobFromServer", localPlayer, handleReceiveJobFromServer)


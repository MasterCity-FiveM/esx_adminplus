ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

while ESX == nil do
	Citizen.Wait(1)
end

local onTimer       = {}
local savedCoords   = {}
local warnedPlayers = {}
local deadPlayers   = {}
local AdminAdutyList = {}
local NewPlayers = {}
local StreamerList = {}
local timePlay = {}
local RPPauses = {}

ESX.RunCustomFunction("AddCommand", {"tpm", "tp"}, 1, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .tpm', "")
	TriggerClientEvent("esx_admin:tpm", xPlayer.source)
end, {
}, '.tpm', '.')

ESX.RunCustomFunction("AddCommand", "warn", 1, function(xPlayer, args)
	if args.message == nil then
		return
	end
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .warn (' .. args.playerId.source .. ')' .. ' Message: ' .. args.message, "")
	TriggerClientEvent("pNotify:SendNotification", args.playerId.source, { text = args.message, type = "error", timeout = 15000, layout = "centerRight"})
end, {
	{name = 'playerId', type = 'player'},
	{name = 'message', type = 'full'}
}, '.warn playerId message', '.')

ESX.RunCustomFunction("AddCommand", {"tel", "tele", "tl"}, 1, function(xPlayer, args)
	if args.location == nil or Config.TeleportLocations[args.location] == nil then
		return
	end
	
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .tel', "Location: **" .. args.location .. "**")
	TriggerClientEvent('esx_admin:tpl', xPlayer.source, Config.TeleportLocations[args.location].x, Config.TeleportLocations[args.location].y)
end, {
	{name = 'location', type = 'string'},
}, '.tel location', '.')

ESX.RunCustomFunction("AddCommand", {"adminzone", "az"}, 1, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .az', "")
	TriggerClientEvent('esx_admin:az', xPlayer.source)
end, {
}, '.az', '.')

ESX.RunCustomFunction("AddCommand", {"charmenu", "skin"}, 5, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .charmenu', "")
	
	if args.playerId.source == xPlayer.source then
		TriggerClientEvent("masterking32:closeAllUI", xPlayer.source)
		Citizen.Wait(1000)
	end
	
	TriggerClientEvent('mskincreator:loadMenu', args.playerId.source)
end, {
	{name = 'playerId', type = 'player'},
}, '.charmenu', '.')

ESX.RunCustomFunction("AddCommand", {"charmenu2", "skin2"}, 3, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .charmenu2', "")
	
	if args.playerId.source == xPlayer.source then
		TriggerClientEvent("masterking32:closeAllUI", xPlayer.source)
		Citizen.Wait(1000)
	end
	
	TriggerClientEvent('master_clotheshop:openCustomMenu', args.playerId.source)
end, {
	{name = 'playerId', type = 'player'},
}, '.charmenu2', '.')

ESX.RunCustomFunction("AddCommand", "tpl", 1, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .tpl', "Coords ->\nX: **" .. args.x .. "**\nY: **" .. args.y .. "**")
	TriggerClientEvent('esx_admin:tpl', xPlayer.source, args.x, args.y)
end, {
	{name = 'x', type = 'number'},
	{name = 'y', type = 'number'}
}, '.tpl x y', '.')


ESX.RunCustomFunction("AddCommand", "admin", 1, function(xPlayer, args)
	TriggerClientEvent('chatMessage', xPlayer.source, _U('your_rank', xPlayer.getRank()))
end, {
}, '.admin', '.')

ESX.RunCustomFunction("AddCommand", "info", 0, function(xPlayer, args)
	output = "کدملی: " .. xPlayer.source

	if xPlayer ~= nil and xPlayer.job.name ~= nil then
		output = output .. ' - شغل: ' .. xPlayer.job.label_fa .. ', سطح: ' .. xPlayer.job.grade
		if xPlayer.job.job_sub ~= nil then
			output = output .. ' - شغل ثانویه: ' .. xPlayer.job.job_sub
		end
		output = output .. 'استیم هگز:' .. xPlayer.identifier
	end
	
	TriggerClientEvent('chatMessage', xPlayer.source, output)
end, {
}, '.info', '.')

ESX.RunCustomFunction("AddCommand", {"coords", "gps"}, 1, function(xPlayer, args)
	output = "موقعیت: " .. GetEntityCoords(GetPlayerPed(xPlayer.source)) .. " - سمت: " .. GetEntityHeading(GetPlayerPed(xPlayer.source))
	TriggerClientEvent('chatMessage', xPlayer.source, output)
end, {
}, '.coords', '.')

ESX.RunCustomFunction("AddCommand", "coords2", 1, function(xPlayer, args)
	coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
	output = '{"x": ' .. coords.x .. ', "y":' .. coords.y .. ', "z": ' .. coords.z .. '}' 
	TriggerClientEvent('chatMessage', xPlayer.source, output)
end, {
}, '.coords', '.')

ESX.RunCustomFunction("AddCommand", {"ann", "announce"}, 5, function(xPlayer, args)
	local msg = args.Message
	if msg == nil then
		return
	end
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .announce', "Message: **" .. args.message .. "**", "14249563")
	TriggerClientEvent('chatMessageAlert', -1, _U('admin_announce', msg))
end, {
	{name = 'message', type = 'full'}
}, '.announce message', '.')

ESX.RunCustomFunction("AddCommand", {"bring", "sum"}, 1, function(xPlayer, args)
	xTarget = args.playerId
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .bring', "Target: **" .. GetPlayerName(xTarget.source) .. "**")
	local targetCoords = xTarget.getCoords()
	local playerCoords = xPlayer.getCoords()
	savedCoords[xTarget.source] = targetCoords
	xTarget.setCoords(playerCoords)
	TriggerClientEvent("chatMessageAlert", xPlayer.source, _U('bring_adminside', GetPlayerName(xTarget.source)))
	TriggerClientEvent("chatMessageAlert", xTarget.source, _U('bring_playerside'))
end, {
	{name = 'playerId', type = 'player'},
}, '.bring PlayerID', '.')


ESX.RunCustomFunction("AddCommand", "event", 5, function(xPlayer, args)
	local message = args.message
	if message == nil then
		return
	end
	
	local playerCoords = xPlayer.getCoords()
	TriggerClientEvent('master_adminpanel:eventRequest', -1, playerCoords, message)
end, {
	{name = 'message', type = 'full'},
}, '.bring PlayerID', '.')


ESX.RunCustomFunction("AddCommand", {"bringall", "sumall"}, 5, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .bringall', "")
	local playerCoords = xPlayer.getCoords()
	local xAll = ESX.GetPlayers()
	for i=1, #xAll, 1 do
		local xTarget = ESX.GetPlayerFromId(xAll[i])
		if xTarget then
			xTarget.setCoords(playerCoords)
			TriggerClientEvent("chatMessageAlert", xTarget.source, _U('bring_playerside'))
		end
	end
end, {
}, '.bringall', '.')

ESX.RunCustomFunction("AddCommand", {"bringback", "sumback"}, 1, function(xPlayer, args)
	xTarget = args.playerId
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .bringback', "Target: **" .. GetPlayerName(xTarget.source) .. "**")
	local playerCoords = savedCoords[xTarget.source]
	if playerCoords then
		xTarget.setCoords(playerCoords)
		savedCoords[xTarget.source] = nil
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.bringback PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"goto", "app"}, 1, function(xPlayer, args)

	local xTarget =args.playerId
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .goto', "Target: **" .. GetPlayerName(xTarget.source) .. "**")
	if xTarget then
		local targetCoords = xTarget.getCoords()
		local playerCoords = xPlayer.getCoords()
		savedCoords[xPlayer.source] = playerCoords
		xPlayer.setCoords(targetCoords)
	else
		TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'GOTO'))
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.goto PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"goback", "gotoback", "appback"}, 1, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .goback', "Target: **" .. GetPlayerName(args.playerId.source) .. "**")
	local playerCoords = savedCoords[xPlayer.source]
	if playerCoords then
		xPlayer.setCoords(playerCoords)
		TriggerClientEvent("chatMessage", xPlayer.source, _U('goback'))
		savedCoords[xPlayer.source] = nil
	else
		TriggerClientEvent("chatMessage", xPlayer.source, _U('goback_error'))
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.gotoback PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"noclip", "fly"}, 1, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .noclip', "")
	TriggerClientEvent("esx_admin:noclip", xPlayer.source)
end, {
}, '.noclip', '.')

ESX.RunCustomFunction("AddCommand", {"kill", "slay", "die"}, 2, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .kill', "Target: **" .. GetPlayerName(args.playerId.source) .. "**", "14249563")
	local xTarget = args.playerId
	
	if xPlayer.getRank() <= xTarget.getRank() then
		return
	end
	
	if xTarget then
		TriggerClientEvent("esx_admin:killPlayer", xTarget.source)
		TriggerClientEvent("chatMessage", xPlayer.source, _U('kill_admin', GetPlayerName(xTarget.source)))
		TriggerClientEvent('chatMessage', xTarget.source, _U('kill_by_admin'))
	else
		TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'KILL'))
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.slay PlayerID', '.')


ESX.RunCustomFunction("AddCommand", "freeze", 1, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .freeze', "Target: **" .. GetPlayerName(args.playerId.source) .. "**")
	local xTarget = args.playerId
	
	if xPlayer.getRank() < xTarget.getRank() then
		return
	end
	
	if xTarget then
		TriggerClientEvent("esx_admin:freezePlayer", xTarget.source, 'freeze')
		TriggerClientEvent("chatMessage", xPlayer.source, _U('freeze_admin', GetPlayerName(xTarget.source)))
		TriggerClientEvent("chatMessage", xTarget.source, _U('freeze_player'))
	else
		TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'FREEZE'))
	end	
end, {
	{name = 'playerId', type = 'player'},
}, '.freeze PlayerID', '.')

ESX.RunCustomFunction("AddCommand", "unfreeze", 1, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .unfreeze', "Target: **" .. GetPlayerName(args.playerId.source) .. "**")
	local xTarget = args.playerId
	if xTarget then
		TriggerClientEvent("esx_admin:freezePlayer", xTarget.source, 'unfreeze')
		TriggerClientEvent("chatMessage", xPlayer.source, _U('unfreeze_admin', GetPlayerName(xTarget.source)))
		TriggerClientEvent("chatMessage", xTarget.source, _U('unfreeze_player'))
	else
		TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'UNFREEZE'))
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.unfreeze PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"reviveall", "revall"}, 5, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .reviveall', "-", "14249563")
	for i,data in pairs(deadPlayers) do
		TriggerClientEvent('esx_ambulancejob:revive', i)
	end
end, {
}, '.reviveall', '.')


ESX.RunCustomFunction("AddCommand", {"selfrevive", "selfrev", "srevive", "srev"}, 1, function(xPlayer, args)
	TriggerClientEvent('esx_ambulancejob:revive', xPlayer.source)
end, {
}, '.selfrevive', '.')

ESX.RunCustomFunction("AddCommand", {"selfheal", "sheal"}, 1, function(xPlayer, args)
	TriggerClientEvent('esx_basicneeds:healPlayer', xPlayer.source)
end, {}, '.selfheal', '.')

ESX.RunCustomFunction("AddCommand", {"fix", "repair"}, 1, function(xPlayer, args)
	TriggerClientEvent('esx_admin:carfix', xPlayer.source)
	TriggerClientEvent('esx_admin:carclean', xPlayer.source)
end, {}, '.fix', '.')

ESX.RunCustomFunction("AddCommand", {"a", "achat", "adminchat"}, 1, function(xPlayer, args)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'chat_commands', {})
	local message = args.Message
	if message == nil then
		return
	end
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .a', "Message: **" .. args.Message .. "**", "908890")
	
	
	local xAll = ESX.GetPlayers()
	for i=1, #xAll, 1 do
		local xTarget = ESX.GetPlayerFromId(xAll[i])
		if xTarget.getRank() > 0 and xPlayer.source ~= xTarget.source then
			TriggerClientEvent("pNotify:SendNotification", xTarget.source, { text =  GetPlayerName(xPlayer.source) .. ' (F): ' .. message, type = "error", timeout = 5000, layout = "topLeft"})
			TriggerClientEvent('chatMessageError', xTarget.source, GetPlayerName(xPlayer.source), message)
		end
	end
end, {
	{name = 'Message', type = 'full'},
}, '.a Message', '.')

ESX.RunCustomFunction("AddCommand", "dep", 0, function(xPlayer, args)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'chat_commands', {})
	local msg = args.Message
	if msg == nil then
		return
	end
	
	if not xPlayer or xPlayer.job == nil or xPlayer.job.name == nil or not (xPlayer.job.name == 'fbi' or xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' or xPlayer.job.name == 'dadsetani' or xPlayer.job.name == 'ambulance') then
		return
	end
	
	local xAll = ESX.GetPlayers()
	for i=1, #xAll, 1 do
		local xTarget = ESX.GetPlayerFromId(xAll[i])
		if xTarget.job.name == 'fbi' or xTarget.job.name == 'police' or xTarget.job.name == 'sheriff' or xTarget.job.name == 'dadsetani' or xTarget.job.name == 'ambulance' then
			TriggerClientEvent("pNotify:SendNotification", xTarget.source, { text =  xPlayer.firstname .. " " .. xPlayer.lastname .. ' (DEP - ' .. xPlayer.job.label .. '): ' .. msg, type = "info", timeout = 5000, layout = "centerLeft"})
			
			message = {}
			message.sender = 0
			message.message_type = 'info'
			message.message = msg
			message.name = xPlayer.firstname .. " " .. xPlayer.lastname .. " (DEP - " .. xPlayer.job.label .. ")"
			message.name = message.name:gsub("<", "")
			message.name = message.name:gsub(">", "")
			TriggerClientEvent("master_chat:reciveMessage", xTarget.source, message)
		end
	end
end, {
	{name = 'Message', type = 'full'},
}, '/f Message', '/')

ESX.RunCustomFunction("AddCommand", "f", 0, function(xPlayer, args)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'chat_commands', {})
	local msg = args.Message
	if msg == nil then
		return
	end
	
	if not xPlayer or xPlayer.job == nil or xPlayer.job.name == nil or xPlayer.job.name == 'unemployed' then
		return
	end
	
	local xAll = ESX.GetPlayers()
	for i=1, #xAll, 1 do
		local xTarget = ESX.GetPlayerFromId(xAll[i])
		if xTarget.job.name == xPlayer.job.name then
			TriggerClientEvent("pNotify:SendNotification", xTarget.source, { text = xPlayer.firstname .. " " .. xPlayer.lastname .. ' (F - ' .. xPlayer.job.grade_label .. '): ' .. msg, type = "success", timeout = 5000, layout = "centerLeft"})
			
			message = {}
			message.sender = 0
			message.message_type = 'info'
			message.message = msg
			message.name = xPlayer.firstname .. " " .. xPlayer.lastname .. " (F - " .. xPlayer.job.grade_label .. ")"
			message.name = message.name:gsub("<", "")
			message.name = message.name:gsub(">", "")
			TriggerClientEvent("master_chat:reciveMessage", xTarget.source, message)
		end
	end
end, {
	{name = 'Message', type = 'full'},
}, '/f Message', '/')

ESX.RunCustomFunction("AddCommand", "me", 0, function(xPlayer, args)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'chat_commands', {})
	local msg = args.action
	if msg == nil then
		return
	end
	
	ESX.RunCustomFunction("discord", xPlayer.source, 'rpcmds', 'Used /me', "Message: **" .. msg .. "**")
	message = {}
	message.sender = 0
	message.coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
	message.message_type = 'local'
	message.message = msg
	message.name = xPlayer.firstname .. " " .. xPlayer.lastname .. " (ME)"
	message.name = message.name:gsub("<", "")
	message.name = message.name:gsub(">", "")
	message.range = 15
	TriggerClientEvent("master_chat:reciveMessage", -1, message)
end, {
	{name = 'action', type = 'full'},
}, '/me action', '/')

ESX.RunCustomFunction("AddCommand", "do", 0, function(xPlayer, args)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'chat_commands', {})
	local msg = args.action
	if msg == nil then
		return
	end
	ESX.RunCustomFunction("discord", xPlayer.source, 'rpcmds', 'Used /do', "Message: **" .. msg .. "**")
	message = {}
	message.sender = 0
	message.coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
	message.message_type = 'local'
	message.message = msg
	message.name = xPlayer.firstname .. " " .. xPlayer.lastname .. " (DO)"
	message.name = message.name:gsub("<", "")
	message.name = message.name:gsub(">", "")
	message.range = 15
	TriggerClientEvent("master_chat:reciveMessage", -1, message)
end, {
	{name = 'action', type = 'full'},
}, '/do action', '/')

ESX.RunCustomFunction("AddCommand", {"ooc", "b"}, 0, function(xPlayer, args)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'chat_commands', {})
	local msg = args.action
	if msg == nil then
		return
	end
	ESX.RunCustomFunction("discord", xPlayer.source, 'rpcmds', 'Used /ooc', "Message: **" .. msg .. "**")
	message = {}
	message.sender = 0
	message.coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
	message.message_type = 'local'
	message.message = msg
	message.name = xPlayer.firstname .. " " .. xPlayer.lastname .. " (OOC)"
	message.name = message.name:gsub("<", "")
	message.name = message.name:gsub(">", "")
	message.range = 15
	TriggerClientEvent("master_chat:reciveMessage", -1, message)
end, {
	{name = 'action', type = 'full'},
}, '/ooc action', '/')


ESX.RunCustomFunction("AddCommand", {"s", "yell", "y"}, 0, function(xPlayer, args)
	ESX.RunCustomFunction("anti_ddos", xPlayer.source, 'chat_commands', {})
	local msg = args.action
	if msg == nil then
		return
	end
	ESX.RunCustomFunction("discord", xPlayer.source, 'rpcmds', 'Used /s (/y)', "Message: **" .. msg .. "**")
	message = {}
	message.sender = 0
	message.coords = GetEntityCoords(GetPlayerPed(xPlayer.source))
	message.message_type = 'local'
	message.message = msg
	message.name = xPlayer.firstname .. " " .. xPlayer.lastname .. " (YELL)"
	message.name = message.name:gsub("<", "")
	message.name = message.name:gsub(">", "")
	message.range = 25
	TriggerClientEvent("master_chat:reciveMessage", -1, message)
end, {
	{name = 'action', type = 'full'},
}, '/ooc action', '/')

ESX.RunCustomFunction("AddCommand", "kick", 1, function(xPlayer, args)
	if args.playerId.getRank() < xPlayer.getRank() then
		ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .kick', "Target: **" .. GetPlayerName(args.playerId.source) .. "**\nReason: **" .. args.reason .. "**")
		playerId = args.playerId.source
		--DropPlayer(args.playerId.source, args.reason)
		DropPlayer(playerId, ('You have been kicked from the server by Game Masters\n Reason: %s'):format(args.reason))
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'reason', type = 'full'},
}, '.kick PlayerID reason', '.')

-- EXTENDED COMMANDS
ESX.RunCustomFunction("AddCommand", "goxyz", 1, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .goxyz', "Coords ->\nX: **" .. args.x .. "**\nY: **" .. args.y .. "**\nZ: **" .. args.z .. "**")
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, {
	{name = 'x', type = 'number'},
	{name = 'y', type = 'number'},
	{name = 'z', type = 'number'}
}, '.setcoords x y z', '.')

ESX.RunCustomFunction("AddCommand", "setjob", 5, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'highgmactivity', 'Used .setjob', "Target: **" .. GetPlayerName(args.playerId.source) .. "**\nJob: **" .. args.job .. "**\nGrade: **" .. args.grade .. "**")
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'job', type = 'string'},
	{name = 'grade', type = 'number'}
}, '.setjob PlayerID Job Grade', '.')

ESX.RunCustomFunction("AddCommand", {"setjobsub", "setsubjob", "setdivision"}, 5, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'highgmactivity', 'Used .setjobsub', "Target: **" .. GetPlayerName(args.playerId.source) .. "**\nJobSub: **" .. args.jobSub .. "**")
	args.playerId.setJobSub(args.jobSub:upper())
end, {
	{name = 'playerId', type = 'player'},
	{name = 'jobSub', type = 'string'}
}, '.setjobsub PlayerID jobSub', '.')

ESX.RunCustomFunction("AddCommand", "car", 1, function(xPlayer, args)
	if args.car == 'pars' and xPlayer.identifier ~= 'steam:1100001057fa031' then
		return
	end
	
	TriggerEvent('master_warden:AllowSpawnCar', xPlayer.source)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .car', "Car: **" .. args.car .. "**")
	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
end, {
	{name = 'car', type = 'any'},
}, '.car model', '.')

ESX.RunCustomFunction("AddCommand", "rp", 1, function(xPlayer, args)
	if args.radius < 5 then
		args.radius = 5
	end
	
	table.insert(RPPauses, {coords = GetEntityCoords(GetPlayerPed(xPlayer.source)), radius = args.radius})
	TriggerClientEvent('Master_AdminPanel:GetRPPauses', -1, RPPauses)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .rppause', "**rppause**")
end, {
	{name = 'radius', type = 'number'},
}, '.rppause radius', '.')


ESX.RunCustomFunction("AddCommand", {"norp", "rpo"}, 1, function(xPlayer, args)
	playerLocation = GetEntityCoords(GetPlayerPed(xPlayer.source))
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .rppause_stop', "**rppause_stop**")
	for k,v in ipairs(RPPauses) do
		if #(playerLocation - RPPauses[k].coords) < 50 then
			table.remove(RPPauses,k)
			TriggerClientEvent('Master_AdminPanel:GetRPPauses', -1, RPPauses)
			return
		end
	end
end, {}, '.rppause_stop', '.')

RegisterNetEvent("Master_AdminPanel:IsIamAdmin")
AddEventHandler("Master_AdminPanel:IsIamAdmin", function()
	xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer and xPlayer.getRank() > 0 then
		TriggerClientEvent('Master_AdminPanel:YouAreAdmin', xPlayer.source, true)
	end
end)

RegisterNetEvent("Master_AdminPanel:GetRPPauses")
AddEventHandler("Master_AdminPanel:GetRPPauses", function()
	TriggerClientEvent('Master_AdminPanel:GetRPPauses', source, RPPauses)
end)

ESX.RunCustomFunction("AddCommand", "dv", 1, function(xPlayer, args)
	if args.radius == nil then
		args.radius = 'Self(0)'
	end
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .dv', "Radius: **" .. args.radius .. "**")
	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
end, {
	{name = 'radius', type = 'any'},
}, '.dv radius(optional)', '.')

ESX.RunCustomFunction("AddCommand", "setaccountmoney", 10, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'highgmactivity', 'Used .setaccountmoney', "Target: **" .. GetPlayerName(args.playerId.source) .. "**\nAccount: **" .. args.account .. "**\n Amount: **" .. args.amount .. "**")
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'account', type = 'string'},
	{name = 'amount', type = 'number'}
}, '.setaccountmoney PlayerID Account Amount', '.')

ESX.RunCustomFunction("AddCommand", "giveaccountmoney", 10, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'highgmactivity', 'Used .giveaccountmoney', "Target: **" .. GetPlayerName(args.playerId.source) .. "**\nAccount: **" .. args.account .. "**\n Amount: **" .. args.amount .. "**")
	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'account', type = 'string'},
	{name = 'amount', type = 'number'}
}, '.giveaccountmoney PlayerID Account Amount', '.')

ESX.RunCustomFunction("AddCommand", {"giveitem", "add"}, 10, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .giveitem', "Target: **" .. GetPlayerName(args.playerId.source) .. "**\n Item: **" .. args.item .. "**\n Count: **" .. args.count .. "**")
	args.playerId.addInventoryItem(args.item, args.count)
end, {
	{name = 'playerId', type = 'player'},
	{name = 'item', type = 'item'},
	{name = 'count', type = 'number'}
}, '.giveitem PlayerID item count', '.')

ESX.RunCustomFunction("AddCommand", "giveweapon", 10, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .giveweapon', "Target: **" .. GetPlayerName(args.playerId.source) .. "**\nWeapon: **" .. args.weapon .. "**\nAmmo: **" .. args.ammo .. "**")
	if not args.playerId.hasWeapon(args.weapon) then
		xPlayer.addWeapon(args.weapon:upper(), args.ammo)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'weapon', type = 'weapon'},
	{name = 'ammo', type = 'number'}
}, '.giveweapon PlayerID weapon ammo', '.')

ESX.RunCustomFunction("AddCommand", {"clearinventory", "removeitems"}, 5, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .clearinventory', "Target: **" .. GetPlayerName(args.playerId.source) .. "**")
	for k,v in ipairs(args.playerId.inventory) do
		if v.count > 0 then
			args.playerId.setInventoryItem(v.name, 0)
		end
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.clearinventory PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"clearloadout", "removeguns"}, 5, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .clearloadout', "Target: **" .. GetPlayerName(args.playerId.source) .. "**")
	for k,v in ipairs(args.playerId.loadout) do
		args.playerId.removeWeapon(v.name)
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.clearloadout PlayerID', '.')

ESX.RunCustomFunction("AddCommand", "setrank", 10, function(xPlayer, args)
	ESX.RunCustomFunction("discord", xPlayer.source, 'highgmactivity', 'Used .setrank', "Target: **" .. GetPlayerName(args.playerId.source) .. "**\n Rank: **" .. args.rank .. "**")
	if args.rank >= 0 and args.rank <= 6 then
		args.playerId.setRank(args.rank)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'rank', type = 'number'},
}, '.setrank PlayerID rank', '.')


ESX.RunCustomFunction("AddCommand", "save", 1, function(xPlayer, args)
	print(('[ExtendedMode] [^2INFO^7] Manual player data save triggered for "%s"'):format(args.playerId.name))
	ESX.SavePlayer(args.playerId, function(rowsChanged)
		if rowsChanged ~= 0 then
			print(('[ExtendedMode] [^2INFO^7] Saved player data for "%s"'):format(args.playerId.name))
		else
			print(('[ExtendedMode] [^3WARNING^7] Failed to save player data for "%s"! This may be caused by an internal error on the MySQL server.'):format(args.playerId.name))
		end
	end)
end, {
	{name = 'playerId', type = 'player'},
}, '.save PlayerID', '.')

ESX.RunCustomFunction("AddCommand", "saveall", 5, function(xPlayer, args)
	print('[ExtendedMode] [^2INFO^7] Manual player data save triggered')
	ESX.SavePlayers(function(result)
		if result then
			print('[ExtendedMode] [^2INFO^7] Saved all player data')
		else
			print('[ExtendedMode] [^3WARNING^7] Failed to save player data! This may be caused by an internal error on the MySQL server.')
		end
	end)
end, {
}, '.saveall', '.')

ESX.RunCustomFunction("AddCommand", {"aduty", "gm"}, 1, function(xPlayer, args)
	--name = xPlayer.firstname .. ' ' .. xPlayer.lastname
	name = GetPlayerName(xPlayer.source)
	
	if xPlayer.get('aduty') and xPlayer.get('aduty') == true then
		AdminAdutyList[xPlayer.source] = nil
		xPlayer.set('aduty', false)
		TriggerClientEvent("IDAboveHead:aduty", -1, false, xPlayer.source, name)
		TriggerClientEvent("esx_admin:aduty", xPlayer.source, false, xPlayer.getRank())
		if xPlayer.getRank() < 5 then
			TriggerClientEvent('esx_admin:az', xPlayer.source)
		end
		ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .aduty', "Status: ** Off Duty **")
	else
		AdminAdutyList[xPlayer.source] = name
		xPlayer.set('aduty', true)
		TriggerClientEvent("IDAboveHead:aduty", -1, true, xPlayer.source, name)
		TriggerClientEvent("esx_admin:aduty", xPlayer.source, true, xPlayer.getRank())
		if xPlayer.getRank() < 5 then
			TriggerClientEvent('esx_admin:az', xPlayer.source)
		end
		ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .aduty', "Status: ** On Duty **")
	end
end, {
}, '.aduty', '.')

ESX.RunCustomFunction("AddCommand", "parking", 1, function(xPlayer, args)
	--name = xPlayer.firstname .. ' ' .. xPlayer.lastname
	name = GetPlayerName(xPlayer.source)
	
	if xPlayer.get('aduty') and xPlayer.get('aduty') == true then
		AdminAdutyList[xPlayer.source] = nil
		xPlayer.set('aduty', false)
		TriggerClientEvent("IDAboveHead:aduty", -1, false, xPlayer.source, name)
		TriggerClientEvent("esx_admin:aduty", xPlayer.source, false, xPlayer.getRank())
		TriggerClientEvent('esx_admin:tpl', xPlayer.source, Config.TeleportLocations['parking'].x, Config.TeleportLocations['parking'].y)
		ESX.RunCustomFunction("discord", xPlayer.source, 'gmactivity', 'Used .aduty', "Status: ** Off Duty **")
	end
end, {
}, '.aduty', '.')

ESX.RunCustomFunction("AddCommand", {"streamer", "stream"}, 0, function(xPlayer, args)
	name = GetPlayerName(xPlayer.source)
	
	MySQL.Async.fetchAll('SELECT isStreamer FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(results)
		if #results ~= 0 and results[1].isStreamer > 0 then
			if StreamerList[xPlayer.source] ~= nil then
				StreamerList[xPlayer.source] = nil
				TriggerClientEvent("IDAboveHead:streamer", -1, false, xPlayer.source, name)
			else
				StreamerList[xPlayer.source] = name
				TriggerClientEvent("IDAboveHead:streamer", -1, true, xPlayer.source, name)
			end
		else
			TriggerClientEvent('chatMessage', xPlayer.source, 'شما استریمر نیستید.')
		end
	end)
end, {
}, '.streamer', '.')

ESX.RunCustomFunction("AddCommand", "setstreamer", 5, function(xPlayer, args)
	if args.isStreamer == 0 or args.isStreamer == 1 then
		MySQL.Async.execute('UPDATE users SET `isStreamer` = @isStreamer WHERE identifier = @identifier', {
			['@identifier'] = args.playerId.identifier,
			['@isStreamer'] = args.isStreamer
		}, function(rowsChanged)
			
		end)
	else
		TriggerClientEvent('chatMessage', xPlayer.source, 'عدد مجاز 0 و 1 می باشد.')
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'isStreamer', type = 'number'},
}, '.streamer', '.')

------------ functions and events ------------
RegisterNetEvent("Master_AdminPanel:GetAdutyList")
AddEventHandler("Master_AdminPanel:GetAdutyList", function()
	TriggerClientEvent("IDAboveHead:SetAdutyList", source, AdminAdutyList, StreamerList, NewPlayers)
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = data
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
	end
end)

AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    local identifier = GetPlayerIdentifier(_source)
	
	if not identifier then
		return
	end
	local xPlayer = ESX.GetPlayerFromId(_source)
    timePlay[identifier] = {source = _source, joinTime = os.time(), timePlay = 0}
    MySQL.Async.fetchAll("SELECT total_time FROM users WHERE identifier = @identifier", { ["@identifier"] = identifier }, function(result)
        if result then
            local timePlayP = tonumber(result[1].total_time)
            timePlay[identifier].timePlay = timePlayP
            
            if timePlayP < 21600 then
				NewPlayers[_source] = "New"
				xPlayer.set('isNew', true)
				TriggerClientEvent("IDAboveHead:newPlayer", -1, true, _source, "New")
            end
			
        end
    end)
end)

ESX.RegisterServerCallback('master_adminpanel:getPlayTime', function(cb, psrc)
	local playerId = psrc
	
	if playerId == nil then
		cb(0)
		return
	end
	
	local identifier = GetPlayerIdentifier(playerId)
	if identifier ~= nil and timePlay[identifier] ~= nil then
		local leaveTime = os.time()
		local saveTime = (leaveTime - timePlay[identifier].joinTime) + timePlay[identifier].timePlay
		cb(saveTime)
	else
		cb(0)
	end
end)

AddEventHandler('esx:playerDropped', function(source, reason)
	-- empty tables when player no longer online
	
	local playerId = source
	
	if playerId == nil then
		return
	end
	
	local identifier = GetPlayerIdentifier(playerId)
	if identifier ~= nil and timePlay[identifier] ~= nil then
		local leaveTime = os.time()
		local saveTime = leaveTime - timePlay[identifier].joinTime

		MySQL.Async.execute('UPDATE users SET total_time = total_time + @total_time, last_leave = NOW() WHERE identifier=@identifier', 
		{
			['@identifier'] = identifier,
			['@total_time'] = saveTime
		}, function() end)
		
		timePlay[identifier] = nil
	end
	
	AdminAdutyList[playerId] = nil
	TriggerClientEvent("IDAboveHead:aduty", -1, false, playerId, "")
	StreamerList[playerId] = nil
	TriggerClientEvent("IDAboveHead:streamer", -1, false, playerId, "")
	NewPlayers[playerId] = nil
	TriggerClientEvent("IDAboveHead:newPlayer", -1, false, playerId, "")

	if onTimer[playerId] then
		onTimer[playerId] = nil
	end
    if savedCoords[playerId] then
    	savedCoords[playerId] = nil
    end
	if warnedPlayers[playerId] then
		warnedPlayers[playerId] = nil
	end
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
	end
end)

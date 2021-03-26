ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onTimer       = {}
local savedCoords   = {}
local warnedPlayers = {}
local deadPlayers   = {}

ESX.RunCustomFunction("AddCommand", {"tpm", "tp"}, 1, function(xPlayer, args)
	TriggerClientEvent("esx_admin:tpm", xPlayer.source)
end, {
}, '.tpm', '.')

ESX.RunCustomFunction("AddCommand", {"adminzone", "az"}, 1, function(xPlayer, args)
	TriggerClientEvent('esx_admin:az', xPlayer.source)
end, {
}, '.az', '.')

ESX.RunCustomFunction("AddCommand", "tpl", 1, function(xPlayer, args)
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
	end
	
	TriggerClientEvent('chatMessage', xPlayer.source, output)
end, {
}, '.info', '.')

ESX.RunCustomFunction("AddCommand", {"coords", "gps"}, 1, function(xPlayer, args)
	output = "موقعیت: " .. GetEntityCoords(GetPlayerPed(xPlayer.source)) .. " - سمت: " .. GetEntityHeading(GetPlayerPed(xPlayer.source))
	TriggerClientEvent('chatMessage', xPlayer.source, output)
end, {
}, '.coords', '.')

ESX.RunCustomFunction("AddCommand", {"ann", "announce"}, 1, function(xPlayer, args)
	TriggerClientEvent('chatMessageAlert', -1, _U('admin_announce', args.message))
end, {
	{name = 'message', type = 'full'}
}, '.announce message', '.')

ESX.RunCustomFunction("AddCommand", {"bring", "sum"}, 1, function(xPlayer, args)
	xTarget = args.playerId
	local targetCoords = xTarget.getCoords()
	local playerCoords = xPlayer.getCoords()
	savedCoords[xTarget.source] = targetCoords
	xTarget.setCoords(playerCoords)
	TriggerClientEvent("chatMessageAlert", xPlayer.source, _U('bring_adminside', xTarget.source))
	TriggerClientEvent("chatMessageAlert", xTarget.source, _U('bring_playerside'))
end, {
	{name = 'playerId', type = 'player'},
}, '.bring PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"bringback", "sumback"}, 1, function(xPlayer, args)
	xTarget = args.playerId
	local playerCoords = savedCoords[xTarget.source]
	if playerCoords then
		xTarget.setCoords(playerCoords)
		TriggerClientEvent("chatMessageAlert", xPlayer.source, _U('bringback_admin', 'BRINGBACK', xTarget.source))
		TriggerClientEvent("chatMessageAlert", xTarget.source,  _U('bringback_player', 'BRINGBACK'))
		savedCoords[xTarget.source] = nil
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.bringback PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"goto", "app"}, 1, function(xPlayer, args)
	local xTarget =args.playerId
	if xTarget then
		local targetCoords = xTarget.getCoords()
		local playerCoords = xPlayer.getCoords()
		savedCoords[xPlayer.source] = playerCoords
		xPlayer.setCoords(targetCoords)
		TriggerClientEvent("chatMessage", xPlayer.source, _U('goto_admin', args[1]))
		TriggerClientEvent("chatMessage", xTarget.source,  _U('goto_player'))
	else
		TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'GOTO'))
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.goto PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"goback", "gotoback", "appback"}, 1, function(xPlayer, args)
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
	TriggerClientEvent("esx_admin:noclip", xPlayer.source)
end, {
}, '.noclip', '.')

ESX.RunCustomFunction("AddCommand", {"kill", "slay", "die"}, 1, function(xPlayer, args)
	local xTarget = args.playerId
	if xTarget then
		TriggerClientEvent("esx_admin:killPlayer", xTarget.source)
		TriggerClientEvent("chatMessage", xPlayer.source, _U('kill_admin', targetId))
		TriggerClientEvent('chatMessage', xTarget.source, _U('kill_by_admin'))
	else
		TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'KILL'))
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.slay PlayerID', '.')


ESX.RunCustomFunction("AddCommand", "freeze", 1, function(xPlayer, args)
	local xTarget = args.playerId
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

ESX.RunCustomFunction("AddCommand", {"reviveall", "revall"}, 1, function(xPlayer, args)
	for i,data in pairs(deadPlayers) do
		TriggerClientEvent('esx_ambulancejob:revive', i)
	end
end, {
}, '.reviveall', '.')

ESX.RunCustomFunction("AddCommand", {"a", "achat", "adminchat"}, 1, function(xPlayer, args)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			if args[1] then
				local message = string.sub(rawCommand, 3)
				local xAll = ESX.GetPlayers()
				for i=1, #xAll, 1 do
					local xTarget = ESX.GetPlayerFromId(xAll[i])
					if havePermission(xTarget) then
						TriggerClientEvent('chatMessage', xTarget.source, _U('adminchat', xPlayer.getName(), xPlayer.getGroup(), message))
					end
				end
			else
				TriggerClientEvent('chatMessage', xPlayer.source, _U('invalid_input', 'AdminChat'))
			end
		end
	end
end, {
	{name = 'Message', type = 'text'},
}, '.a Message', '.')

-- EXTENDED COMMANDS
ESX.RunCustomFunction("AddCommand", "goxyz", 1, function(xPlayer, args)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, {
	{name = 'x', type = 'number'},
	{name = 'y', type = 'number'},
	{name = 'z', type = 'number'}
}, '.setcoords x y z', '.')

ESX.RunCustomFunction("AddCommand", "setjob", 10, function(xPlayer, args)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'job', type = 'string'},
	{name = 'grade', type = 'number'}
}, '.setjob PlayerID Job Grade', '.')

ESX.RunCustomFunction("AddCommand", {"setjobsub", "setsubjob", "setdivision"}, 10, function(xPlayer, args)
	args.playerId.setJobSub(args.jobSub:upper())
end, {
	{name = 'playerId', type = 'player'},
	{name = 'jobSub', type = 'string'}
}, '.setjobsub PlayerID jobSub', '.')

ESX.RunCustomFunction("AddCommand", "car", 1, function(xPlayer, args)
	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
end, {
	{name = 'car', type = 'any'},
}, '.car model', '.')

ESX.RunCustomFunction("AddCommand", "dv", 1, function(xPlayer, args)
	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
end, {
	{name = 'radius', type = 'any'},
}, '.dv radius(optional)', '.')

ESX.RunCustomFunction("AddCommand", "setaccountmoney", 10, function(xPlayer, args)
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'account', type = 'string'},
	{name = 'amount', type = 'number'}
}, '.setaccountmoney PlayerID Account Amount', '.')

ESX.RunCustomFunction("AddCommand", "giveaccountmoney", 10, function(xPlayer, args)
	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'account', type = 'string'},
	{name = 'amount', type = 'number'}
}, '.giveaccountmoney PlayerID Account Amount', '.')

ESX.RunCustomFunction("AddCommand", "giveitem", 1, function(xPlayer, args)
	args.playerId.addInventoryItem(args.item, args.count)
end, {
	{name = 'playerId', type = 'player'},
	{name = 'item', type = 'item'},
	{name = 'count', type = 'number'}
}, '.giveitem PlayerID item count', '.')

ESX.RunCustomFunction("AddCommand", "giveweapon", 1, function(xPlayer, args)
	if not args.playerId.hasWeapon(args.weapon) then
		xPlayer.addWeapon(args.weapon, args.ammo)
	end
end, {
	{name = 'playerId', type = 'player'},
	{name = 'weapon', type = 'weapon'},
	{name = 'ammo', type = 'number'}
}, '.giveweapon PlayerID weapon ammo', '.')

ESX.RunCustomFunction("AddCommand", {"clearinventory", "removeitems"}, 1, function(xPlayer, args)
	for k,v in ipairs(args.playerId.inventory) do
		if v.count > 0 then
			args.playerId.setInventoryItem(v.name, 0)
		end
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.clearinventory PlayerID', '.')

ESX.RunCustomFunction("AddCommand", {"clearloadout", "removeguns"}, 1, function(xPlayer, args)
	for k,v in ipairs(args.playerId.loadout) do
		args.playerId.removeWeapon(v.name)
	end
end, {
	{name = 'playerId', type = 'player'},
}, '.clearloadout PlayerID', '.')

--[[
ESX.RegisterCommand('setgroup', 'admin', function(xPlayer, args, showError)
	args.playerId.setGroup(args.group)
end, true, {help = _U('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = _U('command_setgroup_group'), type = 'string'},
}})]]--

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

ESX.RunCustomFunction("AddCommand", "saveall", 1, function(xPlayer, args)
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


------------ functions and events ------------
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

AddEventHandler('esx:playerDropped', function(playerId, reason)
	-- empty tables when player no longer online
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

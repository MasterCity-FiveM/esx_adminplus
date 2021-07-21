ESX = nil
local godmode = false
local isAdmin = false
local RPPauses = {}

local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49,
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33,
	}
}

---- DRIFT Configs
local kmh = 3.6
local mph = 2.23693629
local carspeed = 0
local removeCARSAttach = false
-----------------
--   E D I T   --
-----------------
local driftmode = false -- on/off speed
local speed = kmh -- or mph
local drift_speed_limit = 100.0 
local toggle = 118 -- Numpad 9
---- DRIFT Configs

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
	
	Citizen.Wait(5000)
	TriggerServerEvent('Master_AdminPanel:IsIamAdmin')
	TriggerServerEvent('Master_AdminPanel:GetRPPauses')
end)

RegisterNetEvent("Master_AdminPanel:YouAreAdmin")
AddEventHandler("Master_AdminPanel:YouAreAdmin", function(status)
	isAdmin = status
end)

RegisterNetEvent("esx_adminplus:removeobject")
AddEventHandler("esx_adminplus:removeobject", function()
	Citizen.CreateThread(function()
		local ped = GetPlayerPed(-1)
		local handle, object = FindFirstObject()
		local finished = false
		repeat
			Wait(1)
			local wait = 1
			
			if object and IsEntityAttached(object) then
				NetworkRequestControlOfEntity(object)
				while not NetworkHasControlOfEntity(object) do
					NetworkRequestControlOfEntity(object)
					Citizen.Wait(0)
					if wait > 50 then
						break
					end
					wait = wait + 1
				end
				ReqAndDelete(object, true)
			end
			finished, object = FindNextObject(handle)
		until not finished
		EndFindObject(handle)
	end)
end)

RegisterNetEvent("esx_adminplus:removecars")
AddEventHandler("esx_adminplus:removecars", function()
	Citizen.CreateThread(function()
		local ped = GetPlayerPed(-1)
		local cars = GetGamePool('CVehicle')

		for _, car in pairs(cars) do
			local wait = 1
			
			if car and IsEntityAttached(car) then
				NetworkRequestControlOfEntity(car)
				while not NetworkHasControlOfEntity(car) do
					NetworkRequestControlOfEntity(car)
					Citizen.Wait(0)
					if wait > 40 then
						break
					end
					wait = wait + 1
				end
				ReqAndDelete(car, true)
			end
		end
	end)
end)

RegisterNetEvent("esx_adminplus:removecarsAuto")
AddEventHandler("esx_adminplus:removecarsAuto", function(status)
	removeCARSAttach = false
	Citizen.Wait(500)
	removeCARSAttach = status
	removeAttachedCars()
end)

function removeAttachedCars()
	Citizen.CreateThread(function()
		while removeCARSAttach do
			Citizen.Wait(100)
			local ped = GetPlayerPed(-1)
			local cars = GetGamePool('CVehicle')

			for _, car in pairs(cars) do
				local wait = 1
				
				if car and IsEntityAttached(car) then
					NetworkRequestControlOfEntity(car)
					while not NetworkHasControlOfEntity(car) do
						NetworkRequestControlOfEntity(car)
						Citizen.Wait(0)
						if wait > 40 then
							break
						end
						wait = wait + 1
					end
					ReqAndDelete(car, true)
				end
			end
		end
	end)
end

function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		local wait = 1
		while not NetworkHasControlOfEntity(object) do
			if wait > 200 then
				break
			end
			wait = wait + 1
			Citizen.Wait(1)
		end
		if detach then
			DetachEntity(object, 0, false)
		end
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end

RegisterNetEvent("Master_AdminPanel:GetRPPauses")
AddEventHandler("Master_AdminPanel:GetRPPauses", function(List)
	if List == nil then
		RPPauses = {}
	else
		RPPauses = List
		startRPPause()
	end
end)

local RPLoopStarted = false
local NearLocation = nil

function startRPPause()
	if RPLoopStarted == true then
		return
	end
	Citizen.CreateThread(function()
		RPLoopStarted = true
		while #RPPauses ~= 0 do
			Citizen.Wait(0)
			local playerCoords = GetEntityCoords(PlayerPedId())
			for k,v in ipairs(RPPauses) do
				rpp = RPPauses[k]
				distance = GetDistanceBetweenCoords(playerCoords, rpp.coords, true)
				if distance < rpp.radius + 100 then
				
					if distance > rpp.radius and distance < rpp.radius + 2 and NearLocation ~= nil and not isAdmin then
						SetPedCoordsKeepVehicle(PlayerPedId(), NearLocation.x, NearLocation.y, NearLocation.z + 0.5)
					elseif distance >= rpp.radius + 3 then
						NearLocation = playerCoords
					elseif distance >= rpp.radius - 2 and distance <= rpp.radius and not isAdmin then
						SetPedCoordsKeepVehicle(PlayerPedId(), rpp.coords.x, rpp.coords.y, rpp.coords.z + 0.5)
					end
					
					if distance < rpp.radius then
						showMessage('شما در منطقه توقف PR هستید.')
					end
					
					local color = randomColor(1)
					DrawMarker(28, rpp.coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, rpp.radius - 0.2, rpp.radius - 0.2, rpp.radius - 0.2, color.r, color.g, color.b, 190, false, false, 2, false, false, false, false)
				end
			end
		end
		NearLocation = nil
		RPLoopStarted = false
	end)
end

local UnderShowMessage = false
function showMessage(msg)
	Citizen.CreateThread(function()
		if UnderShowMessage == false then
			UnderShowMessage = true
			Citizen.CreateThread(function()
				exports.pNotify:SendNotification({text = msg, type = "error", timeout = 5000})
				Citizen.Wait(10000)
				UnderShowMessage = false
			end)
		end
	end)
end

function randomColor(f)
    local g = {}
    local h = GetGameTimer() / 1000
    g.r = math.floor(math.sin(h * f + 0) * 127 + 128)
    g.g = math.floor(math.sin(h * f + 2) * 127 + 128)
    g.b = math.floor(math.sin(h * f + 4) * 127 + 128)
    return g
end

function missionTextDisplay(c, d)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(c)
    DrawSubtitleTimed(d, 1)
end
----------------------------------------------------------------------------------


TriggerEvent('chat:addSuggestion', '/drift_on', 'Drift On', {})
RegisterCommand('drift_on', function(source, args, raw)
	driftmode = true
	DriftOn()
end)

TriggerEvent('chat:addSuggestion', '/drift_off', 'Drift off', {})
RegisterCommand('drift_off', function(source, args, raw)
	driftmode = false
end)

function DriftOn()
	Citizen.CreateThread(function()
		while driftmode do
			Citizen.Wait(1)
			if IsPedInAnyVehicle(GetPlayerPed(-1) , false) then
				CarSpeed = GetEntitySpeed(GetCar()) * speed
				if GetPedInVehicleSeat(GetCar(), -1) == GetPlayerPed(-1)  then
					if CarSpeed <= drift_speed_limit then 
						if IsControlPressed(1, 21) then
							SetVehicleReduceGrip(GetCar(), true)
						else
							SetVehicleReduceGrip(GetCar(), false)
						end
					end
				else
					driftmode = false
				end
			else
				driftmode = false
			end
		end
	end)
end

function GetCar() return GetVehiclePedIsIn(GetPlayerPed(-1),false) end

RegisterNetEvent("esx_admin:killPlayer")
AddEventHandler("esx_admin:killPlayer", function()
  SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('esx_admin:carfix')
AddEventHandler('esx_admin:carfix', function()
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn( vehicle, true, true )
		SetVehicleFixed(vehicle)
	end
end)

RegisterNetEvent('esx_admin:carclean')
AddEventHandler('esx_admin:carclean', function()
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleDirtLevel(vehicle, 0)
	end
end)

RegisterNetEvent('master_adminpanel:eventRequest')
AddEventHandler('master_adminpanel:eventRequest', function(playerCoords, message)
	exports.pNotify:SendNotification({text = '[EVENT]: ' .. message, type = "error", timeout = 10000})
	local elements = {
		{label = 'خیر', value = 'nevermind'},
		{label = 'بله', value = 'join_EVENT'},
	}
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'EventJoin', {
		title    = 'آیا میخواهید به ایونت بروید؟',
		align    = 'right',
		elements = elements
	}, function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'EventJoin2', {
			title    = 'آیا مطمئن هستید؟',
			align    = 'right',
			elements = {
				{label = 'خیر', uniform = 'no'},
				{label = 'بله', value = 'yes'},
			}
		}, function(data2, menu2)
			if data.current.value == 'join_EVENT' and data2.current.value == 'yes' then
				menu.close()
				menu2.close()
				ESX.Game.Teleport(PlayerPedId(), playerCoords, function() end)
			elseif data.current.value == 'nevermind' and data2.current.value == 'yes' then
				menu.close()
				menu2.close()
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent("esx_admin:freezePlayer")
AddEventHandler("esx_admin:freezePlayer", function(input)
    local player = PlayerId()
	local ped = PlayerPedId()
    if input == 'freeze' then
        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        SetPlayerInvincible(player, true)
    elseif input == 'unfreeze' then
        SetEntityCollision(ped, true)
	    FreezeEntityPosition(ped, false)
        SetPlayerInvincible(player, false)
    end
end)

TriggerEvent('chat:addSuggestion', '/record_editor', 'Open Editor', {})
RegisterCommand('record_editor', function(source, args, raw)
	TriggerEvent("masterking32:closeAllUI")
	NetworkSessionLeaveSinglePlayer()
	ActivateRockstarEditor()
end)

TriggerEvent('chat:addSuggestion', '/record_start', 'Start Recording', {})
RegisterCommand('record_start', function(source, args, raw)
	if not IsRecording() then
		TriggerEvent("masterking32:closeAllUI")
		StartRecording(1)
	else
		TriggerEvent("chatMessage", "شما در حال ضبط می باشید!")
	end
end)

TriggerEvent('chat:addSuggestion', '/record_startreplay', 'Start Recording Replay', {})
RegisterCommand('record_startreplay', function(source, args, raw)
	if not IsRecording() then
		TriggerEvent("masterking32:closeAllUI")
		StartRecording(0)
	else
		TriggerEvent("chatMessage", "شما در حال ضبط می باشید!")
	end
end)

TriggerEvent('chat:addSuggestion', '/record_discard', 'Discard Recording', {})
RegisterCommand('record_discard', function(source, args, raw)
	if IsRecording() then
		TriggerEvent("masterking32:closeAllUI")
		StopRecordingAndDiscardClip()
	else
		TriggerEvent("chatMessage", "ابتدا ضبط را شروع کنید!")
	end
end)

TriggerEvent('chat:addSuggestion', '/record_save', 'Save Recording', {})
RegisterCommand('record_save', function(source, args, raw)
	if IsRecording() then
		TriggerEvent("masterking32:closeAllUI")
		StopRecordingAndSaveClip()
	else
		TriggerEvent("chatMessage", "ابتدا ضبط را شروع کنید!")
	end
end)

-------- noclip --------------
local noclip = false
RegisterNetEvent("esx_admin:noclip")
AddEventHandler("esx_admin:noclip", function(input)
    local player = PlayerId()
	local ped = PlayerPedId
	
    local msg = "غیرفعال"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(PlayerPedId(), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "فعال"
	end

	TriggerEvent("chatMessage", "حالت نو کلیپ: " .. msg)
	end)
	
	local heading = 0
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(noclip)then
			SetEntityCoordsNoOffset(PlayerPedId(), noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

			if(IsControlPressed(1, 34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end

				SetEntityHeading(PlayerPedId(), heading)
			end

			if(IsControlPressed(1, 8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
			end

			if(IsControlPressed(1, 32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1, 27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 1.0)
			end

			if(IsControlPressed(1, 173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, -1.0)
			end
		else
			Citizen.Wait(200)
		end
	end
end)

--Thanks to qalle for this code | https://github.com/qalle-fivem/esx_marker
RegisterNetEvent("esx_admin:tpm")
AddEventHandler("esx_admin:tpm", function()
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)

                break
            end

            Citizen.Wait(5)
        end
        TriggerEvent('chatMessage', _U('teleported'))
    else
        TriggerEvent('chatMessage', _U('set_waypoint'))
    end
end)

RegisterNetEvent("esx_admin:tpl")
AddEventHandler("esx_admin:tpl", function(x, y)
	for height = 1, 1000 do
		SetPedCoordsKeepVehicle(PlayerPedId(), x, y, height + 0.0)

		local foundGround, zPos = GetGroundZFor_3dCoord(x, y, height + 0.0)

		if foundGround then
			SetPedCoordsKeepVehicle(PlayerPedId(), x, y, height + 0.0)
			break
		end

		Citizen.Wait(5)
	end
	TriggerEvent('chatMessage', _U('teleported'))

end)

RegisterNetEvent("esx_admin:az")
AddEventHandler("esx_admin:az", function()
	SetPedCoordsKeepVehicle(PlayerPedId(), -2824.681, 7027.042, 2184.085)
end)

function cleanPlayer(playerPed)
    SetPedArmour(playerPed, 0)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end

function setUniform(rank)
    local playerPed = PlayerPedId()
    
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
			TriggerEvent("skinchanger:loadClothes", skin, Config.Admin[rank].male)
		else
			TriggerEvent("skinchanger:loadClothes", skin, Config.Admin[rank].female)
		end
    end)
end

RegisterNetEvent("esx_admin:aduty")
AddEventHandler("esx_admin:aduty", function(status, rank)
    if status == true then
        setUniform(rank)
		godmode = true
		Citizen.CreateThread(function() --Godmode
			while godmode do
				Citizen.Wait(1)

				SetEntityInvincible(GetPlayerPed(-1), true)
				SetPlayerInvincible(PlayerId(), true)
				SetPedCanRagdoll(GetPlayerPed(-1), false)
				ClearPedBloodDamage(GetPlayerPed(-1))
				ResetPedVisibleDamage(GetPlayerPed(-1))
				ClearPedLastWeaponDamage(GetPlayerPed(-1))
				SetEntityProofs(GetPlayerPed(-1), true, true, true, true, true, true, true, true)
				SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), false)
				SetEntityCanBeDamaged(GetPlayerPed(-1), false)
			end
			
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPlayerInvincible(PlayerId(), false)
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			ClearPedLastWeaponDamage(GetPlayerPed(-1))
			SetEntityProofs(GetPlayerPed(-1), false, false, false, false, false, false, false, false)
			SetEntityOnlyDamagedByPlayer(GetPlayerPed(-1), true)
			SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		end)
    else
		godmode = false
		
		TriggerEvent('skinchanger:getSkin', function(skin)
			TriggerEvent("skinchanger:loadClothes", skin, Config.CleanSkin)
			Citizen.CreateThread(function()
				Citizen.Wait(100)
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end)
		end)
    end 
end)

RegisterNetEvent("esx_admin:dbg")
AddEventHandler("esx_admin:dbg", function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		local model = nil
		if skin.sex == 0 then
			model = GetHashKey("mp_m_freemode_01")
		else
			model = GetHashKey("mp_f_freemode_01")
		end
		RequestModel(model)
		while not HasModelLoaded(model) do
		RequestModel(model)
			Citizen.Wait(1)
		end
		
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)

function GetClosestPlayer(radius)
    local playerPed = PlayerPedId()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local targetSrc = GetPlayerServerId(closestPlayer)
	if closestPlayer ~= -1 and targetSrc ~= -1 and closestDistance < 3 then
		local closestPlayerPed = GetPlayerPed(closestPlayer)
		if IsPedDeadOrDying(closestPlayerPed, 1) or IsEntityPlayingAnim(closestPlayerPed, 'missminuteman_1ig_2', 'handsup_base', 3) or IsEntityPlayingAnim(closestPlayerPed, "amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", 1) then
			return closestPlayer
		else
			showMessage('شما فقط امکان حمل شهروندی را دارید که در کماست و یا دستانش بالاست.')
			return false
		end					
	else
		showMessage('شهروندی نزدیک شما نیست')
		return false
	end
end

local function ensureAnimDict(animDict)
    if not HasAnimDictLoaded(animDict) then
        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end        
    end
    return animDict
end

TriggerEvent('chat:addSuggestion', '/carry', 'Carry a Player', {})
RegisterCommand('carry', function(source, args, raw)
	if not carry.InProgress then
		local closestPlayer = GetClosestPlayer()
		if closestPlayer ~= false then
			local targetSrc = GetPlayerServerId(closestPlayer)
			if targetSrc ~= -1 then
				TriggerServerEvent("master_adminpanel:request_carry", targetSrc)
			end
		end
	else
		TriggerServerEvent("master_adminpanel:stopcarry")
	end
end)

RegisterNetEvent("master_adminpanel:carryaplayer")
AddEventHandler("master_adminpanel:carryaplayer", function(targetSrc)
	carry.InProgress = true
	carry.targetSrc = targetSrc
	ensureAnimDict(carry.personCarrying.animDict)
	carry.type = "carrying"
	CarryPlayer()
end)

RegisterNetEvent("master_adminpanel:carrytarget")
AddEventHandler("master_adminpanel:carrytarget", function(targetSrc)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
	carry.InProgress = true
	ensureAnimDict(carry.personCarried.animDict)
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, carry.personCarried.attachX, carry.personCarried.attachY, carry.personCarried.attachZ, 0.5, 0.5, 180, false, false, false, false, 2, false)
	carry.type = "beingcarried"
	carry.targetSrc = targetSrc
	CarryPlayer()
end)

RegisterNetEvent("master_adminpanel:stopcarry")
AddEventHandler("master_adminpanel:stopcarry", function()
	carry.InProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
	carry.targetSrc = 0
end)

function CarryPlayer()
	Citizen.CreateThread(function()
		while carry.InProgress do
			if carry.type == "beingcarried" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
				end
			elseif carry.type == "carrying" then
				if not IsEntityPlayingAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
					TaskPlayAnim(PlayerPedId(), carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
				end
			end
			
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 21, true) -- RUN
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			Wait(0)
		end
	end)
end
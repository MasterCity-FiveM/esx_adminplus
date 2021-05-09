ESX = nil
local godmode = false


---- DRIFT Configs
local kmh = 3.6
local mph = 2.23693629
local carspeed = 0
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
end)
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
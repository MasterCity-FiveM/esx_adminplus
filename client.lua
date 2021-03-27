ESX = nil
local godmode = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)
----------------------------------------------------------------------------------
RegisterNetEvent("esx_admin:killPlayer")
AddEventHandler("esx_admin:killPlayer", function()
  SetEntityHealth(PlayerPedId(), 0)
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


-------- noclip --------------
local noclip = false
RegisterNetEvent("esx_admin:noclip")
AddEventHandler("esx_admin:noclip", function(input)
    local player = PlayerId()
	local ped = PlayerPedId
	
    local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(PlayerPedId(), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "Noclip has been ^2^*" .. msg)
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
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
        end)
    end 
end)
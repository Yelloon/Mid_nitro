local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
mid = module("mid_nitro", "config")

local instalando = false
local instalado = false
local turbo = nil
local CarroID = nil


if mid.comando then 
    RegisterCommand(mid.registercommand, function()
        CreateThread(function()
            ped = PlayerPedId()
            while not instalando do
                Wait(1)
                pCDS = GetEntityCoords(ped)
                veh = GetClosestVehicle(pCDS, 3.001, 0, 71)
                local Engine = GetEntityBoneIndexByName(veh, 'engine')
                local localEngine =  GetWorldPositionOfEntityBone(veh, Engine)
                local dist = #(pCDS - localEngine)
                if dist < 4 then
                    DrawMarker(mid.TypeDraw, localEngine[1], localEngine[2], localEngine[3]+1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, mid.ColorR, mid.ColorG, mid.ColorB, 255, true, true, 2, true)
                    if dist < 2 then
                        if IsControlJustPressed(0, 38) and not instalado then
                            instalado = true
                            instalando = true
                            RequestAnimDict('mini@repair')
                            while not HasAnimDictLoaded('mini@repair') do
                                Wait(10)
                            end
                            TaskPlayAnim(ped, "mini@repair", "fixing_a_player", 5.0, 5.0, -1, 1, 0, 0.0, 0.0, 0.0)
                            PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", veh, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
                            SetVehicleDoorOpen(veh, 4, 0, 0)
                            FreezeEntityPosition(ped, true)
                            FreezeEntityPosition(veh, true)
                            TriggerEvent(mid.progress,5000,"INSERINDO NITRO")
                            SetTimeout(5000, function()
                                PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
                                turbo = 100
                                CarroID = veh
                                instalado = false
                                instalando = false
                                nitro()
                                ClearPedTasks(ped)
                                SetVehicleDoorShut(veh, 4, 0)
                                FreezeEntityPosition(ped, false)
                                FreezeEntityPosition(veh, false)
                            end)
                        end
                    end
                end
            end
        end)
    end)
else 
    RegisterNetEvent("mid:ActiveNitro")
    AddEventHandler("mid:ActiveNitro", function()
        CreateThread(function()
            ped = PlayerPedId()
            while not instalando do
                Wait(1)
                pCDS = GetEntityCoords(ped)
                veh = GetClosestVehicle(pCDS, 3.001, 0, 71)
                local Engine = GetEntityBoneIndexByName(veh, 'engine')
                local localEngine =  GetWorldPositionOfEntityBone(veh, Engine)
                local dist = #(pCDS - localEngine)
                if dist < 4 then
                    DrawMarker(mid.TypeDraw, localEngine[1], localEngine[2], localEngine[3]+1.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, mid.ColorR, mid.ColorG, mid.ColorB, 255, true, true, 2, true)
                    if dist < 2 then
                        if IsControlJustPressed(0, 38) and not instalado then
                            instalado = true
                            instalando = true
                            RequestAnimDict('mini@repair')
                            while not HasAnimDictLoaded('mini@repair') do
                                Wait(10)
                            end
                            TaskPlayAnim(ped, "mini@repair", "fixing_a_player", 5.0, 5.0, -1, 1, 0, 0.0, 0.0, 0.0)
                            PlaySoundFromEntity(-1, "Bar_Unlock_And_Raise", veh, "DLC_IND_ROLLERCOASTER_SOUNDS", 0, 0)
                            SetVehicleDoorOpen(veh, 4, 0, 0)
                            FreezeEntityPosition(ped, true)
                            FreezeEntityPosition(veh, true)
                            TriggerEvent(mid.progress,5000,"APLICANDO NITRO")
                            SetTimeout(5000, function()
                                PlaySoundFrontend(-1, "Lowrider_Upgrade", "Lowrider_Super_Mod_Garage_Sounds", 1)
                                turbo = 100
                                CarroID = veh
                                instalado = false
                                instalando = false
                                nitro()
                                ClearPedTasks(ped)
                                SetVehicleDoorShut(veh, 4, 0)
                                FreezeEntityPosition(ped, false)
                                FreezeEntityPosition(veh, false)
                            end)
                        end
                    end
                end
            end
        end)
    end)
end 


function nitro()
    CreateThread(function()
        while turbo > 0 do
            Wait(1)
            if IsControlPressed(0, 254) and GetEntitySpeed(CarroID) >= 1 and veh == CarroID then
                SetVehicleCheatPowerIncrease(CarroID, 5.0)
                ModifyVehicleTopSpeed(CarroID, 20.0)
                FogoNoScape(CarroID, 0.5)
                TurboOn = true
                MudarTela(true)
            else
                SetVehicleCheatPowerIncrease(CarroID, 1.0)
                ModifyVehicleTopSpeed(CarroID, 1.0)
                TurboOn = false
                MudarTela(false)
            end
        end
    end)

    CreateThread(function()
        while turbo > 0 do
            Wait(1)

            if TurboOn == true and GetEntitySpeed(CarroID) >= 1 and GetPedInVehicleSeat(CarroID, -1) then
                Wait(100)
                turbo = turbo -1
            end
        end
    end)
end

function FogoNoScape(CarroID, Longitude)

    local escapes = {
      "exhaust",
      "exhaust_2",
      "exhaust_3",
      "exhaust_4",
      "exhaust_5",
      "exhaust_6",
      "exhaust_7",
      "exhaust_8",
      "exhaust_9",
      "exhaust_10",
      "exhaust_11",
      "exhaust_12",
      "exhaust_13",
      "exhaust_14",
      "exhaust_15",
      "exhaust_16"
    }
  
    for k,v in ipairs(escapes) do
        BoneEscape = v 
        local escapeID = GetEntityBoneIndexByName(CarroID, BoneEscape)
        if escapeID > -1 then
            local Escape = GetWorldPositionOfEntityBone(CarroID, escapeID)
            local localEscape = GetOffsetFromEntityGivenWorldCoords(CarroID, Escape)
            UseParticleFxAssetNextCall('core')
            StartParticleFxNonLoopedOnEntity('veh_backfire', CarroID, localEscape, 0.0, 0.0, 0.0, Longitude, false, false, false)
        end
    end
end

function MudarTela(status)
    if status == true then
        StopScreenEffect('RaceTurbo')
        StartScreenEffect('RaceTurbo', 0, false)
        SetTimecycleModifier('rply_motionblur')
    else
        SetTransitionTimecycleModifier('default', 0.35)
    end
end

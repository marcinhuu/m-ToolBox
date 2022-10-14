local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()


-- Simple Event's , you can create yours and put on qb-menu :)

RegisterNetEvent('m-ToolBox:Client:GiveCleaningKit')
AddEventHandler("m-ToolBox:Client:GiveCleaningKit", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar(Language.CleaningKit)
    TriggerServerEvent("m-ToolBox:Server:AddItem", "cleaningkit", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cleaningkit"], "add", 1)
end)

RegisterNetEvent('m-ToolBox:Client:GiveRepairKit')
AddEventHandler("m-ToolBox:Client:GiveRepairKit", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar(Language.RepairKit)
    TriggerServerEvent("m-ToolBox:Server:AddItem", "repairkit", 1)
    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["repairkit"], "add", 1)
end)

RegisterNetEvent('m-ToolBox:Client:RepairVehicle', function()
    local playerPed = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if vehicle ~= nil and vehicle ~= 0 then
        QBCore.Functions.TriggerCallback("m-ToolBox:Server:HaveAdvancedRepairKit", function(hasItem)
            if hasItem then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                QBCore.Functions.Progressbar("RemoverPen", "Repairing the vehicle...", 12000, false, true, {
                disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {
                animDict = "mini@repair", anim = "fixing_a_player", flags = 15, }, {}, {}, function() end)
                Wait(12000)
                FreezeEntityPosition(vehicle, true)  
                SetVehicleFixed(vehicle)
                SetVehicleEngineHealth(vehicle, 1000.0)
                SetVehicleBodyHealth(vehicle, 1000.0)
                SetVehiclePetrolTankHealth(vehicle, 1000.0)
                SetVehicleDirtLevel(vehicle, 0)
                SetVehicleOnGroundProperly(vehicle)  
                FreezeEntityPosition(vehicle, false)
                SetVehicleEngineHealth(vehicle, 1000.0)
                SetVehicleEngineOn(vehicle, true, false)
                SetVehicleTyreFixed(vehicle, 0)
                SetVehicleTyreFixed(vehicle, 1)
                SetVehicleTyreFixed(vehicle, 2)
                SetVehicleTyreFixed(vehicle, 3)
                SetVehicleTyreFixed(vehicle, 4)
                ClearPedTasks(ped)
                Notify("Vehicle repaired!", "success", 5000)
                TriggerServerEvent('m-ToolBox:Server:RemoveItem', 'repairkit', 1)
                TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['repairkit'], 'remove', 1)
            else
                Notify("You dont have any repair kit!", "error", 5000)
            end
        end)
    end
end)


RegisterNetEvent('m-ToolBox:Client:MenuToolBox', function()
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then return Notify(Language.Dead, "error") end
    if IsPedSwimming(playerPed) then return Notify(Language.Water, "error") end
    if IsPedSittingInAnyVehicle(playerPed) then return Notify(Language.Veiculo, "error") end
    local job = QBCore.Functions.GetPlayerData().job.name
    if Config.Utility.NeedJob == true then
        if job ~= Config.Utility.Job then
            Notify(Language.NoJob)
            return false
        end
    end
    exports['qb-menu']:openMenu({
        { header = "[⚙️] Tool Box", txt = "", isMenuHeader = true },
        { header = "[🧰] Open ToolBox",  params = { event = "m-ToolBox:Client:StorageToolBox" } },
        { header = "[🧽] Cleaning Kit",  params = { event = "m-ToolBox:Client:GiveCleaningKit" } },
        { header = "[🔩] Repair Kit",    params = { event = "m-ToolBox:Client:GiveRepairKit" } },
        -- You can add more menus with your's personal events...
        { header = "", txt = "❌ Close", params = { event = "qb-menu:closeMenu" } },
    })
end)


local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()


-- Simple Event's , you can create yours and put on qb-menu :)

RegisterNetEvent('m-ToolBox:Client:GiveCleaningKit')
AddEventHandler("m-ToolBox:Client:GiveCleaningKit", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar(Language.CleaningKit)
    TriggerServerEvent(Config.Utility.AddItem, "cleaningkit", 1)
    TriggerEvent(Config.Utility.ItemBox, QBCore.Shared.Items["cleaningkit"], "add", 1)
end)

RegisterNetEvent('m-ToolBox:Client:GiveRepairKit')
AddEventHandler("m-ToolBox:Client:GiveRepairKit", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar(Language.RepairKit)
    TriggerServerEvent(Config.Utility.AddItem, "repairkit", 1)
    TriggerEvent(Config.Utility.ItemBox, QBCore.Shared.Items["repairkit"], "add", 1)
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


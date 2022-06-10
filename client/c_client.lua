local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()

local ObjectList = {}

RegisterNetEvent('m-ToolBox:Client:SpawnToolBox', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    local spawnedObj = CreateObject(Config.Utility.ToolBox[type].model, x, y, z, true, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Utility.ToolBox[type].freeze)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = vector3(x, y, z - 0.3),
    }
end)

RegisterNetEvent('m-ToolBox:Client:spawnLight', function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar(Language.PutToolBox)
    Wait(2500)
    TriggerServerEvent("m-ToolBox:Server:SpawnToolBox", "toolbox")
end)

RegisterNetEvent('m-ToolBox:Client:GuardarToolBox')
AddEventHandler("m-ToolBox:Client:GuardarToolBox", function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
    local ToolBox = GetClosestObjectOfType(playerPedPos, 10.0, GetHashKey("imp_prop_tool_cabinet_01b"), false, false, false)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD")
    progressBar(Language.SaveToolBox)
    Wait(2500)
    Notify(Language.ToolBoxSave)
    SetEntityAsMissionEntity(ToolBox, 1, 1)
    DeleteObject(ToolBox)
end)

AddEventHandler("m-ToolBox:Client:StorageToolBox", function()
    TriggerEvent(Config.Utility.StashInvTrigger, Config.Utility.NameOfStash)
    TriggerServerEvent(Config.Utility.OpenInvTrigger, "stash", Config.Utility.NameOfStash, {
        maxweight = Config.Utility.MaxWeighStash,
        slots = Config.Utility.MaxSlotsStash,
    })
end)

local ToolBoxs = {
    `imp_prop_tool_cabinet_01b`,
}

exports['qb-target']:AddTargetModel(ToolBoxs, {
    options = {{event   = "m-ToolBox:Client:MenuToolBox",icon    = "fa-solid fa-wrench",label   = Language.ToolBox },
    {event   = "m-ToolBox:Client:GuardarToolBox",icon    = "fa-solid fa-wrench",label   = Language.Save },},distance = 2.0 })



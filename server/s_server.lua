local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()

local Objects = {}

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

QBCore.Functions.CreateUseableItem('toolbox', function(source, item)TriggerClientEvent("m-ToolBox:Client:spawnLight", source)end)
QBCore.Functions.CreateUseableItem('repairkit', function(source, item) TriggerClientEvent("m-ToolBox:Client:RepairVehicle", source) end)

RegisterNetEvent('m-ToolBox:Server:SpawnToolBox', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("m-ToolBox:Client:SpawnToolBox", src, objectId, type, src)
end)

RegisterNetEvent('m-ToolBox:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)

RegisterNetEvent('m-ToolBox:Server:AddItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount)
end)


QBCore.Functions.CreateCallback("m-ToolBox:Server:HaveRepairKit", function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local repairkit = Ply.Functions.GetItemByName("repairkit")
    if repairkit ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

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

QBCore.Functions.CreateUseableItem('toolbox', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("m-ToolBox:Client:spawnLight", source)
    end
end)

RegisterNetEvent('m-ToolBox:Server:SpawnToolBox', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("m-ToolBox:Client:SpawnToolBox", src, objectId, type, src)
end)

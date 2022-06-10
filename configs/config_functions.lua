local QBCore = exports[Config.Utility.CoreName]:GetCoreObject()
-- Notifys
function Notify(msg)
    QBCore.Functions.Notify(msg)
end

-- Progressbars
function progressBar(msg)
    QBCore.Functions.Progressbar("Toolbox", msg, 2500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()end)
end
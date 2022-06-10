Config = {}

---------------
-- 𝗨𝗧𝗜𝗟𝗜𝗧𝗬
---------------
Config.Utility = {
    CoreName = "qb-core", -- Core Name
    ItemBox = "inventory:client:ItemBox", 
    ToolBox = {
    	["toolbox"] = {model = `imp_prop_tool_cabinet_01b`, freeze = false}, -- Prop spawn with item "machine" to brake rocks
	},
    StashInvTrigger = "inventory:client:SetCurrentStash",
	OpenInvTrigger = "inventory:server:OpenInventory",
	AddItem = "QBCore:Server:AddItem",
	NameOfStash = "toolbox",
	MaxWeighStash = 50000,
	MaxSlotsStash = 50,
	NeedJob = true,
	Job = "mechanic",
}


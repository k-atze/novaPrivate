-- This piece of code is in ServerScriptService
-- serverscript

local services = {
	playerService = game:GetService("Players"),
	radioService = require(game.ServerScriptService.radioService),
	replicatedStorage = game:GetService("ReplicatedStorage")
}

-- HOOK A
-- This hook onto the radioservice will send a message if the player has their radio out

services.playerService.PlayerAdded:Connect(function(plr)
	plr:SetAttribute("selectedRadioCategory", "KURULUŞ")
	
	plr.Chatted:Connect(function(msg)
		local char = plr.Character
		
		if not char:FindFirstChild("Telsiz") then
			return
		end
		
		services.radioService.sendRadioMessage(plr, msg, plr:GetAttribute("selectedRadioCategory"))
	end)
end)

services.replicatedStorage.radioContent.plrCategoryUpdate.OnServerEvent:Connect(function(plr, cat)
	plr:SetAttribute("selectedRadioCategory", cat)
end)


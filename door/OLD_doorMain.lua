-- THIS SCRIPT WILL BE REPLACED

-- This script is in serverScriptService
-- serverscript

local services = {
	promptService = game:GetService("ProximityPromptService"),
	tweenService = game:GetService("TweenService")
}

local globalConfig = require(script:FindFirstChild("_globalDoorConfig"))

-- RULESET 

local denyClr = BrickColor.new("Really red")
local acceptClr = BrickColor.new("Lime green")
local defaultClr = BrickColor.new("Medium stone grey")

local acceptSound = "rbxassetid://200888468"
local denySound = "rbxassetid://200888510"

local soundTable = {
	["gateOpen"] = "rbxassetid://7509847163",
	["gateClose"] = "rbxassetid://7509830749",
	["labOpen"] = "rbxassetid://4917012884",
	["labClose"] = "rbxassetid://4917012884",
	["civOpen"] = "rbxassetid://833871080",
	["civClose"] = "rbxassetid://7038967181"
}

-- FUNCTIONS

function validatePlayer(configFile : ModuleScript, plr : Player)
	for i, v in ipairs(configFile.acc) do
		
		if not plr.Backpack:FindFirstChild(v) then
			continue
		end
		
		return true 

	end
end

function playRegionalSound(px : ProximityPrompt, soundId : number, delayTime : number)
	local pxPart = px.Parent
	
	local soundInstance = Instance.new("Sound")
	soundInstance.Parent = pxPart
	soundInstance.Looped = false
	soundInstance.SoundId = soundId
	
	if delayTime then
		wait(delayTime)
		soundInstance:Play()
	else
		soundInstance:Play()
	end
	
	soundInstance:Play()
	soundInstance.Ended:Connect(function()
		soundInstance:Destroy()
	end)
end

function castDoorTypeToSound(doorId : number)
	if doorId >= 1 and doorId <= 4 then
		return table.pack(soundTable["labOpen"], soundTable["labClose"])
	end
	
	if doorId >= 5 and doorId <= 6 then
		return table.pack(soundTable["civOpen"], soundTable["civClose"])
	end
	
	return table.pack(soundTable["gateOpen"], soundTable["gateClose"])
end

-- MAIN

services.promptService.PromptTriggered:Connect(function(px : ProximityPrompt, plr : Player)
	if px.ActionText ~= "_DOOR_PROMPT" then
		return
	end
	
	px.Enabled = false
	
	local doorConfig = require(px.Parent.Parent:WaitForChild("config"):FindFirstChildWhichIsA("ModuleScript"))
	local doorL, doorR, doorMain
	if not px.Parent.Parent:FindFirstChild("_DOOR") then
		doorL = px.Parent.Parent:FindFirstChild("_LEFT"):FindFirstChild("_MAIN")
		doorR = px.Parent.Parent:FindFirstChild("_RIGHT"):FindFirstChild("_MAIN")
	else
		doorMain = px.Parent.Parent:FindFirstChild("_DOOR"):FindFirstChild("_MAIN")
	end
	local readerModels = px.Parent.Parent:WaitForChild("_READERS")
	if not validatePlayer(doorConfig, plr) then
		playRegionalSound(px, denySound)
		
		readerModels:FindFirstChild("_LIGHT1").BrickColor = denyClr
		readerModels:FindFirstChild("_LIGHT2").BrickColor = denyClr
		
		wait(3)
		readerModels:FindFirstChild("_LIGHT1").BrickColor = defaultClr
		readerModels:FindFirstChild("_LIGHT2").BrickColor = defaultClr
		
		px.Enabled = true
		
		return
	end
	readerModels:FindFirstChild("_LIGHT1").BrickColor = acceptClr
	readerModels:FindFirstChild("_LIGHT2").BrickColor = acceptClr
	
	playRegionalSound(px, acceptSound)
	wait(1)
	
	local doorType = doorConfig.doorType
	if px.ObjectText == "_OPEN" then
		if globalConfig[tostring(doorType)].hasTwoInputs == true then
			local packedTable = globalConfig[tostring(doorType)]["openTween"](doorL, doorR)
			services.tweenService:Create(packedTable[1], packedTable[2], packedTable[3]):Play()
			services.tweenService:Create(packedTable[4], packedTable[5], packedTable[6]):Play()
		else
			local packedTable = globalConfig[tostring(doorType)]["openTween"](doorMain)
			services.tweenService:Create(packedTable[1], packedTable[2], packedTable[3]):Play()
		end
		
		playRegionalSound(px, castDoorTypeToSound(doorType)[1])
		wait(3)
		px.ObjectText = "_CLOSE"
		readerModels:FindFirstChild("_LIGHT1").BrickColor = defaultClr
		readerModels:FindFirstChild("_LIGHT2").BrickColor = defaultClr
		
		px.Enabled = true
		return
	end
	
	if globalConfig[tostring(doorType)].hasTwoInputs == true then
		local packedTable = globalConfig[tostring(doorType)]["closeTween"](doorL, doorR)
		local doorLCloseTween = services.tweenService:Create(packedTable[1], packedTable[2], packedTable[3]); doorLCloseTween:Play()
		local doorRCloseTween = services.tweenService:Create(packedTable[4], packedTable[5], packedTable[6]); doorRCloseTween:Play()
	else
		 local packedTable = globalConfig[tostring(doorType)]["closeTween"](doorMain)
		 local oneDoorCloseTween = services.tweenService	:Create(packedTable[1], packedTable[2], packedTable[3]); oneDoorCloseTween:Play()
	end
	
	if typeof(globalConfig[tostring(doorType)]["closeTween"](px.Parent, px.Parent)[#globalConfig[tostring(doorType)]["closeTween"](px.Parent, px.Parent)]) == "boolean" then
		playRegionalSound(px, castDoorTypeToSound(doorType)[2], globalConfig[tostring(doorType)]["closeTween"](px.Parent, px.Parent)[2].Time - 0.1)
	else
		playRegionalSound(px, castDoorTypeToSound(doorType)[2])
	end
	
	wait(3)
	px.ObjectText = "_OPEN"
	readerModels:FindFirstChild("_LIGHT1").BrickColor = defaultClr
	readerModels:FindFirstChild("_LIGHT2").BrickColor = defaultClr
	
	px.Enabled = true		
end)

-- i am ashamed of this code

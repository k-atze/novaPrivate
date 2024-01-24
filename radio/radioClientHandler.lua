-- This piece of code is in the radio UI.

local services = {
	replicatedStorage = game:GetService("ReplicatedStorage")
}

local radioFolder = services.replicatedStorage:FindFirstChild("radioContent")

local msgFrame = script.Parent:FindFirstChild("contentWrapper"):FindFirstChild("ScrollingFrame")
local headers = script.Parent:FindFirstChild("headerWrapper")

local plr = game.Players.LocalPlayer

local function loadMessages()
	local selectedCategory = plr:GetAttribute("selectedRadioCategory")
	
	for i, v in ipairs(msgFrame:GetChildren()) do
		if not v:IsA("Frame") then
			continue
		end
		
		v:Destroy()
	end
	
	for i, v : Frame in ipairs(radioFolder:FindFirstChild(selectedCategory):GetChildren()) do
		local clone = v:Clone()
		clone.Parent = msgFrame
	end
end

local function updateCategory(cat) 
	radioFolder.plrCategoryUpdate:FireServer(cat)
	plr:GetAttributeChangedSignal("selectedRadioCategory"):Wait()
end

plr.CharacterAdded:Connect(function()
	-- ACCESS HANDLER / FILL IN LATER
	
	updateCategory("KURULUŞ")
	loadMessages()
end)

headers.kurulusButton.MouseButton1Click:Connect(function()
	updateCategory("KURULUŞ")
	loadMessages()
end)

headers.askeriButton.MouseButton1Click:Connect(function()
	updateCategory("ASKERİ")
	loadMessages()
end)

headers.taleplerButton.MouseButton1Click:Connect(function()
	updateCategory("TALEPLER")
	loadMessages()
end)

radioFolder.radioShouldUpdate.OnClientEvent:Connect(function()
	loadMessages()
end)

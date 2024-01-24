-- This piece of code is in ServerScriptService 
-- moduleScript

local service = {}

-- Global Service Constants --

local RBLXServices = {
	players = game:GetService("Players"),
	replicatedStorage = game:GetService("ReplicatedStorage"),
	runService = game:GetService("RunService")
}

local frameFolder = RBLXServices.replicatedStorage:FindFirstChild("radioContent")
local anncFrame = frameFolder:FindFirstChild("_announcement")
local msgFrame = frameFolder:FindFirstChild("_message")

function xor(A : boolean, B : boolean)
	local AandnotB =  (A and (not B))
	local notAandB = ((not A) and B)
	
	return AandnotB or notAandB
end

-- Main --

if RBLXServices.runService:IsClient() then
	return error("[ERR] radioService cannot be called on the Client.")
end

service.sendRadioMessage = function(sendingPlayer : Player, msgContent : string, category : string, isSystem : boolean, teamString : string, teamClr : Color3)
	if not xor((sendingPlayer ~= nil), (isSystem)) then
		return error("[ERR] Invalid input for RadioService.")
	end
	
	local clone
	if isSystem then
		clone = anncFrame:Clone()
		clone:FindFirstChild("anncMsg").Text = msgContent
	else
		clone = msgFrame:Clone()
    
		clone:FindFirstChild("msgName").Text = sendingPlayer.Name or sendingPlayer
		clone:FindFirstChild("msgContent").Text = msgContent
		clone:FindFirstChild("teamName").Text = teamString or sendingPlayer.Team:GetAttribute("shortenedName")
		clone:FindFirstChild("teamName").TextColor3 = teamClr or sendingPlayer.TeamColor.Color
		clone:FindFirstChild("teamClrFrame").BackgroundColor3 = teamClr or sendingPlayer.TeamColor.Color
		clone:FindFirstChild("timeSent").Text = `XX:{DateTime.now():FormatLocalTime("mm", "en-us")}`
		
		if sendingPlayer then
			clone:FindFirstChild("plrHead").Image = RBLXServices.players:GetUserThumbnailAsync(sendingPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
		else
			clone:FindFirstChild("plrHead").ImageTransparency = 1
		end
		
		
	end
	
	clone.Parent = frameFolder[category]
	frameFolder.radioShouldUpdate:FireAllClients()
end

return service

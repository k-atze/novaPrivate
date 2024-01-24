-- This script is in ServerScriptService, inside doorMain
-- modulescript

local tweenService = game:GetService("TweenService")

local globalconfig = {
	["1"] = {
		["openTween"] = function(inst : Part) 
			return table.pack(inst, TweenInfo.new(
				1.5,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.Out
				),
				
				{
					CFrame = inst.CFrame * CFrame.new(0,7.4,0)
				}
			)
		end,
		
		["closeTween"] = function(inst : Part) 
			return table.pack(inst, TweenInfo.new(
				1.5,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.In
				),
				
				{
					CFrame = inst.CFrame * CFrame.new(0,-7.4,0)
				}
				
			)
		end,
		
		hasTwoInputs = false
	},
	
	["2"] = {
		["openTween"] = function(instL: Part, instR: Part) 
			return table.pack(
				instL,
				TweenInfo.new(1.5,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.Out
				),
				{
					CFrame = instL.CFrame * CFrame.new(0,0,-1.6)
				},
				instR,
				TweenInfo.new(1.5,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.Out
				),
				{
					CFrame = instR.CFrame * CFrame.new(0,0,1.6)
				}
			)
		end,
		
		["closeTween"] = function(instL: Part, instR: Part) 
			return table.pack(
				instL,
				TweenInfo.new(1.5,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.In
				),
				{
					CFrame = instL.CFrame * CFrame.new(0,0,1.6)
				},
				instR,
				TweenInfo.new(1.5,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.In
				),
				{
					CFrame = instR.CFrame * CFrame.new(0,0,-1.6)
				}
			)
		end,
		
		hasTwoInputs = true
	},
	
	
	["3"] = {
		["openTween"] = function(inst : Part) 
			return table.pack(inst, TweenInfo.new(
				1.5,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.Out
				),

				{
					CFrame = inst.CFrame * CFrame.new(0,-4,0)
				}
			)
		end,

		["closeTween"] = function(inst : Part) 
			return table.pack(inst, TweenInfo.new(
				1.5,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.In
				),

				{
					CFrame = inst.CFrame * CFrame.new(0,4,0)
				}

			)
		end,

		hasTwoInputs = false
	},
	
	["4"] = {
		["openTween"] = function(inst : Part) 
			return table.pack(inst, TweenInfo.new(
				1.5,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.Out
				),

				{
					CFrame = inst.CFrame * CFrame.new(0,7.4,0)
				}
			)
		end,

		["closeTween"] = function(inst : Part) 
			return table.pack(inst, TweenInfo.new(
				1.5,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.In
				),

				{
					CFrame = inst.CFrame * CFrame.new(0,-7.4,0)
				}

			)
		end,

		hasTwoInputs = false
	},
	
	["5"] = {
		["openTween"] = function(inst : Part) 
			return table.pack(inst, TweenInfo.new(
				0.7,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.Out
				),

				{
					CFrame = inst.CFrame * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))
				}
			)
		end,

		["closeTween"] = function(inst : Part) 
			return table.pack(inst, TweenInfo.new(
				0.7,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.In
				),

				{
					CFrame = inst.CFrame * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))
				},
				true

			)
		end,

		hasTwoInputs = false
	},
	
	["6"] = {
		["openTween"] = function(instL: Part, instR: Part) 
			return table.pack(
				instL,
				TweenInfo.new(.7,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.Out
				),
				{
					CFrame = instL.CFrame * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))
				},
				instR,
				TweenInfo.new(.7,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.Out
				),
				{
					CFrame = instR.CFrame * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))
				}
			)
		end,

		["closeTween"] = function(instL: Part, instR: Part) 
			return table.pack(
				instL,
				TweenInfo.new(.7,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.In
				),
				{
					CFrame = instL.CFrame * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))
				},
				instR,
				TweenInfo.new(.7,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.In
				),
				{
					CFrame = instR.CFrame * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))
				},
				true
			)
		end,

		hasTwoInputs = true
	},
	
	["7"] = {
		["openTween"] = function(instL: Part, instR: Part) 
			return table.pack(
				instL,
				TweenInfo.new(3.9,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.Out
				),
				{
					CFrame = instL.CFrame * CFrame.new(0, 0, -5.4)
				},
				instR,
				TweenInfo.new(3.9,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.Out
				),
				{
					CFrame = instR.CFrame * CFrame.new(-5.4, 0, 0)
				}
			)
		end,

		["closeTween"] = function(instL: Part, instR: Part) 
			return table.pack(
				instL,
				TweenInfo.new(3.1,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.In
				),
				{
					CFrame = instL.CFrame * CFrame.new(0, 0, 5.4)
				},
				instR,
				TweenInfo.new(3.1,
					Enum.EasingStyle.Linear,
					Enum.EasingDirection.In
				),
				{
					CFrame = instR.CFrame * CFrame.new(5.4, 0, 0)
				}
			)
		end,

		hasTwoInputs = true
	}
}

return globalconfig

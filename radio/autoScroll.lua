-- This piece of code is in the UI, inside the scrollingFrame
-- Roblox's AutoCanvasSize is broken; this is a remedy.
-- localscript

local uiLayout = script.Parent.UIListLayout
local scrollFrame = script.Parent

uiLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, uiLayout.AbsoluteContentSize.Y)
	scrollFrame.CanvasPosition = Vector2.new(0, uiLayout.AbsoluteContentSize.Y)
end)

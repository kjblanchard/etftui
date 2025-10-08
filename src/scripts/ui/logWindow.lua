local logWindow = {}
local engine = require("Engine")
local tui = require("TUI")

local ptr = nil
-- local timeTextPtr = nil
local messageTextPtr = nil
local previousMessages = {}

local function logFunc(timeMessage, message, logLevel)
    -- tui.UpdateText(messageTextPtr, timeMessage .. " | " .. message)
end

function logWindow.InitializeLogWindow()
    engine.Log.SetLogFunction(logFunc)
    ptr = tui.NewPanelWithNameAndBorder(140, 10, 2, 65, "Debug Log")
    messageTextPtr = tui.NewText(ptr, 0, 0, "Initial Debug Message\nSecondMessage\n")
    tui.AddTextToPanel(ptr, messageTextPtr)
    -- engine.Log.LogWarn("What even is this message")
end

function logWindow.Draw()
    if ptr ~= nil then
        tui.DrawPanel(ptr)
    end
end

return logWindow

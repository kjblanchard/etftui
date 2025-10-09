local logWindow = {}
local engine = require("Engine")
local tui = require("TUI")

local panelPtr = nil
local messageTextPtr = nil
local logMessagePrefix = ""


local function logFunc(timeMessage, message, logLevel)
    local messageText = string.format("%s%s | %s", logMessagePrefix, timeMessage, message)
    local colorPair = engine.Log.LogColorsWhite
    if logLevel == engine.Log.LogLevelsWarn then
        colorPair = engine.Log.LogColorsYellow
    elseif logLevel == engine.Log.LogLevelsError or logLevel == engine.Log.LogLevelsCritical then
        colorPair = engine.Log.LogColorsRed
    end
    if messageTextPtr then
        tui.AddTextToTextbox(messageTextPtr, messageText, colorPair)
    end
    if logMessagePrefix == "" then
        logMessagePrefix = "\n"
    end
end

function logWindow.InitializeLogWindow()
    engine.Log.SetLogFunction(logFunc)
    panelPtr = tui.NewPanelWithNameAndBorder(140, 10, 2, 65, "Debug Log")
    messageTextPtr = tui.NewText(panelPtr, 0, 0, "")
    tui.AddTextToPanel(panelPtr, messageTextPtr)
end

function logWindow.Draw()
    if panelPtr ~= nil then
        tui.DrawPanel(panelPtr)
    end
end

return logWindow

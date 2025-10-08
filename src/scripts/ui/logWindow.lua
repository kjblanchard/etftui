local logWindow = {}
local engine = require("Engine")
local tui = require("TUI")

local panelPtr = nil
local messageTextPtr = nil
local messageText = ""
local numPreviousMessages = 0


local function logFunc(timeMessage, message, logLevel)
    if numPreviousMessages == 0 then
        messageText = string.format("%s | %s", timeMessage, message)
        numPreviousMessages = numPreviousMessages + 1
    elseif numPreviousMessages < 30 then
        messageText = string.format("%s\n%s | %s", messageText, timeMessage, message)
        numPreviousMessages = numPreviousMessages + 1
    else
        local firstNewline = string.find(messageText, "\n")
        if firstNewline then
            messageText = string.sub(messageText, firstNewline + 1)
        end
        messageText = string.format("%s\n%s | %s", messageText, timeMessage, message)
    end
    if messageTextPtr then
        tui.UpdateText(messageTextPtr, messageText)
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

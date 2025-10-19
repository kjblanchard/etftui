local logWindow = {}
local engine = require("Engine")
local tui = require("TUI")
local panelPtr = nil
logWindow.messageTextPtr = nil
local logMessagePrefix = ""
local windowConfig = { x = 84, y = 63, w = 160, h = 10 }
local setColor = function(colorInt) tui.AddColor(logWindow.messageTextPtr, colorInt) end
local function reset()
    tui.SetTextboxStyle(logWindow.messageTextPtr, engine.Log.LogStyleDefault)
    setColor(engine.Log.LogColorsWhite)
end
local formatActions = {
    red    = function() setColor(engine.Log.LogColorsRed) end,
    white  = function() setColor(engine.Log.LogColorsWhite) end,
    yellow = function() setColor(engine.Log.LogColorsYellow) end,
    bold   = function() tui.SetTextboxStyle(logWindow.messageTextPtr, engine.Log.LogStyleBold) end,
    normal = function() tui.SetTextboxStyle(logWindow.messageTextPtr, engine.Log.LogStyleDefault) end,
    reset  = reset,
}


function logWindow.AddFormattedText(str)
    -- -- second piece is reges .. they are capture groups so it will return it in pairs.
    -- -- word, tag.  Capture text before { and then capture text before }.  So text and command
    for text, command in string.gmatch(logMessagePrefix .. str .. "{}", "(.-){(.-)}") do
        -- Add the text before the first tag
        if #text > 0 then
            tui.AddTextToTextbox(logWindow.messageTextPtr, text)
        end
        if formatActions[command] then
            formatActions[command]()
        end
    end
    reset()
    if logMessagePrefix == "" then
        logMessagePrefix = "\n"
    end
end

function logWindow.InitializeLogWindow()
    panelPtr = tui.NewPanelWithNameAndBorder(windowConfig.x, windowConfig.y, windowConfig.w, windowConfig.h, "Log")
    logWindow.messageTextPtr = tui.NewText(panelPtr, 0, 0, "")
    tui.AddTextToPanel(panelPtr, logWindow.messageTextPtr)
end

function logWindow.Draw()
    if panelPtr ~= nil then
        tui.DrawPanel(panelPtr)
    end
end

return logWindow

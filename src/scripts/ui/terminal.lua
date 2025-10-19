local terminal = {}
local tui = require("TUI")
local engine = require("Engine")

local panelPtr = nil
local messageTextPtr = nil
local windowConfig = { x = 250, y = 63, w = 30, h = 3 }
local textTable = {}
local shouldUpdateText = false


-- Command table: map command string to function
local commandActions = {
    quit = function()
        engine.Quit()
    end,
}

function terminal.Initialize()
    panelPtr = tui.NewPanelWithNameAndBorder(windowConfig.x, windowConfig.y, windowConfig.w, windowConfig.h,
        "Terminal")
    messageTextPtr = tui.NewText(panelPtr, 0, 0, "")
    tui.AddTextToPanel(panelPtr, messageTextPtr)
    -- tui.SetPanelFocus(panelPtr, true)
end

function terminal.Draw()
    if panelPtr then
        if shouldUpdateText then
            tui.UpdateText(messageTextPtr, table.concat(textTable))
            shouldUpdateText = false
        end
        tui.DrawPanel(panelPtr)
    end
end

function terminal.Run()
    local keysPressedString = engine.Input.GetKeysPressedThisFrame()
    for i = 1, #keysPressedString do
        local ch = keysPressedString:byte(i)
        if ch == 10 then -- newline / Enter
            local commandStr = table.concat(textTable)
            if commandActions[commandStr] then commandActions[commandStr]() end
            textTable = {}
            shouldUpdateText = true
        elseif ch == 8 or ch == 127 then -- Backspace
            if #textTable > 0 then
                table.remove(textTable)
                shouldUpdateText = true
            end
        else
            table.insert(textTable, string.char(ch))
            shouldUpdateText = true
        end
    end
end

return terminal

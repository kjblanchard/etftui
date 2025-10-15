-- debug_terminal.lua
local terminal = {}
local tui = require("TUI")
local engine = require("Engine")

-- Panel and text pointers
local panelPtr = nil
local messageTextPtr = nil
local windowConfig = { x = 2, y = 2, w = 100, h = 20 }

-- Message prefix for newlines (like your working snippet)
local messagePrefix = ""

-- Command table: map command string to function
local commandActions = {
    echo = function(args)
        terminal.AddFormattedText(table.concat(args, " "))
    end,
    help = function()
        terminal.AddFormattedText("Available commands: echo, help, clear")
    end,
    clear = function()
        -- This assumes you have a C function to clear the textbox
        if messageTextPtr then
            tui.ClearTextbox(messageTextPtr)
        end
        messagePrefix = ""
    end
}

-- Adds text to the terminal, with optional prepended newline
function terminal.AddFormattedText(str)
    if messagePrefix ~= "" then
        str = messagePrefix .. str
    end
    tui.AddTextToTextbox(messageTextPtr, str)
    messagePrefix = "\n"
end

-- Initializes the terminal panel
function terminal.Initialize()
    panelPtr = tui.NewPanelWithNameAndBorder(windowConfig.x, windowConfig.y, windowConfig.w, windowConfig.h,
        "Debug Terminal")
    messageTextPtr = tui.NewText(panelPtr, 0, 0, "")
    tui.AddTextToPanel(panelPtr, messageTextPtr)
end

-- Draws the terminal
function terminal.Draw()
    if panelPtr then
        tui.DrawPanel(panelPtr)
    end
end

-- Executes a debug command string
function terminal.ExecuteCommand(cmdStr)
    local words = {}
    for word in string.gmatch(cmdStr, "%S+") do
        table.insert(words, word)
    end
    local cmd = table.remove(words, 1)
    if commandActions[cmd] then
        commandActions[cmd](words)
    else
        terminal.AddFormattedText("Unknown command: " .. tostring(cmd))
    end
end

-- Example interactive loop (requires a C function to get input)
function terminal.Run()
    while true do
        local input = tui.GetUserInput("> ") -- <-- you’d need to implement this in C
        if input then
            terminal.ExecuteCommand(input)
            terminal.Draw()
        else
            break
        end
    end
end

return terminal

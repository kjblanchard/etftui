local engine = require("Engine")
local config = require("gameConfig")
local debugLogWindow = require("ui.debugLogWindow")
local logWindow = require("ui.logWindow")
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- local gamestate = require("gameState")
-- local messageTimer = 0.0
-- local messageTime = 1.0

local function handleInput()
    engine.Input.Update()
end

local function update()
    engine.EngineUpdate()
    if engine.Input.KeyboardKeyJustPressed('q') then
        engine.Quit()
    end
    -- messageTimer = messageTimer + gamestate.DeltaTimeSeconds
    -- if messageTimer > messageTime then
    --     logWindow.AddFormattedText(
    --         "Start this, {red}{bold}This is a debug message{reset} and this is {yellow}yellow")
    --     engine.Log.LogError("Is work?")
    --     engine.Log.LogWarn("Is work warn?")
    --     messageTimer = messageTimer - messageTime
    -- end
end

local function draw()
    debugLogWindow.Draw()
    logWindow.Draw()
end


engine.Window.SetWindowOptions(960, 540, "Escape The Fate")
engine.SetUpdateFunc(update)
engine.SetInputFunc(handleInput)
engine.SetDrawFunc(draw)
engine.Audio.SetGlobalBGMVolume(config.audio.bgmVolume)
engine.Audio.SetGlobalSFXVolume(config.audio.sfxVolume)
engine.Audio.PlayBGM("town2")
debugLogWindow.InitializeLogWindow()
logWindow.InitializeLogWindow()

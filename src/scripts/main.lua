local engine = require("Engine")
local config = require("gameConfig")
local logWindow = require("ui.logWindow")
local gamestate = require("gameState")
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local messageTimer = 0.0
local messageTime = 1.0

local function handleInput()
    engine.Input.Update()
end

local function update()
    engine.EngineUpdate()
    messageTimer = messageTimer + gamestate.DeltaTimeSeconds
    if messageTimer >= messageTime then
        engine.Log.LogWarn(string.format("The time is %f", messageTimer, messageTimer * 3))
        messageTimer = messageTimer - messageTime
    end
    if engine.Input.KeyboardKeyJustPressed('q') then
        engine.Quit()
    end
end

local function draw()
    logWindow.Draw()
end


engine.Window.SetWindowOptions(960, 540, "Escape The Fate")
engine.SetUpdateFunc(update)
engine.SetInputFunc(handleInput)
engine.SetDrawFunc(draw)
engine.Audio.SetGlobalBGMVolume(config.audio.bgmVolume)
engine.Audio.SetGlobalSFXVolume(config.audio.sfxVolume)
engine.Audio.PlayBGM("town2")
logWindow.InitializeLogWindow()
engine.Log.LogError("Bad error")

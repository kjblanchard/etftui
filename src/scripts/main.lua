local engine = require("Engine")
local config = require("gameConfig")
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end


local function handleInput()
    engine.Input.Update()
end


local function update()
    engine.EngineUpdate()
end

local function draw()
end


engine.Window.SetWindowOptions(960, 540, "Escape The Fate")
engine.SetUpdateFunc(update)
engine.SetInputFunc(handleInput)
engine.SetDrawFunc(draw)
engine.Audio.SetGlobalBGMVolume(config.audio.bgmVolume)
engine.Audio.SetGlobalSFXVolume(config.audio.sfxVolume)
engine.Audio.PlayBGM("town2")

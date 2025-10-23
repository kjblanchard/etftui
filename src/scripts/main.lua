local engine = require("Engine")
local config = require("gameConfig")
local shader = nil
local texture = nil
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end


local function handleInput()
    -- engine.Input.Update()
end


local function update()
    -- engine.EngineUpdate()
end

local function draw()
    if texture and shader then
        engine.DrawTexture(texture, shader, 0, 0)
    end
end


engine.Window.SetWindowOptions(480, 270, "Escape The Fate")
engine.SetUpdateFunc(update)
engine.SetInputFunc(handleInput)
engine.SetDrawFunc(draw)
engine.Audio.SetGlobalBGMVolume(config.audio.bgmVolume)
engine.Audio.SetGlobalSFXVolume(config.audio.sfxVolume)
engine.Audio.PlayBGM("town2")
shader = engine.CreateShader("2dSpriteVertex", "2dSpriteFragment")
texture = engine.CreateTexture("test")

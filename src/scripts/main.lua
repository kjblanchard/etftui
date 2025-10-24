local engine = require("Engine")
local config = require("gameConfig")
local gameState = require("gameState")
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local player = {
    playerGO = nil,
    x = 0,
    y = 0,
    playerSprite = nil,
    moveSpeed = 100
}


local function handleInput()
end

local function playerInput()
    local moved = false
    local velocityX = 0
    local velocityY = 0
    if engine.Input.KeyboardKeyDown(engine.Input.Buttons.UP) then
        velocityY = -1
        moved = true
    end
    if engine.Input.KeyboardKeyDown(engine.Input.Buttons.RIGHT) then
        velocityX = 1
        moved = true
    end
    if engine.Input.KeyboardKeyDown(engine.Input.Buttons.LEFT) then
        velocityX = -1
        moved = true
    end
    if engine.Input.KeyboardKeyDown(engine.Input.Buttons.DOWN) then
        velocityY = 1
        moved = true
    end
    if moved then
        local delta = gameState.DeltaTimeSeconds
        player.x = player.x + velocityX * player.moveSpeed * delta
        player.y = player.y + velocityY * player.moveSpeed * delta
        engine.Gameobject.SetPosition(player.playerGO, player.x, player.y)
    end
end


local function update()
    engine.EngineUpdate()
    playerInput()
end

local function draw()
end


engine.Window.SetWindowOptions(480, 270, "Escape The Fate")
engine.SetUpdateFunc(update)
engine.SetInputFunc(handleInput)
engine.SetDrawFunc(draw)
engine.Audio.SetGlobalBGMVolume(config.audio.bgmVolume)
engine.Audio.SetGlobalSFXVolume(config.audio.sfxVolume)
engine.Audio.PlayBGM("town2")
player.playerGO = engine.Gameobject.CreateGameObject()
engine.Gameobject.SetPosition(player.playerGO, 40, 40)
player.playerSprite = engine.Sprite.NewSprite("test", player.playerGO, { 0, 0, 48, 48 }, { 0, 0, 48, 48 })

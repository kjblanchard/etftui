local engine = require("Engine")
local config = require("gameConfig")
local gameState = require("gameState")

local Directions = {
    down = 0,
    right = 1,
    up = 2,
    left = 3
}

if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

local player = {
    playerGO = nil,
    playerAnimator = nil,
    x = 0,
    y = 0,
    playerSprite = nil,
    moveSpeed = 100,
    direction = Directions.down
}

local function handleInput()
end

local function setPlayerDirection(playerData)
    local animation = "walkD"
    if playerData.direction == Directions.up then
        animation = "walkU"
    elseif playerData.direction == Directions.right then
        animation = "walkR"
    elseif playerData.direction == Directions.left then
        animation = "walkL"
    end
    engine.Animation.PlayAnimation(playerData.playerAnimator, animation)
end

local function playerInput()
    local moved = false
    local velocityX = 0
    local velocityY = 0
    local direction = player.direction
    if engine.Input.KeyboardKeyDown(engine.Input.Buttons.UP) then
        velocityY = -1
        moved = true
        direction = Directions.up
    end
    if engine.Input.KeyboardKeyDown(engine.Input.Buttons.RIGHT) then
        velocityX = 1
        moved = true
        direction = Directions.right
    end
    if engine.Input.KeyboardKeyDown(engine.Input.Buttons.LEFT) then
        velocityX = -1
        moved = true
        direction = Directions.left
    end
    if engine.Input.KeyboardKeyDown(engine.Input.Buttons.DOWN) then
        velocityY = 1
        direction = Directions.down
        moved = true
    end
    local animatorSpeed = 0
    if moved then
        local delta = gameState.DeltaTimeSeconds
        player.x = player.x + velocityX * player.moveSpeed * delta
        player.y = player.y + velocityY * player.moveSpeed * delta
        engine.Gameobject.SetPosition(player.playerGO, player.x, player.y)
        if direction ~= player.direction then
            player.direction = direction
            setPlayerDirection(player)
        end
        animatorSpeed = 1.0
    end
    engine.Animation.SetAnimatorSpeed(player.playerAnimator, animatorSpeed)
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
player.playerSprite = engine.Sprite.NewSprite("player1", player.playerGO, { 0, 0, 32, 32 }, { 0, 0, 32, 32 })
player.playerAnimator = engine.Animation.CreateAnimator("player1", player.playerSprite)
engine.Sprite.SetScale(player.playerSprite, 2.0)

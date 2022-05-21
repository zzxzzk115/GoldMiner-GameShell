Gamestate = require 'hump.gamestate'
Class = require 'hump.class'
vector = require "hump.vector"
require 'GameStates'
require 'Animation'
require 'Util'

function love.load()
    -- Init fonts
    defaultFont = love.graphics.getFont()
    infoFont = love.graphics.newFont('fonts/Pixel-Square-10-1.ttf', 10)
    uiFont = love.graphics.newFont('fonts/Kurland.ttf', 20)
    gameFont = love.graphics.newFont('fonts/visitor1.ttf', 10)
    gameFontBig = love.graphics.newFont('fonts/Kurland.ttf', 16)
    love.graphics.setFont(infoFont)

    -- Init Sounds
    sounds = {
        ['hookReset'] = love.audio.newSource('audios/hook_reset.wav', 'static'),
        ['grabStart'] = love.audio.newSource('audios/grab_start.mp3', 'static'),
        ['grabBack'] = love.audio.newSource('audios/grab_back.wav', 'static'),
        ['High'] = love.audio.newSource('audios/high_value.wav', 'static'),
        ['Normal'] = love.audio.newSource('audios/normal_value.wav', 'static'),
        ['Low'] = love.audio.newSource('audios/low_value.wav', 'static')
    }

    -- Init musics
    musics = {
        ['goal'] = love.audio.newSource('audios/goal.mp3', 'stream')
    }

    -- Init backgrounds and sprites
    backgrounds = {
        ['LevelCommonTop'] = love.graphics.newImage('images/bg_top.png'),
        ['LevelA'] = love.graphics.newImage('images/bg_level_A.png'),
        ['Goal'] = love.graphics.newImage('images/bg_goal.png'),
        ['Title'] = love.graphics.newImage('images/text_goldminer.png'),
        ['Panel'] = love.graphics.newImage('images/panel.png'),
    }
    sprites = {
        ['MiniGold'] = love.graphics.newImage('images/gold_mini.png'),
        ['NormalGold'] = love.graphics.newImage('images/gold_normal.png'),
        ['BigGold'] = love.graphics.newImage('images/gold_big.png'),
        ['MiniRock'] = love.graphics.newImage('images/rock_mini.png'),
        ['NormalRock'] = love.graphics.newImage('images/rock_normal.png'),
        ['BigRock'] = love.graphics.newImage('images/rock_big.png'),
        ['QuestionBag'] = love.graphics.newImage('images/question_bag.png')
    }

    -- Init player's sheet and animations.
    playerSheet = love.graphics.newImage('images/miner_sheet.png')
    playerQuads = generateQuads(playerSheet, PLAYER_WIDTH, PLAYER_HEIGHT)
    playerIdleAnimation = Animation {
        frames = {1},
        interval = 1
    }
    playerGrabAnimation = Animation {
        frames = {3},
        interval = 1
    }
    playerGrabBackAnimation = Animation {
        frames = {1, 2, 3},
        interval = 0.13
    }

    -- Init hook's sheet and animations.
    hookSheet = love.graphics.newImage('images/hook_sheet.png')
    hookQuads = generateQuads(hookSheet, HOOK_WIDTH, HOOK_HEIGHT)
    hookIdleAnimation = Animation {
        frames = {1},
        interval = 1
    }
    hookGrabNormalAnimation = Animation {
        frames = {2},
        interval = 1
    }
    hookGrabMiniAnimation = Animation {
        frames = {3},
        interval = 1
    }

    -- Init RNG.
    math.randomseed(os.time())

    -- Init game states.
    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

function love.keypressed(key)
    -- Quit game
    if key == 'escape' then
        love.event.quit()
    end
end
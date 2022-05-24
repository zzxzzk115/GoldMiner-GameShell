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
    uiFontMini = love.graphics.newFont('fonts/Kurland.ttf', 10)
    gameFont = love.graphics.newFont('fonts/visitor1.ttf', 10)
    gameFontBig = love.graphics.newFont('fonts/Kurland.ttf', 16)
    love.graphics.setFont(infoFont)

    -- Init Sounds
    sounds = {
        ['Money'] = love.audio.newSource('audios/money.wav', 'static'),
        ['HookReset'] = love.audio.newSource('audios/hook_reset.wav', 'static'),
        ['GrabStart'] = love.audio.newSource('audios/grab_start.mp3', 'static'),
        ['GrabBack'] = love.audio.newSource('audios/grab_back.wav', 'static'),
        ['Explosive'] = love.audio.newSource('audios/explosive.wav', 'static'),
        ['High'] = love.audio.newSource('audios/high_value.wav', 'static'),
        ['Normal'] = love.audio.newSource('audios/normal_value.wav', 'static'),
        ['Low'] = love.audio.newSource('audios/low_value.wav', 'static'),
    }

    -- Init musics
    musics = {
        ['Goal'] = love.audio.newSource('audios/goal.mp3', 'stream'),
        ['MadeGoal'] = love.audio.newSource('audios/made_goal.mp3', 'stream'),
    }

    -- Init backgrounds and sprites
    backgrounds = {
        ['Menu'] = love.graphics.newImage('images/bg_start_menu.png'),
        ['LevelCommonTop'] = love.graphics.newImage('images/bg_top.png'),
        ['LevelA'] = love.graphics.newImage('images/bg_level_A.png'),
        ['LevelB'] = love.graphics.newImage('images/bg_level_B.png'),
        ['LevelC'] = love.graphics.newImage('images/bg_level_C.png'),
        ['LevelD'] = love.graphics.newImage('images/bg_level_D.png'),
        ['Goal'] = love.graphics.newImage('images/bg_goal.png'),
        ['Shop'] = love.graphics.newImage('images/bg_shop.png')
    }
    sprites = {
        -- Entities
        ['MiniGold'] = love.graphics.newImage('images/gold_mini.png'),
        ['NormalGold'] = love.graphics.newImage('images/gold_normal.png'),
        ['NormalGoldPlus'] = love.graphics.newImage('images/gold_normal_plus.png'),
        ['BigGold'] = love.graphics.newImage('images/gold_big.png'),
        ['MiniRock'] = love.graphics.newImage('images/rock_mini.png'),
        ['NormalRock'] = love.graphics.newImage('images/rock_normal.png'),
        ['BigRock'] = love.graphics.newImage('images/rock_big.png'),
        ['QuestionBag'] = love.graphics.newImage('images/question_bag.png'),
        ['Diamond'] = love.graphics.newImage('images/diamond.png'),
        -- UI
        ['MenuArrow'] = love.graphics.newImage('images/menu_arrow.png'),
        ['Panel'] = love.graphics.newImage('images/panel.png'),
        ['DialogueBubble'] = love.graphics.newImage('images/ui_dialogue_bubble.png'),
        ['Title'] = love.graphics.newImage('images/text_goldminer.png'),
        ['Selector'] = love.graphics.newImage('images/ui_selector.png'),
        ['DynamiteUI'] = love.graphics.newImage('images/ui_dynamite.png'),
        ['Strength!'] = love.graphics.newImage('images/text_strength.png'),
        -- Shop
        ['Table'] = love.graphics.newImage('images/shop_table.png'),
        ['Dynamite'] = love.graphics.newImage('images/dynamite.png'),
        ['StrengthDrink'] = love.graphics.newImage('images/strength_drink.png'),
        ['LuckyClover'] = love.graphics.newImage('images/lucky_clover.png'),
        ['RockCollectorsBook'] = love.graphics.newImage('images/rock_collectors_book.png'),
        ['GemPolish'] = love.graphics.newImage('images/gem_polish.png'),
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
    playerUseDynamiteAnimation = Animation {
        frames = {4, 5, 6},
        interval = 0.13
    }
    playerStrengthenAnimation = Animation {
        frames = {7, 8, 7, 8},
        interval = 0.13
    }

    -- Init shopkeeper's sheet and animations
    shopkeeperSheet = love.graphics.newImage('images/shopkeeper_sheet.png')
    shopkeeperQuads = generateQuads(shopkeeperSheet, SHOPKEEPER_WIDTH, SHOPKEEPER_HEIGHT)
    shopkeeperIdleAnimation = Animation {
        frames = {1},
        interval = 1
    }
    shopkeeperSadAnimation = Animation {
        frames = {2},
        interval = 1
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

    -- Init mole's sheet and animations.
    moleSheet = love.graphics.newImage('images/mole_sheet.png')
    moleQuads = generateQuads(moleSheet, MOLE_WIDTH, MOLE_HEIGHT)
    moleIdleAnimation = Animation {
        frames = {1},
        interval = 1
    }
    moleMoveAnimation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7},
        interval = 0.07
    }
    entityConfig['Mole'].sheet = moleSheet
    entityConfig['Mole'].quads = moleQuads
    entityConfig['Mole'].idleAnimation = moleIdleAnimation
    entityConfig['Mole'].moveAnimation = moleMoveAnimation

    moleWithDiamondSheet = love.graphics.newImage('images/mole_with_diamond_sheet.png')
    moleWithDiamondQuads = generateQuads(moleWithDiamondSheet, MOLE_WIDTH, MOLE_HEIGHT)
    moleWithDiamondIdleAnimation = Animation {
        frames = {1},
        interval = 1
    }
    moleWithDiamondMoveAnimation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7},
        interval = 0.07
    }
    entityConfig['MoleWithDiamond'].sheet = moleWithDiamondSheet
    entityConfig['MoleWithDiamond'].quads = moleWithDiamondQuads
    entityConfig['MoleWithDiamond'].idleAnimation = moleWithDiamondIdleAnimation
    entityConfig['MoleWithDiamond'].moveAnimation = moleWithDiamondMoveAnimation

    -- Init FXs
    bigGoldFXSheet = love.graphics.newImage('images/gold_big_fx_sheet.png')
    bigGoldFXQuads = generateQuads(bigGoldFXSheet, BIG_GOLD_FX_WIDTH, BIG_GOLD_FX_HEIGHT)
    bigGoldFXDefaultAnimation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9},
        interval = 0.06
    }

    explosiveFXSheet = love.graphics.newImage('images/explosive_fx_sheet.png')
    explosiveFXQuads = generateQuads(explosiveFXSheet, EXPLOSIVE_FX_WIDTH, EXPLOSIVE_FX_HEIGHT)
    explosiveFXDefaultAnimation = Animation {
        frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
        interval = 0.06
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
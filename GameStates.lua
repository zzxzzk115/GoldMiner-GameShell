levels = require 'levels'

menu = {}
showNextGoal = {}
showMadeGoal = {}
game = {}
gameOver = {}

local start = 0
local highScore = 1

function menu:init()
    self.bg = love.graphics.newImage('images/bg_start_menu.png')
    self.arrow = love.graphics.newImage('images/menu_arrow.png')
    self.arrowPos = {
        x = 0,
        y = 0
    }
    self.startPos = {
        x = 5,
        y = 152
    }
    self.highScorePos = {
        x = 5,
        y = 172
    }
end

function menu:enter()
    player = Player(idleAnimation)
    self.arrowState = start
end 

function menu:keypressed(key)
    if key == 'up' then self.arrowState = math.max(start, self.arrowState - 1)
    elseif key == 'down' then self.arrowState = math.min(self.arrowState + 1, highScore)
    elseif key == 'return' or key == 'enter' or key == 'k' then
        if self.arrowState == start then
            -- Start game
            Gamestate.switch(showNextGoal)
        elseif self.arrowState == highScore then
            -- Show high score
        end
    end
end

function menu:update()
    -- Update arrow state
    if self.arrowState == start then
        self.arrowPos = self.startPos
    elseif self.arrowState == highScore then
        self.arrowPos = self.highScorePos
    end
end

function menu:draw()
    -- Draw BG
    love.graphics.draw(self.bg)

    -- Draw menu text
    local startGameText = love.graphics.newText(uiFont, {COLOR_YELLOW, 'Start Game'})
    local highScoreText = love.graphics.newText(uiFont, {COLOR_YELLOW, 'High Score'})
    local devInfoText = love.graphics.newText(infoFont, {COLOR_YELLOW, 'Made with LÖVE. Developed by Lazy_V.'})
    love.graphics.draw(startGameText, 30, 150)
    love.graphics.draw(highScoreText, 30, 170)
    love.graphics.draw(devInfoText, 75, 225)

    -- Draw arrow
    love.graphics.draw(self.arrow, self.arrowPos.x, self.arrowPos.y)
end

function showNextGoal:init()
    self.firstInit = true
end

function showNextGoal:enter()
    -- Set goal text
    if self.firstInit then 
        self.goalTextContent = 'Your First Goal is'
        self.firstInit = false
    else 
        self.goalTextContent = 'Your Next Goal is'
    end

    -- Play goal bgm
    musics['goal']:play()
end 

function showNextGoal:update()
    if not musics['goal']:isPlaying() then
		Gamestate.switch(game)
	end
end 

function showNextGoal:draw()
    -- Draw BG
    love.graphics.draw(backgrounds['Goal'])

    -- Draw title
    love.graphics.draw(backgrounds['Title'], WINDOW_WIDTH / 2 - backgrounds['Title']:getWidth() / 2, 20)

    -- Draw panel
    love.graphics.draw(backgrounds['Panel'], WINDOW_WIDTH / 2 - backgrounds['Panel']:getWidth() / 2, 80)

    -- Draw next goal text
    local nextGoalText = love.graphics.newText(uiFont, {COLOR_YELLOW, self.goalTextContent, COLOR_GREEN, '\n\n$' .. player:getGoal()})
    love.graphics.draw(nextGoalText, 70, 100)
end

function showMadeGoal:enter()
    -- Init timer
    self.timer = 0
    -- Increase player level
    player.level = player.level + 1
    -- Init goal text
    self.goalTextContent = 'You made it to\nthe next Level!'
    -- Play goal bgm
    musics['goal']:play()
end 

function showMadeGoal:update(dt)
    if not musics['goal']:isPlaying() then
        self.timer = self.timer + dt
	end

    if self.timer >= 0.5 then
        Gamestate.switch(showNextGoal)
    end
end

function showMadeGoal:draw()
    -- Draw BG
    love.graphics.draw(backgrounds['Goal'])

    -- Draw title
    love.graphics.draw(backgrounds['Title'], WINDOW_WIDTH / 2 - backgrounds['Title']:getWidth() / 2, 20)

    -- Draw panel
    love.graphics.draw(backgrounds['Panel'], WINDOW_WIDTH / 2 - backgrounds['Panel']:getWidth() / 2, 80)

    -- Draw made goal text
    local madeGoalText = love.graphics.newText(uiFont, {COLOR_YELLOW, self.goalTextContent})
    love.graphics.draw(madeGoalText, 90, 110)
end 

function game:enter()
    -- Init entities
    self.entities = {}
    
    -- Init timer
    self.timer = 61

    -- Init hook
    hook = Hook()

    -- Reset player animation
    player.currentAnimation = playerIdleAnimation

    -- Load level
    levels.loadLevel(player.level, self.entities)

    -- Init misc
    self.isShowBonus = false
    self.showBonusTimer = 0
end

function game:keypressed(key)
    if key == 'down' or key == 'k' then
        if not hook.isGrabing then
            hook.isGrabing = true
            sounds['grabStart']:play()
        end
    elseif key == 'space' then
        if player:reachGoal() then
            Gamestate.switch(showMadeGoal)
        end
    end
end

function game:update(dt)
    -- Update player
    player:update(dt)

    -- Update hook
    hook:update(dt)

    -- Update entities
    for entityIndex, entity in ipairs(self.entities) do
        entity:update(dt)
    end 

    -- Update timer
    self.timer = self.timer - dt
    if self.timer <= 0 then
        self.timer = 0
        -- Times up, if player doesn't reach goal, then game over.
        -- Otherwise player reaches goal, switch to ShowMadeGoal state.
        if player:reachGoal() then
            Gamestate.switch(showMadeGoal)
        else
            Gamestate.switch(gameOver)
        end
    end

    if self.isShowBonus then
        self.showBonusTimer = self.showBonusTimer + dt
        if self.showBonusTimer >= 1 then
            self.showBonusTimer = 0
            self.isShowBonus = false
        end
    end

end

function game:draw()
    -- Draw BGs
    love.graphics.draw(backgrounds['LevelCommonTop'])
    love.graphics.draw(backgrounds[levels[player.level % TOTAL_LEVEL_COUNT + 1].type], 0, 40)

    -- Draw UI texts
    local moneyText = love.graphics.newText(gameFont, {COLOR_DEEP_ORANGE, 'Money', COLOR_GREEN, ' $' .. player.money})
    love.graphics.draw(moneyText, 5, 5)
    local goalText = love.graphics.newText(gameFont, {COLOR_DEEP_ORANGE, 'Goal', COLOR_GREEN, ' $' .. player:getGoal()})
    love.graphics.draw(goalText, 11, 15)
    local timeText = love.graphics.newText(gameFont, {COLOR_DEEP_ORANGE, 'Time: ', COLOR_ORANGE, tointeger(self.timer)})
    love.graphics.draw(timeText, 260, 15)
    local levelText = love.graphics.newText(gameFont, {COLOR_DEEP_ORANGE, 'Level: ', COLOR_ORANGE, player.level})
    love.graphics.draw(levelText, 250, 25)
    if player:reachGoal() then
        local reachGoalTipText = love.graphics.newText(gameFont, {COLOR_ORANGE, 'Press Select to Exit'})
        love.graphics.draw(reachGoalTipText, 200, 5)
    end
    if self.isShowBonus then
        local bonusText = love.graphics.newText(gameFontBig, {COLOR_GREEN, '+$' .. player.currentBonus})
        love.graphics.draw(bonusText, 90, 18)
    end
    -- Render player
    player:render()

    -- Render entities
    for entityIndex, entity in ipairs(self.entities) do
        entity:render()
    end 

    -- Render hook
    hook:render()
end

function gameOver:enter()
    -- Init game over text
    self.gameOverTextContent = 'Game Over!'
end 

function gameOver:keypressed(key)
    Gamestate.switch(menu)
end

function gameOver:draw()
    -- Draw BG
    love.graphics.draw(backgrounds['Goal'])

    -- Draw title
    love.graphics.draw(backgrounds['Title'], WINDOW_WIDTH / 2 - backgrounds['Title']:getWidth() / 2, 20)

    -- Draw panel
    love.graphics.draw(backgrounds['Panel'], WINDOW_WIDTH / 2 - backgrounds['Panel']:getWidth() / 2, 80)

    -- Draw gameOver text
    local gameOverText = love.graphics.newText(uiFont, {COLOR_YELLOW, self.gameOverTextContent})
    love.graphics.draw(gameOverText, 110, 130)
end 
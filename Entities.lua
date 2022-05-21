local entityConfig = {
    ['MiniGold'] = {
        ['type'] = 'Basic',
        ['mass'] = 1.5,
        ['bonus'] = 50,
        ['bonusType'] = 'Normal'
    },
    ['NormalGold'] = {
        ['type'] = 'Basic',
        ['mass'] = 3,
        ['bonus'] = 100,
        ['bonusType'] = 'Normal'
    },
    ['BigGold'] = {
        ['type'] = 'Basic',
        ['mass'] = 6,
        ['bonus'] = 500,
        ['bonusType'] = 'High'
    },
    ['MiniRock'] = {
        ['type'] = 'Basic',
        ['mass'] = 2,
        ['bonus'] = 30,
        ['bonusType'] = 'Low'
    },
    ['NormalRock'] = {
        ['type'] = 'Basic',
        ['mass'] = 4,
        ['bonus'] = 50,
        ['bonusType'] = 'Low'
    },
    ['BigRock'] = {
        ['type'] = 'Basic',
        ['mass'] = 8,
        ['bonus'] = 80,
        ['bonusType'] = 'Low'
    },
    ['QuestionBag'] = {
        ['type'] = 'RandomEffect',
    },
}

Player = Class{}

function Player:init()
    self.level = 1
    self.money = 0
    self.strength = 1
    self.currentBonus = 0
    self.bombCount = 0
    self.pos = vector(150, 7)
    self.currentAnimation = playerIdleAnimation
end

function Player:getGoal()
    if self.level == 1 then
        return 650;
    else
        return 650 * self.level + (125 * (self.level - 3));
    end
end

function Player:reachGoal()
    return self.money >= self:getGoal()
end

function Player:update(dt)
    self.currentAnimation:update(dt)
end

function Player:render()
    love.graphics.draw(playerSheet, playerQuads[self.currentAnimation:getCurrentFrame()], self.pos.x, self.pos.y)
end

Hook = Class{}

function Hook:init()
    self.length = 0
    self.angle = HOOK_MAX_ANGLE
    self.originPos = vector(158, 30)
    self.destPos = vector(158, 30)
    self.collisionCircleCenterPos = vector(158, 43)
    self.collisionCircleRadius = 6
    self.dir = vector(0, 1):rotated(degrees2radians(self.angle))
    self.rotateRight = true
    self.isGrabing = false
    self.isBacking = false
    self.grabedEntity = nil
    self.currentAnimation = hookIdleAnimation

    sounds['hookReset']:play()
end

function Hook:update(dt)
    -- Update angle
    if math.abs(self.angle - HOOK_MAX_ANGLE) < 1 then
        self.rotateRight = true
    end
    if math.abs(self.angle - HOOK_MIN_ANGLE) < 1 then
        self.rotateRight = false
    end
    if not self.isGrabing then
        if self.rotateRight then 
            self.angle = self.angle - dt * HOOK_ROTATE_SPEED
        else
            self.angle = self.angle + dt * HOOK_ROTATE_SPEED
        end
    end
    -- Update pos
    self.dir = vector(0, 1):rotated(degrees2radians(self.angle))
    self.destPos = self.originPos + self.dir * self.length
    self.collisionCircleCenterPos = self.originPos + self.dir * (self.length + 13)

    -- Update grabing
    if self.isGrabing then
        -- Grab start
        if not self.isBacking then
            self.length = self.length + dt * HOOK_GRAB_SPEED
            player.currentAnimation = playerGrabAnimation
        end
        
        -- Grab end
        if self.length >= HOOK_MAX_LENGTH or self.grabedEntity ~= nil then
            self.isBacking = true
        end

        -- Hook return
        if self.isBacking then
            if self.grabedEntity ~= nil then
                self.length = self.length - dt * HOOK_GRAB_SPEED / self.grabedEntity.mass
            else
                self.length = self.length - dt * HOOK_GRAB_SPEED
            end
            sounds['grabBack']:play()
            player.currentAnimation = playerGrabBackAnimation
        end

        -- Hook reset
        if self.length <= 0 then
            if self.grabedEntity ~= nil then
                -- Record and add bonus
                player.currentBonus = self.grabedEntity.bonus
                player.money = player.money + self.grabedEntity.bonus
                game.isShowBonus = true
                -- Set not active
                self.grabedEntity.isActive = false
            end
            self.angle = HOOK_MAX_ANGLE
            self.length = 0
            self.isBacking = false;
            self.isGrabing = false;
            self.grabedEntity = nil
            sounds['hookReset']:play()
            hook.currentAnimation = hookIdleAnimation
            player.currentAnimation = playerIdleAnimation
        end 
    end

    -- Update animation
    self.currentAnimation:update(dt)
end

function Hook:render()
    -- Draw hook line
    love.graphics.setColor(66/255, 66/255, 66/255, 1)
    love.graphics.line(self.originPos.x, self.originPos.y, self.destPos.x, self.destPos.y)
    -- Draw collision circle for debugging
    -- love.graphics.circle('fill', self.collisionCircleCenterPos.x, self.collisionCircleCenterPos.y, self.collisionCircleRadius)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(hookSheet, hookQuads[self.currentAnimation:getCurrentFrame()],
        -- X and Y
        self.destPos.x, self.destPos.y,
        -- Rotation(Radians)
        degrees2radians(self.angle),
        -- X scale and Y scale
        1, 1,
        -- X offset and Y offset
        HOOK_WIDTH / 2, 0
        )
end

BasicMapObject = Class{}

function BasicMapObject:init(type, pos)
    self.type = type
    self.pos = vector(pos.x, pos.y)
    self.mass = entityConfig[self.type].mass
    self.bonus = entityConfig[self.type].bonus
    self.bonusType = entityConfig[self.type].bonusType
    self.isActive = true
    self.isGrabedByHook = false
    self.width = sprites[self.type]:getWidth()
    self.height = sprites[self.type]:getHeight()
    self.collisionCircleCenterPos = self.pos + vector(self.width / 2, self.height / 2)
    self.collisionCircleRadius = (self.width / 2 + self.height / 2) / 2
    self.isTinyObject = self.collisionCircleRadius < hook.collisionCircleRadius
end

function BasicMapObject:update(dt)
    if not self.isActive then
        return
    end

    -- Update collision circle pos
    if self.isGrabedByHook then
        self.pos = hook.collisionCircleCenterPos
    end
    self.collisionCircleCenterPos = self.pos + vector(self.width / 2, self.height / 2)

    -- Collision detect
    if checkCircleCollision(self.collisionCircleCenterPos,
        hook.collisionCircleCenterPos,
        self.collisionCircleRadius,
        hook.collisionCircleRadius) then
            if hook.grabedEntity == nil then
                self.isGrabedByHook = true
                hook.grabedEntity = self
                sounds[self.bonusType]:play()
                if self.isTinyObject then
                    hook.currentAnimation = hookGrabMiniAnimation
                else
                    hook.currentAnimation = hookGrabNormalAnimation
                end
            end
    end
end 

function BasicMapObject:render()
    if not self.isActive then
        return
    end
    -- Draw collision circle for debugging
    -- love.graphics.circle('fill', self.collisionCircleCenterPos.x, self.collisionCircleCenterPos.y, self.collisionCircleRadius)
    if self.isGrabedByHook then
        love.graphics.draw(sprites[self.type], self.pos.x, self.pos.y,
        -- Rotation(Radians)
        degrees2radians(hook.angle),
        -- X scale and Y scale
        1, 1,
        -- X offset and Y offset
        self.width / 2, self.height / 3
        )
    else
        love.graphics.draw(sprites[self.type], self.pos.x, self.pos.y)
    end
end

RandomEffectMapObject = Class{__includes = BasicMapObject}

function RandomEffectMapObject:init(type, pos)
    self.type = type
    self.pos = vector(pos.x, pos.y)
    self.mass = math.random(3, 9)
    self.bonus = math.random(1, 20) * 50
    self.bonusType = 'Normal'
    self.isActive = true
    self.isGrabedByHook = false
    self.width = sprites[self.type]:getWidth()
    self.height = sprites[self.type]:getHeight()
    self.collisionCircleCenterPos = self.pos + vector(self.width / 2, self.height / 2)
    self.collisionCircleRadius = (self.width / 2 + self.height / 2) / 2
    self.isTinyObject = self.collisionCircleRadius < hook.collisionCircleRadius
end

function createEntityInstance(type, pos)
    if entityConfig[type].type == 'Basic' then 
        entityInstance = BasicMapObject(type, pos)
    elseif entityConfig[type].type == 'RandomEffect' then
        entityInstance = RandomEffectMapObject(type, pos)
    end
    return entityInstance
end
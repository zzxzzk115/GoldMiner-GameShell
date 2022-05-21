require 'Entities'

local levels = {
    [1] = {
        ['type'] = 'LevelA',
        ['entities'] = {
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 80, ['y'] = 80}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 110, ['y'] = 115}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 140, ['y'] = 120}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 190, ['y'] = 100}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 240, ['y'] = 80}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 110, ['y'] = 150}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 175, ['y'] = 160}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 190, ['y'] = 135}
            },
            {
                ['type'] = 'BigGold',
                ['pos'] = { ['x'] = 20, ['y'] = 130}
            },
            {
                ['type'] = 'BigGold',
                ['pos'] = { ['x'] = 270, ['y'] = 135}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 115, ['y'] = 130}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 240, ['y'] = 100}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 130, ['y'] = 200}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 220, ['y'] = 140}
            },
            {
                ['type'] = 'QuestionBag',
                ['pos'] = { ['x'] = 100, ['y'] = 210}
            },
        }
    }
    
}

function levels.loadLevel(level, entities)
    for entityIndex, entity in ipairs(levels[level % TOTAL_LEVEL_COUNT + 1].entities) do
        entityInstance = createEntityInstance(entity.type, entity.pos)
        table.insert(entities, entityInstance)
    end 
end

return levels
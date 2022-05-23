require 'Entities'

local levels = {
    -- Level 1
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
                ['pos'] = { ['x'] = 150, ['y'] = 120}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 190, ['y'] = 110}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 235, ['y'] = 80}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 105, ['y'] = 150}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 155, ['y'] = 170}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 170, ['y'] = 140}
            },
            {
                ['type'] = 'BigGold',
                ['pos'] = { ['x'] = 20, ['y'] = 130}
            },
            {
                ['type'] = 'BigGold',
                ['pos'] = { ['x'] = 260, ['y'] = 135}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 75, ['y'] = 130}
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
                ['pos'] = { ['x'] = 220, ['y'] = 150}
            },
            {
                ['type'] = 'QuestionBag',
                ['pos'] = { ['x'] = 105, ['y'] = 210}
            },
        }
    },
    -- Level 2
    [2] = {
        ['type'] = 'LevelA',
        ['entities'] = {
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 245, ['y'] = 72}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 200, ['y'] = 80}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 210, ['y'] = 112}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 270, ['y'] = 125}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 180, ['y'] = 140}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 210, ['y'] = 180}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 245, ['y'] = 210}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 220, ['y'] = 146}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 273, ['y'] = 150}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 188, ['y'] = 170}
            },
            {
                ['type'] = 'BigGold',
                ['pos'] = { ['x'] = 10, ['y'] = 190}
            },
            {
                ['type'] = 'BigGold',
                ['pos'] = { ['x'] = 264, ['y'] = 200}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 100, ['y'] = 100}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 60, ['y'] = 170}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 50, ['y'] = 220}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 25, ['y'] = 68}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 5, ['y'] = 115}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 85, ['y'] = 144}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 10, ['y'] = 155}
            },
            {
                ['type'] = 'QuestionBag',
                ['pos'] = { ['x'] = 27, ['y'] = 92}
            },
            {
                ['type'] = 'QuestionBag',
                ['pos'] = { ['x'] = 80, ['y'] = 110}
            },
            {
                ['type'] = 'QuestionBag',
                ['pos'] = { ['x'] = 96, ['y'] = 168}
            },
            {
                ['type'] = 'QuestionBag',
                ['pos'] = { ['x'] = 300, ['y'] = 180}
            },
            {
                ['type'] = 'QuestionBag',
                ['pos'] = { ['x'] = 76, ['y'] = 212}
            },
        }
    },
    -- Level 3
    [3] = {
        ['type'] = 'LevelA',
        ['entities'] = {
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 54, ['y'] = 68}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 74, ['y'] = 70}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 54, ['y'] = 88}
            },
            {
                ['type'] = 'MiniGold',
                ['pos'] = { ['x'] = 214, ['y'] = 116}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 288, ['y'] = 118}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 35, ['y'] = 142}
            },
            {
                ['type'] = 'NormalGold',
                ['pos'] = { ['x'] = 70, ['y'] = 180}
            },
            {
                ['type'] = 'BigGold',
                ['pos'] = { ['x'] = 153, ['y'] = 200}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 142, ['y'] = 109}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 230, ['y'] = 128}
            },
            {
                ['type'] = 'MiniRock',
                ['pos'] = { ['x'] = 195, ['y'] = 178}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 263, ['y'] = 104}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 188, ['y'] = 139}
            },
            {
                ['type'] = 'NormalRock',
                ['pos'] = { ['x'] = 50, ['y'] = 158}
            },
            {
                ['type'] = 'QuestionBag',
                ['pos'] = { ['x'] = 38, ['y'] = 98}
            },
            {
                ['type'] = 'Diamond',
                ['pos'] = { ['x'] = 243, ['y'] = 182 }
            },
        }
    },
    
}

function levels.loadLevel(level, entities)
    for entityIndex, entity in ipairs(levels[(level - 1) % TOTAL_LEVEL_COUNT + 1].entities) do
        entityInstance = createEntityInstance(entity.type, entity.pos)
        table.insert(entities, entityInstance)
    end 
end

return levels
propsConfig = {
    ['Dynamite'] = {
        ['description'] = 'After you grabed onto something with your\nclaw, press UP to throw a piece of dynamite\nat it and blow it up.',
        effect = function(player) player.dynamiteCount = math.min(player.dynamiteCount + 1, 6) end,
        getPrice = function(level) return math.random(300) + 1 + level * 2 end,
        ['uiPos'] = {
            [1] = {
                ['x'] = 195,
                ['y'] = 22
            },
            [2] = {
                ['x'] = 203,
                ['y'] = 22
            },
            [3] = {
                ['x'] = 211,
                ['y'] = 22
            },
            [4] = {
                ['x'] = 219,
                ['y'] = 22
            },
            [5] = {
                ['x'] = 227,
                ['y'] = 22
            },
            [6] = {
                ['x'] = 235,
                ['y'] = 22
            },
        },
        --['type'] = 'Usable',
        --['effectType'] = 'RangeDestroy'
    },
    ['StrengthDrink'] = {
        ['description'] = 'Strength drink. The Miner will reel up objects\na little faster on the next level.\nThe drink only lasts for one level.',
        effect = function(player) player.hasStrengthDrink = true end,
        getPrice = function(level) return math.random(300) + 100 end,
        --['type'] = 'OnlyNextLevelEffect',
        --['effectType'] = 'StrengthenMiner'
    },
    ['LuckyClover'] = {
        ['description'] = 'Lucky Clover. This will increase the chances\nof getting something good out of the\ngrab bags onthe next level.\nThis is only good for one level.',
        effect = function(player) player.hasLuckyClover = true end,
        getPrice = function(level) return math.random(level * 50) + 1 + level * 2 end,
        --['type'] = 'OnlyNextLevelEffect',
        --['effectType'] = 'QuestionBagMoreWorth'
    },
    ['RockCollectorsBook'] = {
        ['description'] = 'Rock Collectors book. Rocks will be worth\nthree times as much money on the next level.\nThis is only good for one level.',
        effect = function(player) player.hasRockCollectorsBook = true end,
        getPrice = function(level) return math.random(150) + 1 end,
        --['type'] = 'OnlyNextLevelEffect',
        --['effectType'] = 'RockWorth*3'
    },
    ['GemPolish'] = {
        ['description'] = 'Gem Polish. During the next level gems and\ndiamonds will be worth more money.\nOnly good for one level.',
        effect = function(player) player.hasGemPolish = true end,
        getPrice = function(level) return math.random(level * 100) + 201 end,
        --['type'] = 'OnlyNextLevelEffect',
        --['effectType'] = 'GemWorth*1.5'
    },
}

props = { 'Dynamite', 'StrengthDrink', 'LuckyClover', 'RockCollectorsBook', 'GemPolish' }
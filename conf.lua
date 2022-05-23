WINDOW_WIDTH = 320
WINDOW_HEIGHT = 240

PLAYER_WIDTH = 32
PLAYER_HEIGHT = 32

SHOPKEEPER_WIDTH = 80
SHOPKEEPER_HEIGHT = 80
SHOP_ITEM_PADDING = 42

HOOK_WIDTH = 13
HOOK_HEIGHT = 15
HOOK_MIN_ANGLE = -75
HOOK_MAX_ANGLE = 75
HOOK_ROTATE_SPEED = 65;
HOOK_MAX_LENGTH = 230;
HOOK_GRAB_SPEED = 100;

COLOR_BLACK = {0, 0, 0}
COLOR_YELLOW = {255/255, 214/255, 33/255}
COLOR_ORANGE = {239/255, 108/255, 0/255}
COLOR_DEEP_ORANGE = {194/255, 136/255, 4/255}
COLOR_GREEN = {67/255, 160/255, 71/255}

TOTAL_LEVEL_COUNT = 3

DEBUG_MODE = false

function love.conf(t)
    t.version = "11.1"                      -- The LÖVE version this game was made for (string)
    t.window.title = "GoldMiner-GameShell"  -- The window title (string)
    t.window.icon = "images/icon.png"       -- Filepath to an image to use as the window's icon (string)
    t.window.width = WINDOW_WIDTH           -- The window width (number)
    t.window.height = WINDOW_HEIGHT         -- The window height (number)
    t.window.borderless = true              -- Remove all border visuals from the window (boolean)
    t.window.resizable = false              -- Let the window be user-resizable (boolean)
    t.window.fullscreen = false             -- Enable fullscreen (boolean)
    t.window.vsync = 1                      -- Vertical sync mode (number)
end
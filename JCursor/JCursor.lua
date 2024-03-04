--- STEAMODDED HEADER
--- MOD_NAME: J Cursor
--- MOD_ID: JCursor
--- MOD_AUTHOR: [Jie65535]
--- MOD_DESCRIPTION: Custom Cursor (./Mods/JCursor/Cursor.png)

----------------------------------------------
------------MOD CODE -------------------------

SMODS.registerUIElement("JCursor", {
    {
        n = G.UIT.R,
        config = {
            padding = 0.2,
            align = "cm"
        },
        nodes = {
            UIBox_button({
                minw = 3.85,
                button = "openModDirectory",
                label = {
                    "Open directory"
                }
            }),
            UIBox_button({
                minw = 3.85,
                button = "refreshCursor",
                label = {
                    "Refresh cursor"
                }
            }),
        }
    }
})

local function getModDirectory()
    return "/Mods/JCursor"
end

local function getCursorFile()
    return getModDirectory() .. "/Cursor.png"
end

local function setCursor(filename)
    cursor = love.mouse.newCursor(filename, 0, 0)
    love.mouse.setCursor(cursor)
end

function G.FUNCS.openModDirectory(arg_736_0)
    sendDebugMessage("openModDirectory")
    love.system.openURL("file://" .. love.filesystem.getSaveDirectory() .. getModDirectory())
end

function G.FUNCS.refreshCursor(arg_736_0)
    sendDebugMessage("refreshCursor")
    setCursor(getCursorFile())
end

local defaultCursor = getCursorFile()
if love.filesystem.exists(defaultCursor) then
    setCursor(defaultCursor)
end

sendDebugMessage("JCursor loaded!")

----------------------------------------------
------------MOD CODE END----------------------
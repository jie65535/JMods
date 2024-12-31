--- STEAMODDED HEADER
--- MOD_NAME: J Cursor
--- MOD_ID: JCursor
--- MOD_AUTHOR: [Jie65535, MarioMak967]
--- MOD_DESCRIPTION: Custom Cursor (Mods/JCursor/Cursor.png CursorHover.png CursorDrag.png)

----------------------------------------------
------------MOD CODE -------------------------

-- The x-coordinate in the cursor's hot spot.
local HOT_X = 20
-- The y-coordinate in the cursor's hot spot.
local HOT_Y = 4

local currentCursor
local function setCursor(cursor)
    if currentCursor ~= cursor then
        currentCursor = cursor
        love.mouse.setCursor(cursor)
    end
end

local MOD_DIRECTORY = "/Mods/JCursor"
local function getCursor(state, hotx, hoty)
    local filename = MOD_DIRECTORY .. "/" .. state .. ".png"
    if love.filesystem.exists(filename) then
        return love.mouse.newCursor(filename, hotx, hoty)
    end
    return nil
end

local cursorDefault
local cursorHover
local cursorDrag
local function updateCursors()
    cursorDefault = getCursor("Cursor", HOT_X, HOT_Y)
    cursorHover = getCursor("CursorHover", HOT_X, HOT_Y)
    cursorDrag = getCursor("CursorDrag", HOT_X, HOT_Y)
    if cursorDefault then
        setCursor(cursorDefault)
    end
end

-- init cursors
updateCursors()

local function myDrag()
    if cursorDrag then
        setCursor(cursorDrag)
        -- sendDebugMessage("drag start!")
    end
end

local function myStopDrag()
    if cursorDrag and cursorDefault and currentCursor == cursorDrag then
        setCursor(cursorDefault)
        -- sendDebugMessage("drag stop!")
    end
end


local hoverLevel = 0
local function myHover()
    if cursorHover and currentCursor == cursorDefault and hoverLevel == 0 then
        setCursor(cursorHover)
        -- sendDebugMessage("hover start!")
    end
    hoverLevel = hoverLevel + 1
end

local function myStopHover()
    if hoverLevel > 0 then
        hoverLevel = hoverLevel - 1
    end
    if cursorHover
        and cursorDefault
        and currentCursor == cursorHover
        and hoverLevel == 0
        then
        setCursor(cursorDefault)
        -- sendDebugMessage("hover stop!")
    end
end

local function injectCodeBefore(originalFunction, codeToInject)
    return function(...)
        codeToInject(...)
        return originalFunction(...)
    end
end

Node.drag = injectCodeBefore(Node.drag, myDrag)
Node.stop_drag = injectCodeBefore(Node.stop_drag, myStopDrag)
-- Node.hover = injectCodeBefore(Node.hover, myHover)
-- Node.stop_hover = injectCodeBefore(Node.stop_hover, myStopHover)

Card.hover = injectCodeBefore(Card.hover, myHover)
Card.stop_hover = injectCodeBefore(Card.stop_hover, myStopHover)

-- UIElement.hover = injectCodeBefore(UIElement.hover, myHover)
-- UIElement.stop_hover = injectCodeBefore(UIElement.stop_hover, myStopHover)

sendDebugMessage("JCursor loaded!")

----------------------------------------------
------------MOD CODE END----------------------

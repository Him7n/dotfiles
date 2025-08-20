
-- Launch Kitty with Cmd + Return

    hs.alert.show("Launching Kitty")
hs.hotkey.bind({ "cmd" }, "Return", function()
    -- hs.alert.show("Launching Kitty")
    hs.application.launchOrFocus("kitty")
end)

-- Switch desktops using Ctrl + Option + H/L (faster implementation)
-- Switch desktops using Ctrl + Option + H/L
    -- hs.alert.show("Launching Kitty")
-- hs.hotkey.bind({ "ctrl", "alt" }, "H", function()
--     hs.alert.show("Switching to previous desktop")
    
--     -- Get all spaces and screens
--     local allSpaces = hs.spaces.allSpaces()
--     local focusedSpace = hs.spaces.focusedSpace()
--     local mainScreen = hs.screen.mainScreen()
--     local screenUUID = mainScreen:getUUID()
    
--     -- Get spaces for the current screen
--     local screenSpaces = allSpaces[screenUUID]
    
--     -- Find current space index
--     local currentIdx = 0
--     for idx, spaceID in ipairs(screenSpaces) do
--         if spaceID == focusedSpace then
--             currentIdx = idx
--             break
--         end
--     end
    
--     -- Calculate previous space index (with wraparound)
--     local prevIdx = currentIdx - 1
--     if prevIdx < 1 then prevIdx = #screenSpaces end
    
--     -- Go to the previous space
--     local prevSpaceID = screenSpaces[prevIdx]
--     hs.spaces.gotoSpace(prevSpaceID)
-- end)

-- hs.hotkey.bind({ "ctrl", "alt" }, "L", function()
--     hs.alert.show("Switching to next desktop")
    
--     -- Get all spaces and screens
--     local allSpaces = hs.spaces.allSpaces()
--     local focusedSpace = hs.spaces.focusedSpace()
--     local mainScreen = hs.screen.mainScreen()
--     local screenUUID = mainScreen:getUUID()
    
--     -- Get spaces for the current screen
--     local screenSpaces = allSpaces[screenUUID]
    
--     -- Find current space index
--     local currentIdx = 0
--     for idx, spaceID in ipairs(screenSpaces) do
--         if spaceID == focusedSpace then
--             currentIdx = idx
--             break
--         end
--     end
    
--     -- Calculate next space index (with wraparound)
--     local nextIdx = currentIdx + 1
--     if nextIdx > #screenSpaces then nextIdx = 1 end
    
--     -- Go to the next space
--     local nextSpaceID = screenSpaces[nextIdx]
--     hs.spaces.gotoSpace(nextSpaceID)
-- end)
-- Switch desktops using Ctrl + Option + H/L
-- hs.hotkey.bind({ "ctrl", "alt" }, "H", function()
--     hs.alert.show("Switching to previous desktop")
--     -- Use AppleScript to trigger the system shortcut for switching to previous desktop
--     hs.osascript.applescript([[
--         tell application "System Events"
--             key code 123 using {control down} -- left arrow with control
--         end tell
--     ]])
-- end)

-- hs.hotkey.bind({ "ctrl", "alt" }, "L", function()
--     hs.alert.show("Switching to next desktop")
--     -- Use AppleScript to trigger the system shortcut for switching to next desktop
--     hs.osascript.applescript([[
--         tell application "System Events"
--             key code 124 using {control down} -- right arrow with control
--         end tell
--     ]])
-- end)

-- hs.hotkey.bind({ "cmd", "ctrl" }, "H", function()
--     hs.alert.show("Switching to previous desktop")
--     hs.eventtap.keyStroke({ "control" }, "Left")
-- end)

-- -- Move current window to previous/next space using keyboard shortcuts
-- -- This uses macOS built-in shortcuts instead of the hs.spaces module
-- hs.hotkey.bind({ "ctrl", "alt", "shift" }, "Left", function()
--     local win = hs.window.focusedWindow()
--     if not win then return end
    
--     -- First move the window to the previous space using macOS shortcuts
--     hs.osascript.applescript([[
--         tell application "System Events"
--             key code 123 using {control down, option down} -- ctrl+option+left
--         end tell
--     ]])
    
--     -- Then follow the window by switching to that space
--     hs.timer.doAfter(0.3, function()
--         hs.osascript.applescript([[
--             tell application "System Events"
--                 key code 123 using {control down} -- ctrl+left
--             end tell
--         ]])
--     end)
-- end)

-- hs.hotkey.bind({ "ctrl", "alt", "shift" }, "Right", function()
--     local win = hs.window.focusedWindow()
--     if not win then return end
    
--     -- First move the window to the next space using macOS shortcuts
--     hs.osascript.applescript([[
--         tell application "System Events"
--             key code 124 using {control down, option down} -- ctrl+option+right
--         end tell
--     ]])
    
--     -- Then follow the window by switching to that space
--     hs.timer.doAfter(0.3, function()
--         hs.osascript.applescript([[
--             tell application "System Events"
--                 key code 124 using {control down} -- ctrl+right
--             end tell
--         ]])
--     end)
-- end)

-- chrome profile 
-- Open Chrome with specific profile using Shift+Alt+B
-- Open Chrome with specific profile using Shift+Alt+B
hs.hotkey.bind({"shift", "alt"}, "B", function()
    -- Debug: Show what we're attempting
    hs.alert.show("Attempting to open Chrome profile")
    
    -- Use hs.task for better process control
    local task = hs.task.new("/usr/bin/open", 
        function(exitCode, stdOut, stdErr)
            if exitCode == 0 then
                hs.alert.show("Chrome profile launched")
            else
                hs.alert.show("Error launching Chrome: " .. (stdErr or "unknown error"))
            end
        end, 
        {"-a", "Google Chrome", "--args", "--profile-directory=Default"}
    )
    
    task:start()
end)

hs.hotkey.bind({"shift", "alt"}, "K", function()
    -- Debug: Show what we're attempting
    hs.alert.show("Attempting to open Chrome profile")
    
    -- Use hs.task for better process control
    local task = hs.task.new("/usr/bin/open", 
        function(exitCode, stdOut, stdErr)
            if exitCode == 0 then
                hs.alert.show("Chrome profile launched")
            else
                hs.alert.show("Error launching Chrome: " .. (stdErr or "unknown error"))
            end
        end, 
        {"-a", "Google Chrome", "--args", "--profile-directory=Profile 2"}
    )
    
    task:start()
end)


-- Chrome profile manager
-- Define profiles with their directory names and display names
local CHROME_PROFILES = {
    -- {"Profile Dir", "Display Name"}
    ["B"] = {"Profile 2", "Personal"},
    ["K"] = {"Default", "Work"}
    -- Add more profiles as needed with their hotkey as the key
}
-- Switch to existing Chrome profile if running, else launch it
local function switchOrOpenChromeProfile(profileDir, displayName)
  local chromePath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

  -- Step 1: Try to find a running Chrome window with that profile
  local foundWindow = nil

  hs.application.get("Google Chrome"):allWindows()
  for _, win in ipairs(hs.application.get("Google Chrome"):allWindows() or {}) do
    local title = win:title() or ""
    if title:lower():find(displayName:lower(), 1, true) then
      foundWindow = win
      break
    end
  end

  if foundWindow then
    hs.alert.show("Switching to Chrome: " .. displayName)
    foundWindow:focus()
    return
  end

  -- Step 2: Not found? Launch new Chrome with that profile
  hs.alert.show("Launching Chrome profile: " .. displayName)
  local task = hs.task.new(chromePath,
    nil,
    function() return false end,
    { "--profile-directory=" .. profileDir }
  )

  if not task then
    hs.alert.show("Failed to launch Chrome: " .. displayName)
    return
  end

  task:start()
end

-- 🔥 Keybindings
hs.hotkey.bind({ "shift", "alt" }, "J", function()
  switchOrOpenChromeProfile("Profile 2", "Personal")
end)

hs.hotkey.bind({ "shift", "alt" }, "H", function()
  switchOrOpenChromeProfile("Default", "Work")
end)








-- Window management: move window to left half of screen

hs.hotkey.bind({ "alt", "cmd" }, "Left", function()
    hs.alert.show("Moving window to left half")
    local win = hs.window.focusedWindow()
    if not win then 
        hs.alert.show("No focused window")
        return 
    end
    
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    
    win:setFrame(f)
end)

-- Window management: move window to right half of screen
hs.hotkey.bind({ "alt", "cmd" }, "Right", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x + (max.w / 2)
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h
    
    win:setFrame(f)
end)

-- Window management: move window to top half of screen
hs.hotkey.bind({ "alt", "cmd" }, "Up", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h / 2
    
    win:setFrame(f)
end)

-- Window management: move window to bottom half of screen
hs.hotkey.bind({ "alt", "cmd" }, "Down", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    f.x = max.x
    f.y = max.y + (max.h / 2)
    f.w = max.w
    f.h = max.h / 2
    
    win:setFrame(f)
end)

-- Window management: maximize window
hs.hotkey.bind({ "alt", "cmd"   }, "F", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    win:maximize()
end)


-- Window management : maximize window but with some padding
hs.hotkey.bind({ "alt", "cmd" }, "T", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    -- Define padding (in pixels)
    local padding = 20
    
    -- Set frame with padding on all sides
    f.x = max.x + padding
    f.y = max.y + padding
    f.w = max.w - (padding * 2)
    f.h = max.h - (padding * 2)
    
    win:setFrame(f)
end)

hs.hotkey.bind({ "alt", "cmd" }, "S", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    
    -- Define padding (in pixels)
    local padding = 40
    
    -- Set frame with padding on all sides
    f.x = max.x + padding
    f.y = max.y + padding
    f.w = max.w - (padding * 2)
    f.h = max.h - (padding * 2)
    
    win:setFrame(f)
end)
-- Window management: center window
-- hs.hotkey.bind({ "cmd"}, "C", function()
--     local win = hs.window.focusedWindow()
--     if not win then return end
--     win:centerOnScreen()
-- end)

-- Auto-reload config when files change
function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
-- -- Switch desktops using Ctrl + Option + H/L (using AppleScript approach) hs.hotkey.bind({ "ctrl", "alt" }, "H", function()
--     hs.alert.show("Switching to previous desktop")
--     hs.osascript.applescript([[
--         tell application "System Events"
--             key code 123 using {control down} -- Left arrow with control
--         end tell
--     ]])
-- end)

-- hs.hotkey.bind({ "ctrl", "alt" }, "L", function()
--     hs.alert.show("Switching to next desktop")
--     hs.osascript.applescript([[
--         tell application "System Events" 
--             key code 124 using {control down} -- Right arrow with control
--         end tell
--     ]])
-- end)
-- Switch desktops using Ctrl + Option + H/L
-- hs.hotkey.bind({ "ctrl", "alt" }, "H", function()
--     -- Get all spaces and screens
--     local allSpaces = hs.spaces.allSpaces()
--     local focusedSpace = hs.spaces.focusedSpace()
--     local mainScreen = hs.screen.mainScreen()
--     local screenUUID = mainScreen:getUUID()
    
--     -- Get spaces for the current screen
--     local screenSpaces = allSpaces[screenUUID]
    
--     -- Find current space index
--     local currentIdx = 0
--     for idx, spaceID in ipairs(screenSpaces) do
--         if spaceID == focusedSpace then
--             currentIdx = idx
--             break
--         end
--     end
    
--     -- Calculate previous space index (with wraparound)
--     local prevIdx = currentIdx - 1
--     if prevIdx < 1 then prevIdx = #screenSpaces end
    
--     -- Go to the previous space
--     local prevSpaceID = screenSpaces[prevIdx]
--     hs.alert.show("Switching to previous desktop")
--     hs.spaces.gotoSpace(prevSpaceID)
-- end)

-- hs.hotkey.bind({ "ctrl", "alt" }, "L", function()
--     -- Get all spaces and screens
--     local allSpaces = hs.spaces.allSpaces()
--     local focusedSpace = hs.spaces.focusedSpace()
--     local mainScreen = hs.screen.mainScreen()
--     local screenUUID = mainScreen:getUUID()
    
--     -- Get spaces for the current screen
--     local screenSpaces = allSpaces[screenUUID]
    
--     -- Find current space index
--     local currentIdx = 0
--     for idx, spaceID in ipairs(screenSpaces) do
--         if spaceID == focusedSpace then
--             currentIdx = idx
--             break
--         end
--     end
    
--     -- Calculate next space index (with wraparound)
--     local nextIdx = currentIdx + 1
--     if nextIdx > #screenSpaces then nextIdx = 1 end
    
--     -- Go to the next space
--     local nextSpaceID = screenSpaces[nextIdx]
--     hs.alert.show("Switching to next desktop")
--     hs.spaces.gotoSpace(nextSpaceID)
-- end)

-- Move focused window to previous/next space with Ctrl + Alt + Shift + H/L
hs.hotkey.bind({ "ctrl", "alt", "shift" }, "H", function()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("No focused window")
        return
    end
    
    -- Get all spaces and screens
    local allSpaces = hs.spaces.allSpaces()
    local focusedSpace = hs.spaces.focusedSpace()
    local mainScreen = hs.screen.mainScreen()
    local screenUUID = mainScreen:getUUID()
    
    -- Get spaces for the current screen
    local screenSpaces = allSpaces[screenUUID]
    
    -- Find current space index
    local currentIdx = 0
    for idx, spaceID in ipairs(screenSpaces) do
        if spaceID == focusedSpace then
            currentIdx = idx
            break
        end
    end
    
    -- Calculate previous space index (with wraparound)
    local prevIdx = currentIdx - 1
    if prevIdx < 1 then prevIdx = #screenSpaces end
    
    -- Move window to the previous space
    local prevSpaceID = screenSpaces[prevIdx]
    hs.alert.show("Moving window to previous desktop")
    
    -- Move the window and follow it
    local result = hs.spaces.moveWindowToSpace(win, prevSpaceID)
    if result then
        hs.timer.doAfter(0.2, function()
            hs.spaces.gotoSpace(prevSpaceID)
            hs.timer.doAfter(0.2, function()
                win:focus()
            end)
        end)
    else
        hs.alert.show("Failed to move window")
    end
end)

hs.hotkey.bind({ "ctrl", "alt", "shift" }, "L", function()
    local win = hs.window.focusedWindow()
    if not win then
        hs.alert.show("No focused window")
        return
    end
    
    -- Get all spaces and screens
    local allSpaces = hs.spaces.allSpaces()
    local focusedSpace = hs.spaces.focusedSpace()
    local mainScreen = hs.screen.mainScreen()
    local screenUUID = mainScreen:getUUID()
    
    -- Get spaces for the current screen
    local screenSpaces = allSpaces[screenUUID]
    
    -- Find current space index
    local currentIdx = 0
    for idx, spaceID in ipairs(screenSpaces) do
        if spaceID == focusedSpace then
            currentIdx = idx
            break
        end
    end
    
    -- Calculate next space index (with wraparound)
    local nextIdx = currentIdx + 1
    if nextIdx > #screenSpaces then nextIdx = 1 end
    
    -- Move window to the next space
    local nextSpaceID = screenSpaces[nextIdx]
    hs.alert.show("Moving window to next desktop")
    
    -- Move the window and follow it
    local result = hs.spaces.moveWindowToSpace(win, nextSpaceID)
    if result then
        hs.timer.doAfter(0.2, function()
            hs.spaces.gotoSpace(nextSpaceID)
            hs.timer.doAfter(0.2, function()
                win:focus()
            end)
        end)
    else
        hs.alert.show("Failed to move window")
    end
end)

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


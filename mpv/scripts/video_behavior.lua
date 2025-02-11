-- Set the package path to include the directory where settings.lua is located
package.path = package.path .. ';' .. os.getenv("HOME") .. '/.config/mpv/scripts/?.lua'

-- Load the settings module
local settings = require("settings")

-- Load user settings
local user_settings = settings.load()

-- Set the default value if no saved value is found
local is_loop_enabled = user_settings.is_loop

-- Function to toggle loop mode
local function toggle_loop()
    is_loop_enabled = not is_loop_enabled -- Toggle the state
    mp.osd_message("Loop mode: " .. (is_loop_enabled and "Enabled" or "Disabled"))
    mp.msg.info("Loop mode toggled. New state: " .. (is_loop_enabled and "Enabled" or "Disabled"))
    
    -- Save the loop state to settings
    user_settings.is_loop = is_loop_enabled
    settings.save(user_settings)
    
    -- Set the loop property in MPV
    mp.set_property("loop-file", is_loop_enabled and "inf" or "no")
end

-- Bind Shift+L to toggle loop mode
mp.add_key_binding("Shift+l", "toggle_loop", toggle_loop)



-- Ensure MPV stays open
mp.set_property("keep-open", "yes")
mp.set_property("idle", "yes")

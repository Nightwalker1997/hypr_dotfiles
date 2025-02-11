-- Set the package path to include the directory where settings.lua is located
package.path = package.path .. ';' .. os.getenv("HOME") .. '/.config/mpv/scripts/?.lua'

-- Load the settings module
local settings = require("settings")

-- Load user settings
local user_settings = settings.load()

-- Set the default volume if no saved volume is found
user_settings.volume = user_settings.volume

-- Apply the saved or default volume to MPV
mp.set_property("volume", user_settings.volume)

-- Set up a listener for volume changes
mp.observe_property("volume", "native", function(_, value)
    if value then
        -- Save the updated volume to the settings
        user_settings.volume = value
        settings.save(user_settings)
    end
end)

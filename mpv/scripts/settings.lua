local utils = require("mp.utils")

-- Define the path to the settings file
local settings_file = os.getenv("HOME") .. "/.config/mpv/settings/settings.json"

-- Default settings
local defaults = {
    volume = 80,  -- Default volume level
    is_loop = false -- Default loop state
}

-- Create the directory if it doesn't exist
local function create_directory(path)
    local dir = path:match("^(.*)/")
    local handle = io.popen("mkdir -p " .. dir)
    local result = handle:read("*a")
    handle:close()
    return result
end

-- Load settings from the file, fallback to defaults if missing or invalid
local function load_settings()
    local file = io.open(settings_file, "r")
    if file then
        local content = file:read("*all")
        file:close()
        -- Try parsing the content as JSON
        local parsed, err = utils.parse_json(content)
        if parsed then
            mp.msg.info("Settings loaded successfully from " .. settings_file)
            return parsed
        else
            mp.msg.error("Failed to parse JSON from settings file: " .. err)
        end
    else
        mp.msg.info("Settings file not found, using defaults.")
    end
    return defaults -- Return defaults if file is missing or invalid
end

-- Save settings to the file
local function save_settings(settings)
    -- Ensure directory exists
    create_directory(settings_file)

    local file = io.open(settings_file, "w")
    if file then
        local json_string, err = utils.format_json(settings)
        if json_string then
            file:write(json_string)
            file:close()
            mp.msg.info("Settings saved to " .. settings_file)
        else
            mp.msg.error("Failed to format JSON for settings: " .. err)
        end
    else
        mp.msg.error("Failed to open settings file for writing!")
    end
end

return {
    load = load_settings,
    save = save_settings,
}

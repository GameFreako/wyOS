local intro = "Press ENTER to install wyOS onto your system. This will update your installation if already installed. Press any other key to exit."
local url = "https://raw.githubusercontent.com/GameFreako/wyos/master/"
local files = [
    "startup.lua",
    "sys/apps/setup.lua",
    "sys/apps/home.lua",
    "sys/apps/login.lua",
    "sys/apis/sha256.lua",
    "sys/apps/update.lua",
]

local function install()
    print("Installing")
    for k in pairs(files) do
        local h = fs.open(k, "w")
        local r, err = http.get(url .. k)
        print("attempting connection to " .. url .. k)
        if err then
            printError("error connecting to " .. url .. k .. " : " .. err)
        end
        local data = r.readAll()
        r.close()
        h.write(data)
        h.close()
    end
end

term.clear();
print(intro)
local event, key, held = os.pullEvent("key")
if keys.getName(key) == "enter" then
    install()
else
    print("Not installed.")
    os.queueEvent("terminate");
end
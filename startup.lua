-- DO NOT MODIFY THIS FILE
-- If you would like to run programs on startup, please put them in the autorun folder.
-- Scripts in the autorun folder run in the background, but the tab closes when they terminate. 

print("press C to disable wyOS boot")
os.startTimer(5)
while true do
    local event, a1, a2 = os.pullEvent()
    if event == "char" and a1 == "c" then
        os.queueEvent("terminate")
    elseif event == "timer" then
        break
    end
end

-- load apis
--os.loadAPI("/sys/apis/jua")
--os.loadAPI("/sys/apis/k.lua")
--os.loadAPI("/sys/apis/w.lua")
--os.loadAPI("/sys/apis/r.lua")
os.loadAPI("/sys/apis/sha256.lua")
os.loadAPI("/sys/apis/core.lua")


options = {}
if settings.load(".wyos") then
    options["setup"] = settings.get("setup")
    options["monitor"] = settings.get("monitor")
    options["monitormode"] = settings.get("monitormode")
else
    -- no settings exist, assume defaults and begin setup mode
    options["setup"] = true
    options["password"] = nil
    options["username"] = "admin"
    options["network"] = nil
    options["monitor"] = nil
    options["monitormode"] = 1
end

if monitorMode == 3 then
    if options["setup"] == true then
        os.run({}, "/sys/apps/home.lua", "MONITOR", options["monitor"])
    else
        os.run({}, "/sys/apps/setup.lua", "MONITOR", options["monitor"])
    end
    os.queueEvent("terminate")
else
    if options["setup"] == true then
        os.run({}, "/sys/apps/home.lua")
    else
        os.run({}, "/sys/apps/setup.lua")
    end
    os.queueEvent("terminate")
end
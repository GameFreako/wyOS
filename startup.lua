-- DO NOT MODIFY THIS FILE
-- If you would like to run programs on startup, please put them in the autorun folder.
-- Scripts in the autorun folder run in the background, but the tab closes when they terminate. 

term.clear()
term.print("press C to disable wyOS boot")
os.startTimer(5)
while true do
    local event, a1, a2 = os.pullEvent()
    if (event == "char" and a1 == "c") then
        os.queueEvent("terminate")
    else
        break
    end
end

multishell.setTitle(1, "Starting...")

-- load apis
os.loadAPI("/sys/apis/jua")
os.loadAPI("/sys/apis/k.lua")
os.loadAPI("/sys/apis/w.lua")
os.loadAPI("/sys/apis/r.lua")
os.loadAPI("/sys/apis/sha256.lua")


options = {}
if not fs.exists(".wyos") then
    -- no settings exist, assume defaults and begin setup mode
    options["setup"] = false
    options["password"] = nil
    options["username"] = "admin"
    options["network"] = nil
    options["monitor"] = nil
    options["monitormode"] = 1
else
    settings.load(".wyos")
    options["setup"] = true
    options["monitor"] = settings.get("monitor")
    options["monitormode"] = settings.get("monitormode")
end

if monitorMode == 3 then
    multishell.launch({}, "/sys/apps/home.lua", "MONITOR", options["monitor"])
    if options["setup"] == true then
        multishell.launch({}, "/sys/apps/setup", "MONITOR", options["monitor"])
    end
else
    multishell.launch({}, "/sys/apps/home.lua")
    if options["setup"] == true then
        multishell.launch({}, "/sys/apps/setup")
    end
end
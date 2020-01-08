local sha256 = _G.sha256

local args = {...}
if args[1] == "MONITOR" then
    screen = peripheral.wrap(args[2])
    if not screen then
        screen = term
    end
else
    screen = term
end

settings.load(".wyos")

sleep(1)

if multishell then
    multishell.setTitle(multishell.getFocus(), "Setup")
end

local sx, sy = screen.getSize();

local awaitInput = _G.core.awaitInput
local typeOut = _G.core.typeOut

screen.setBackgroundColor(colors.black);
screen.setTextColor(colors.white)
screen.clear()
screen.setCursorPos((sx/2)-8, 1)
screen.write("--------------")
screen.setCursorPos((sx/2)-8, 2)
screen.write("| WyOS Setup |")
screen.setCursorPos((sx/2)-8, 3)
screen.write("--------------")
screen.setCursorPos(1, sy)
screen.write("> ")
sleep(1)
screen.setCursorPos(1, sy-3)
typeOut("Hello.", 0.25)
sleep(0.5)
typeOut("Please type a computer label.", 0.5)
sleep(0.5)
os.setComputerLabel(awaitInput(os.getComputerLabel()))
typeOut("Please type a network password.", 0.5)
settings.set("netpassword", awaitInput(nil, "password"))
typeOut("Please type a user name.", 0.5)
settings.set("username", awaitInput("admin"))
typeOut("Please type a login password.", 0.5)
settings.set("logpassword", awaitInput(nil, "password"))
typeOut("Would you like to use Monitor Mode? (true/false)", 0.5)
settings.set("monitormode", awaitInput(nil, "bool"))
if settings.get("monitormode") == true then
    typeOut("What is the ID of the monitor?", 0.5)
    settings.set("monitor", awaitInput(nil, "int"))
end
typeOut("Would you like to restart setup?", 1.5)
local restart = awaitInput(nil, "bool")
if restart then
    settings.save(".wyos")
    multishell.launch({}, "/sys/apps/setup.lua")
    os.queueEvent("terminate")
else
    settings.set("setup", true)
    settings.save(".wyos")
    multishell.launch({}, "/sys/apps/home.lua")
    os.queueEvent("terminate")
end
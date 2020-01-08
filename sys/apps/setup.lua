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

local sx, sy = screen.getSize();

local function typeOut(text, time)
    local x, y = screen.getCursorPos()
    screen.setCursorPos(1, y)
    screen.clearLine()
    if not time then time = 2 end
    local lap = time/text:len()
    for c in text:gmatch(".") do
        screen.write(c)
        sleep(lap)
    end
    return
end

local function awaitInput(prein, type)
  screen.setCursorPos(1, sy)
  screen.setCursorBlink(true)
  screen.clearLine()
  if not prein then
    input = ""
  else
    input = prein
  end
  screen.write("> " .. input)
  while true do
    local event, key = os.pullEvent()
    if event == "key" then
        if keys.getName(key) == "enter" then
            if #input > 0 then
                screen.setCursorBlink(false)
                screen.clearLine()
                screen.setCursorPos(1, 1)
                screen.write(">")
                return input
            else
                screen.setCursorPos(1, sy)
                screen.setTextColor(colors.red)
                screen.write("> ")
                sleep(1)
                screen.setCursorPos(1, sy)
                screen.clearLine()
                screen.setTextColor(colors.white)
                screen.write("> ")
            end
        elseif keys.getName(key) == "backspace" then
            local cx, cy = screen.getCursorPos()
            if cx > 3 then
                input=input.sub(1, #input-1)
                screen.setCursorPos(cx-1, cy)
                screen.write(" ")
                screen.setCursorPos(cx-1, cy)
            end
        end
    elseif event == "char" then
        input = input..key
        screen.write(key)
    end
  end
end

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
settings.set("netpassword", sha256(awaitInput(nil, "pass")))
typeOut("Please type a user name.", 0.5)
settings.set("username", awaitInput("admin"))
typeOut("Please type a login password.", 0.5)
settings.set("logpassword", sha256(awaitInput(nil, "pass")))
typeOut("Would you like to use Monitor Mode? (true/false)", 0.5)
settings.set("monitormode", awaitInput(nil, "bool"))
if settings.get("monitormode") == true then
    typeOut("What is the ID of the monitor?", 0.5)
    settings.set("monitor", awaitInput(nil, "int"))
end
typeOut("Would you like to restart setup? You can access this at any time by typing 'setup' in the shell.", 1.5)
local restart = awaitInput(nil, "bool")
if restart then
    settings.save(".wyos")
    multishell.launch({}, "/sys/apps/setup.lua")
    multishell.closeTab(multishell.currentTab())
else
    settings.set("setup", true)
    settings.save(".wyos")
    multishell.closeTab(mulishell.currentTab())
end
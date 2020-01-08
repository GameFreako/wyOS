settings.load(".wyos")

if (settings.get("monitormode") == 3) then
    term.redirect(peripheral.wrap(settings.get("monitor")))
end

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
        if not type == "password" then
            input = input..key
            local cx, cy = screen.getCursorPos()
            if cx > 3 then
                screen.setCursorPos(cx-1, cy)
                screen.write('*' .. key)
            else
                screen.write(key)
            end
        end
    end
  end
end

term.clear()
typeOut("username: ", 0.25)
local username = awaitInput(nil, "text")
typeOut("password: ", 0.25)
local password = awaitInput(nil, "password")
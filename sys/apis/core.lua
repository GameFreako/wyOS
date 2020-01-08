function typeOut(text, time)
    term.setCursorPos(1, sy-5)
    term.clearLine()
    if not time then time = 2 end
    if time == 0 then
        term.write(text);
        return;
    else
        local lap = time/text:len()
        for c in text:gmatch(".") do
            term.write(c)
            sleep(lap)
        end
        return
    end
end

function awaitInput(prein, type)
  term.setCursorPos(1, sy)
  term.setCursorBlink(true)
  term.clearLine()
  if not prein then
    input = ""
  else
    input = prein
  end
  term.write("> " .. input)
  while true do
    local event, key = os.pullEvent()
    if event == "key" then
        if keys.getName(key) == "enter" then
            if #input > 0 then
                if type == "bool" then
                    if input == "true" then
                        term.setCursorBlink(false)
                        term.clearLine()
                        term.setCursorPos(1, sy)
                        term.write(">")
                        return true
                    elseif input == "false" then
                        term.setCursorBlink(false)
                        term.clearLine()
                        term.setCursorPos(1, sy)
                        term.write(">")
                        return false
                    else
                        term.setCursorPos(1, sy)
                        term.setTextColor(colors.red)
                        term.write("> ")
                        sleep(1)
                        term.setCursorPos(1, sy)
                        term.clearLine()
                        input = ""
                        term.setTextColor(colors.white)
                        term.write("> ")
                    end
                else
                    term.setCursorBlink(false)
                    term.clearLine()
                    term.setCursorPos(1, sy)
                    term.write(">")
                    return input
                end
            else
                term.setCursorPos(1, sy)
                term.setTextColor(colors.red)
                term.write("> ")
                sleep(1)
                term.setCursorPos(1, sy)
                term.clearLine()
                input = ""
                term.setTextColor(colors.white)
                term.write("> ")
            end
        elseif keys.getName(key) == "backspace" then
            local cx, cy = term.getCursorPos()
            if cx > 3 then
                input=input.sub(1, #input-1)
                term.setCursorPos(cx-1, cy)
                term.write(" ")
                term.setCursorPos(cx-1, cy)
            end
        end
    elseif event == "char" then
        input = input..key
        if type == "password" then
            local cx, cy = term.getCursorPos()
            if cx > 3 then
                term.setCursorPos(cx-1, cy)
                term.write('*' .. key)
            else
                term.write(key)
            end
        else
            term.write(key)
        end
    end
  end
end
local args = {...}
if args[1] == "MONITOR" then
    screen = peripheral.wrap(args[2])
    if not screen then
        screen = term
    end
else
    screen = term
end

-- this is how there is a logout button in multishell
-- but is also the network manager, and does general things for the operating system.
print("please wait")
sleep(2)

while true do
    local tid = os.setTimer(5)
    local event, arg1, arg2, arg3, arg4 = os.pullEvent()
    if event == "term_click" then
        if (multishell.getFocus() == multishell.getCurrent()) then
            logout()
        end
    elseif event == "timer" and arg1 == tid then

    end
end
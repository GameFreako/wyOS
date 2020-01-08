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
multishell = multishell

multishell.launch({}, "/rom/programs/shell.lua")
multishell.setTitle(multishell.getCurrent(), "Logout")

while true do
    local event, arg1, arg2, arg3, arg4 = os.pullEvent()
    if (event == "term_click") then
        if (multishell.getFocus() == multishell.getCurrent()) then
            logout()
        end
    end
end
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
-- but this does a heck lot more
-- This is also the netdaemon and is pretty much the kernal or crap and what not.

launch("rom/programs/shell.lua")
multishell.setTitle(multishell.getCurrent(), "Logout")

while true do
    local event, arg1, arg2, arg3, arg4 = os.pullEventRaw()
    if (event == "terminate") then
        if (multishell.getFocus() == multishell.getCurrent()) then
            os.reboot() -- this should never be able to happen, but just in case it does...
        elseif (multishell.getTitle(multishell.getFocus()) == "Console") then
            -- no just no
        else
            multishell.closeTab(multishell.getFocus())
        end
    end
end
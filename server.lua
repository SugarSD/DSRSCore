local playerList = {}
local registeredScripts = {}
local lastScriptID = 0

RegisterNetEvent("DSRS:updateLocation", function(coords)
    local src = source
    playerList[src] = coords
    print(playerList[src]);
end)

RegisterNetEvent("DSRS:registerScript", function(coords, distance, startc, endc, scriptName)
    if (coords.xyz and type(distance) == "number" and type(startc) == "string" and type(endc) == "string") then
        local scriptID = lastScriptID + 1
        local scriptData = {
            coords = coords,
            distance = distance,
            startc = startc,
            endc = endc
        }
        registeredScripts[scriptID] = scriptData
        lastScriptID += 1
    else
        if (scriptName) then
            print("DSRSCore: Failed to register the following script (" .. scriptName .. ")! Please ensure the script passed all the REQUIRED values.");
        else
            print("DSRSCore: Failed to register a script! Please ensure the script passed all the REQUIRED values.");
        end
    end
end)
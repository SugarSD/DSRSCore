local playerList = {}
local registeredScripts = {}
local lastScriptID = 0

RegisterNetEvent("DSRS:updateLocation", function(coords)
    local src = source
    playerList[src] = coords
end)

RegisterNetEvent("DSRS:registerScript", function(coords, distance, startc, endc, scriptName)
    if (coords.xyz and type(distance) == "number" and type(startc) == "string" and type(endc) == "string") then
        local scriptID = lastScriptID + 1
        local scriptData = {
            coords = vector3(coords.x, coords.y, coords.z),
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

Citizen.CreateThread(function()
    while true do
        for source, coords in ipairs(playerList) do
            for scriptID, scriptData in ipairs(registeredScripts) do
                local distanceFromPlayer = #(coords - scriptData.coords);
                if (distanceFromPlayer <= scriptData.distance) then
                    TriggerClientEvent(scriptData.startc, source);
                elseif (distanceFromPlayer > scriptData.distance) then
                    TriggerClientEvent(scriptData.endc, source);
                end
            end
        end
        Wait(500);
    end
end)
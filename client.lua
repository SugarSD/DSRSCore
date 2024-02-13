
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId());
        TriggerServerEvent("DSRS:updateLocation", playerCoords);
        Wait(200)
    end
end
)
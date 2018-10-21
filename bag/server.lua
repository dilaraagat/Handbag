RegisterCommand("bag", function(source, args, raw)
    local src = source
    TriggerClientEvent("Bag:ToggleBag", src)
end)

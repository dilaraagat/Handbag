---- MADE BY ANATOLIA TURKEY ----


local holdingBag = false
local usingBag = false
local bagModel = "prop_ld_case_01"
local baganimDict = "missheistdocksprep1hold_cellphone"
local baganimName = "hold_cellphone"
local bag_net = nil
local UI = { 
	x =  0.000 ,
	y = -0.001 ,
}


---------------------------------------------------------------------------
--canta cikarma --
---------------------------------------------------------------------------
RegisterNetEvent("Bag:ToggleBag")
AddEventHandler("Bag:ToggleBag", function()
    if not holdingBag then
        RequestModel(GetHashKey(bagModel))
        while not HasModelLoaded(GetHashKey(bagModel)) do
            Citizen.Wait(100)
        end
		
		while not HasAnimDictLoaded(baganimDict) do
			RequestAnimDict(baganimDict)
			Citizen.Wait(100)
		end

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local bagspawned = CreateObject(GetHashKey(bagModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local netid = ObjToNet(bagspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(bagspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 57005), 0.15, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), baganimDict, baganimName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        bag_net = netid
        holdingBag = true
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(bag_net), 1, 1)
        DeleteEntity(NetToObj(bag_net))
        bag_net = nil
        holdingBag = false
        usingBag = false
    end	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingBag then
			while not HasAnimDictLoaded(baganimDict) do
				RequestAnimDict(baganimDict)
				Citizen.Wait(100)
			end
			DisablePlayerFiring(PlayerId(), true)
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0, 44,  true) -- INPUT_COVER
			DisableControlAction(0,37,true) -- INPUT_SELECT_WEAPON
			SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
		end
	end
end)

function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end

function DisplayNotification(string)
	SetTextComponentFormat("STRING")
	AddTextComponentString(string)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


--- BASINI DA CAL OROSPUCOCUGU

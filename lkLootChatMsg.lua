
MyAddon = LibStub("AceAddon-3.0"):NewAddon("MyAddon", "AceEvent-3.0")

MyAddon:RegisterEvent("SpecialEvents_ItemLooted", "LootMsg")

function MyAddon:LootMsg(who, item, number)
    FindFrame("Loot", who .. " ∞»°¡À" .. item .. "x" .. number)
end


--[[ Window and Chat Functions ]]--
function FindFrame(toFrame, msg)
	for i=1,NUM_CHAT_WINDOWS do
		local name = GetChatWindowInfo(i)
		if (toFrame == name) then
			toFrame = _G["ChatFrame" .. i]
			toFrame:AddMessage(msg)
		elseif (toFrame ~= name) then
		    --Todo
        end
	end
end
	

MyAddon = LibStub("AceAddon-3.0"):NewAddon("Myaddon", "AceEvent-3.0")

g_chatframename = "掉落"

function MyAddon:OnEnable()
    print("|cffffff00紫色掉落物品插件已经加载(作者:童童宝宝-伊利丹)，将会在'" .. g_chatframename .. "'聊天栏里显示紫色及以上物品掉落和roll点数")
    OpenNewWindow(g_chatframename)
    MyAddon:RegisterEvent("CHAT_MSG_LOOT")
    MyAddon:RegisterEvent("CHAT_MSG_SYSTEM")
end

function MyAddon:CHAT_MSG_SYSTEM(event, Text)
    if (string.find(Text,"掷出")) then
         FindFrame(g_chatframename, "|cffffff00" .. Text)
        return
    end
end

function MyAddon:CHAT_MSG_LOOT(event, Text)
    if (string.find(Text,"|cff9d9d9d")) then
        return
    elseif (string.find(Text,"|cffffffff")) then
        return
    elseif (string.find(Text,"|cff1eff00")) then
        --FindFrame("Loot", "A Green item" .. Text)
        return		
    end
    FindFrame(g_chatframename, Text)
end


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

function OpenNewWindow(name)
	local count = 1;
	local chatFrame, chatTab;

	for i=1, NUM_CHAT_WINDOWS do
    local window_name = GetChatWindowInfo(i) 
    ----print("--------------")
    ----print(window_name)
    ----print(name)

    if window_name and window_name == name then
      --print("close")
      chatFrame = _G["ChatFrame"..i];
      FCF_Close(chatFrame)
    end
    
    --print("in")
    local _, _, _, _, _, _, shown = FCF_GetChatWindowInfo(i);
    chatFrame = _G["ChatFrame"..i];
    chatTab = _G["ChatFrame"..i.."Tab"];
    if ( (not shown and not chatFrame.isDocked) or (count == NUM_CHAT_WINDOWS) ) then
      if ( not name or name == "" ) then
        name = format(CHAT_NAME_TEMPLATE, i);			
      end

      --print("creating")
      -- initialize the frame
      FCF_SetWindowName(chatFrame, name);
      FCF_SetWindowColor(chatFrame, DEFAULT_CHATFRAME_COLOR.r, DEFAULT_CHATFRAME_COLOR.g, DEFAULT_CHATFRAME_COLOR.b);
      FCF_SetWindowAlpha(chatFrame, DEFAULT_CHATFRAME_ALPHA);
      SetChatWindowLocked(i, nil);

      -- clear stale messages
      chatFrame:Clear();

      -- Listen to the standard messages
      ChatFrame_RemoveAllMessageGroups(chatFrame);
      ChatFrame_RemoveAllChannels(chatFrame);
      ChatFrame_ReceiveAllPrivateMessages(chatFrame);
      ChatFrame_ReceiveAllBNConversations(chatFrame);

      --Clear the edit box history.
      chatFrame.editBox:ClearHistory();

      -- Show the frame and tab
      chatFrame:Show();
      chatTab:Show();
      SetChatWindowShown(i, 1);

      -- Dock the frame by default
      FCF_DockFrame(chatFrame, (#FCFDock_GetChatFrames(GENERAL_CHAT_DOCK)+1), true);
      FCF_FadeInChatFrame(FCFDock_GetSelectedWindow(GENERAL_CHAT_DOCK));
      --print("created")
      return chatFrame;
    end
    count = count + 1;
	end
end


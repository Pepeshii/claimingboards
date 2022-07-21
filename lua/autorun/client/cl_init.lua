--[[
     ___ _______    PZSolutions 
    | _ \_  / __|       copyright
    |  _// /\__ \           06.2022
    |_| /___|___/   "Modern day request
                        modern solution"
]]

net.Receive("PZSCBRequestMenu", function()
    local board = net.ReadEntity()

    local frame = vgui.Create("DFrame")
    frame:SetPos(ScrW() * 0.5 - 150, 100) 
    frame:SetSize( 300, 280 ) 
    frame:SetTitle("PZSolutions - Claming Boards") 
    frame:SetVisible(true) 
    frame:SetDraggable(true) 
    frame:ShowCloseButton(true) 
    frame:MakePopup()
    
    local txt = ""
    local entrytext = vgui.Create("DTextEntry", frame)
    entrytext:SetPos(10, 50)
    entrytext:SetSize(200, 220)
    entrytext:SetMultiline(true)
    if IsValid(board) then
        if IsValid(board:GetClaimer()) then
            txt = board:GetDesc()
        else
            txt = LoadFromFile() or "" 
        end
    end
    entrytext:SetValue(txt)
    
    local claimbtn = vgui.Create("DButton", frame)
    claimbtn:SetPos(10, 24)
    claimbtn:SetSize(280, 24)
    local claimtxt = ""
    if IsValid(board:GetClaimer()) then claimtxt = PZSCB.lang.menu.unclaim else claimtxt = PZSCB.lang.menu.claim end
    claimbtn:SetText(claimtxt)
    function claimbtn:DoClick()
        local newstring = LimitText(entrytext:GetValue())
        if newstring == nil then SendError(1) else
        net.Start("PZSCBRequestClaim", false) net.WriteString(newstring) net.SendToServer()
        frame:Close()
        end
    end

    local savebtn = vgui.Create("DButton", frame)
    savebtn:SetPos(212, 50)
    savebtn:SetSize(78, 24)
    savebtn:SetText(PZSCB.lang.menu.save)
    function savebtn:DoClick() SaveToFile(entrytext:GetValue()) SendError(5) end
    
    local loadbtn = vgui.Create("DButton", frame)
    loadbtn:SetPos(212, 80)
    loadbtn:SetSize(78, 24)
    loadbtn:SetText(PZSCB.lang.menu.load)
    function loadbtn:DoClick() 
        local loadedtxt, correctload = LoadFromFile()
        if correctload then entrytext:SetValue(loadedtxt) SendError(4) else
            SendError(3)
        end
    end
    
    local updtbtn = vgui.Create("DButton", frame)
    updtbtn:SetPos(212, 110)
    updtbtn:SetSize(78, 24)
    updtbtn:SetText(PZSCB.lang.menu.update)
    function updtbtn:DoClick() 
        local fixedstring = LimitText(entrytext:GetValue())
        if fixedstring == nil then SendError(1) else
            net.Start("PZSCBUpdateDesc", false)
                net.WriteString(fixedstring)
            net.SendToServer()
            frame:Close()
        end
    end
end)

function LimitText(str)
    local texttable = string.Explode("\n", str)
    for i, line in ipairs(texttable) do
        if string.len(line) > 42 then
            local line1 = string.sub(line, 0, 41)
            local line2 = string.sub(line, 42)
            texttable[i] = line1
            table.insert(texttable, i + 1, line2)
        end
    end
    if table.getn(texttable) > 17 then return nil end

    local newstr = string.Implode("\n", texttable)
    return newstr
end

function SaveToFile(savefile)
    if !file.IsDir("PZS", "DATA") then file.CreateDir("PZS") end
    file.Write("PZS/claimboard.txt", savefile)
end

function LoadFromFile()
    if !file.IsDir("PZS", "DATA") then return nil, false end
    if !file.Exists("PZS/claimboard.txt", "DATA") then return nil, false end
    local savedstring = file.Read("PZS/claimboard.txt", "DATA")
    return savedstring, true
end

function SendError(id)
    if id == 1 then
        MsgC(Color(100, 200, 100, 255), PZSCB.lang.error1 .. "\n")
        surface.PlaySound("items/medshotno1.wav")
        notification.AddLegacy(PZSCB.lang.error1, NOTIFY_ERROR	, 3)
    elseif id == 2 then
        MsgC(Color(100, 200, 100, 255), PZSCB.lang.error2 .."\n")
        surface.PlaySound("items/medshotno1.wav")
        notification.AddLegacy(PZSCB.lang.error2, NOTIFY_ERROR, 3)
    elseif id == 3 then
        MsgC(Color(100, 200, 100, 255), PZSCB.lang.error3 .."\n")
        surface.PlaySound("items/medshotno1.wav")
        notification.AddLegacy(PZSCB.lang.error3, NOTIFY_ERROR, 3)
    elseif id == 4 then
        MsgC(Color(100, 200, 100, 255), (PZSCB.lang.notification4 .. "\n"))
        surface.PlaySound("hl1/fvox/bell.wav")
        notification.AddLegacy(PZSCB.lang.notification4, NOTIFY_GENERIC, 3)
    elseif id == 5 then
        MsgC(Color(100, 200, 100, 255), (PZSCB.lang.notification3 .. "\n"))
        surface.PlaySound("hl1/fvox/bell.wav")
        notification.AddLegacy(PZSCB.lang.notification3, NOTIFY_GENERIC, 3)
    end
end

net.Receive("PZSCBRequestNotify", function(_, ply)
    local notifyID = net.ReadInt(3)
    if notifyID == 0 then
        MsgC(Color(100, 200, 100, 255), (PZSCB.lang.notification1 .. "\n"))
        surface.PlaySound("hl1/fvox/bell.wav")
        notification.AddLegacy(PZSCB.lang.notification1, NOTIFY_GENERIC, 3)
    elseif notifyID == 1 then
        MsgC(Color(100, 200, 100, 255), (PZSCB.lang.notification2 .. "\n"))
        surface.PlaySound("hl1/fvox/bell.wav")
        notification.AddLegacy(PZSCB.lang.notification2, NOTIFY_GENERIC, 3)
    elseif notifyID == 3 then
        MsgC(Color(100, 200, 100, 255), PZSCB.lang.error4 .."\n")
        surface.PlaySound("items/medshotno1.wav")
        notification.AddLegacy(PZSCB.lang.error4, NOTIFY_ERROR, 3)
    end
end)
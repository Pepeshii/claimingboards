--[[
     ___ _______    PZSolutions 
    | _ \_  / __|       copyright
    |  _// /\__ \           06.2022
    |_| /___|___/   "Modern day request
                        modern solution"
]]
AddCSLuaFile()

if SERVER then
    timer.Simple(1, function()
        PZSCBJobs ={                        -- Jobs able to claim add here
            [TEAM_CITIZEN] = true,
            [TEAM_POLICE] = true
        }
    end)
end

PZSCB = {
    ["groups"] = {                  -- Admins add here
        ["owner"] = true,
        ["superadmin"] = true
    },
    ["colors"] = {
        ["header"] = Color(80, 80, 80, 255),        -- Color of background in header
        ["header_text"] = Color(255, 255, 255, 255),-- Color of text in header
        ["header_usejobcolor"] = true,              -- Use color from jobs
        ["body"] = Color(60, 60, 60, 255),          -- Color of background in body and footer
        ["body_text"] = Color(255, 255, 255, 255)   -- Color of text in body and footer
    },
    ["lang"] = {
        ["unclaimed"] = "Unclaimed",
        ["nobody"] = "Nobody",
        ["claimed_by"] = "Claimed by:",
        ["error1"] = "Text is to long!",
        ["error2"] = "You isn't claim this board!",
        ["error3"] = "Can't load file!",
        ["error4"] = "You can't claim more boards!",
        ["notification1"] = "Claimed board successful!",
        ["notification2"] = "Unclaimed board successful!",
        ["notification3"] = "Saved successful!",
        ["notification4"] = "Loaded successful!",
        ["menu"] = {                                -- Clientside menu
            ["claim"] = "Claim",
            ["unclaim"] = "Unclaim",
            ["save"] = "Save",
            ["load"] = "Load",
            ["update"] = "Update"
        }
    }
}

PZSCB = PZSCB or {}
--[[
     ___ _______    PZSolutions 
    | _ \_  / __|       copyright
    |  _// /\__ \           06.2022
    |_| /___|___/   "Modern day request
                        modern solution"
]]
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    local ang = self:GetAngles()
    ang:RotateAroundAxis(self:GetAngles():Forward(), 90)
    ang:RotateAroundAxis(self:GetAngles():Up(), 180)

    cam.Start3D2D(self:GetPos(), ang, 0.1)
        -- header
        draw.RoundedBox(0, -275, -900, 500, 100, PZSCB.colors.header)
        draw.DrawText(self.category, "HeadFont", -22, -880, self.colorcategory, TEXT_ALIGN_CENTER)
        -- body
        draw.RoundedBox(0, -275, -800, 500, 640, PZSCB.colors.body)
        draw.DrawText(self:GetDesc(), "BodyFont", -250, -780, PZSCB.colors.body_text, TEXT_ALIGN_LEFT)
        -- footer
        draw.DrawText("Claimed By:", "BodyFont", -250, -250, PZSCB.colors.body_text, TEXT_ALIGN_LEFT)
        draw.DrawText(self.nick, "BodyFont", -250, -220, PZSCB.colors.body_text, TEXT_ALIGN_LEFT)
    cam.End3D2D()
end

function ENT:Think()
    self:NetworkVarNotify("Claimer", self.OnVarChanged)
end

function ENT:OnVarChanged(name, old, new)
    if IsValid(new) then
        self.nick = new:Nick()
        self.category = new:getJobTable()["category"]
        if PZSCB.colors.header_usejobcolor then
            self.colorcategory = new:getJobTable()["color"]
        else
            self.colorcategory = PZSCB.colors.header_text
        end
    else
        self.nick = PZSCB.lang.nobody
        self.category = PZSCB.lang.unclaimed
        self.colorcategory = PZSCB.colors.header_text
    end
end

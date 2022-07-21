--[[
     ___ _______    PZSolutions 
    | _ \_  / __|       copyright
    |  _// /\__ \           06.2022
    |_| /___|___/   "Modern day request
                        modern solution"
]]
AddCSLuaFile("cl_init.lua")
include("shared.lua")


local netstr = {
    "PZSCBRequestMenu",
    "PZSCBRequestClaim",
    "PZSCBUpdateDesc",
    "PZSCBRequestNotify"
}

for _, str in ipairs(netstr) do util.AddNetworkString(str) end

function ENT:Initialize()
    self:SetModel("models/pzs_models/claming_board/board.mdl")
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator)
    if activator:IsPlayer() then
        if CheckPlayer(activator) then
            activator.board = self
            net.Start("PZSCBRequestMenu") net.WriteEntity(self) net.Send(activator)
        end
    end
end

function ENT:Think()
    if not IsValid(self:GetClaimer()) then
        self:SetClaimer(nil)
        self:SetDesc("")
    end
end

net.Receive("PZSCBRequestClaim", function(_, ply)
    local recivedboard = ply.board
    local curstate = 0
    if not IsValid(recivedboard) or not IsValid(ply) then return end
    if IsValid(recivedboard:GetClaimer()) then
        if recivedboard:GetClaimer() == ply or CheckAdmin(ply) then
            recivedboard:SetClaimer(nil)
            curstate = 1
            ply.claims = false
        end
    else
        if ply.claims == false or ply.claims == nil then
            recivedboard:SetClaimer(ply)
            recivedboard:SetDesc(net.ReadString())
            ply.claims = true
            curstate = 0
        else
            curstate = 3
        end
    end
    net.Start("PZSCBRequestNotify", false) net.WriteInt(curstate, 3) net.Send(ply)
end)

net.Receive("PZSCBUpdateDesc", function(_, ply)
    local recivedboard = ply.board
    if not IsValid(recivedboard) then return end
    if IsValid(recivedboard:GetClaimer()) then
        if recivedboard:GetClaimer() == ply or CheckAdmin(ply) then
            recivedboard:SetDesc(net.ReadString())
        end
    end
end)

function CheckPlayer(ply)
    for k, _ in pairs(PZSCBJobs) do
        if ply:Team() == k then return true end
    end
    if CheckAdmin(ply) then return true end
    return false
end
function CheckAdmin(ply)
    for k, _ in pairs(PZSCB.groups) do
        if ply:GetUserGroup() == k then return true end
    end
    return false
end
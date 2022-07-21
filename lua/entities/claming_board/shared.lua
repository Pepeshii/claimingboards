--[[
     ___ _______    PZSolutions 
    | _ \_  / __|       copyright
    |  _// /\__ \           06.2022
    |_| /___|___/   "Modern day request
                        modern solution"
]]
AddCSLuaFile()
include("cb_config.lua")

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Claming Board"
ENT.Spawnable = true
ENT.Editable = true
ENT.AdminOnly = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Claimer")
    self:NetworkVar("String", 0, "Desc")

    self.nick = PZSCB.lang.nobody
    self.category = PZSCB.lang.unclaimed
    self.colorcategory = PZSCB.colors.header_text
end

if SERVER then
    ENT.DoNotDuplicate = true
    ENT.DisableDuplicator = true
else
    ENT.Category = "PZSolutions"
    --ENT.IconOverride = ""

    surface.CreateFont("HeadFont", {
        font = "Sansation",
        extended = false,
        size = 32,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = true,
        additive = false,
        outline = false,
    })
    surface.CreateFont("BodyFont", {
        font = "Sansation Light",
        extended = false,
        size = 24,
        weight = 500,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    })    
end


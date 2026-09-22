--[[
    Thermite b0.1

    Developed by TheNuggetEater05 / Jayden

    Thermite is a reverse engineering suite designed for roblox games.

    Current finished features:
        * None

    Planned features: 
        * Game explorer (like dex)
        * Remote[Function/Event] inspector
        * Script inspector (upvalues, constants, protos, etc)

    Thermite is entirely open-source, forks + pull-requests are allowed and appreciated.
]]

local function load_module(module: string, source: {[any] : any})
    local path = "thermite/modules/"

    if not isfolder(path) then
        makefolder(path)
    end

    if not isfile(path..module..".lua") then
        writefile(path..module..".lua", source)
    end

    getgenv()[module] = loadstring(readfile(path..module..".lua"))()
end

if getgenv().thermite_unload then
    getgenv().thermite_unload()
end

load_module("Logging", game:HttpGet("https://raw.githubusercontent.com/TheNuggetEater05/Thermite/refs/heads/main/modules/Logging.lua", false))
load_module("UI_Utils", game:HttpGet("https://raw.githubusercontent.com/TheNuggetEater05/Thermite/refs/heads/main/modules/UI_Utils.lua", false))
load_module("UI", game:HttpGet("https://raw.githubusercontent.com/TheNuggetEater05/Thermite/refs/heads/main/modules/UI.lua", false))

load_module("Thermite", game:HttpGet("https://raw.githubusercontent.com/TheNuggetEater05/Thermite/refs/heads/main/modules/Thermite.lua", false))
local thermite = {
    logging = {},
    ui = {},
}

function thermite.init(self)
    self.logging = getgenv().Logging
    self.ui = getgenv().UI

    -- create UI
    self.ui:init()
    
end

thermite:init()

getgenv().thermite_unload = function()
    thermite.ui.screengui:Destroy()

    getgenv().UI = nil
    getgenv().UI_Utils = nil

    thermite.logging:log("Thermite unloaded.", 1)
    getgenv().Logging = nil
end

return thermite
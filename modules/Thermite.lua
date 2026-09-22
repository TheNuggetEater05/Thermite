local thermite = {
    logging = {},
    ui = {},
    ui_utils = {},
}

function thermite.init(self)
    self.logging = getgenv().Logging
    self.ui_utils = getgenv().UI_Utils
    self.ui = getgenv().UI

    -- create UI
    self.ui_utils:init()
    self.ui:init()
    
    self.logging:log("thermite: initialized.")
end

thermite:init()

getgenv().thermite_unload = function()
    thermite.ui.screengui:Destroy()

    getgenv().UI = nil
    getgenv().UI_Utils = nil

    thermite.logging:log("thermite: unloaded.", 1)
    getgenv().Logging = nil
end

return thermite
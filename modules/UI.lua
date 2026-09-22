local ui = {
    screengui = nil,
    logging = {},
    ui_utils = {},

    themes = {
        thermite = {
            background = Color3.fromRGB(18, 18, 18),
            inner_stroke = Color3.fromRGB(85, 85, 85),
            outer_stroke = Color3.fromRGB(0, 0, 0)
        }
    },

    current_theme = {
        background = Color3.fromRGB(18, 18, 18),
        inner_stroke = Color3.fromRGB(85, 85, 85),
        outer_stroke = Color3.fromRGB(0, 0, 0)
    }
}

if getgenv().thermite_unload then
    getgenv().thermite_unload()
end

function ui.create(self)
    local screengui = self.ui_utils:inst("ScreenGui", {
        Parent = gethui(),
        Name = "Thermite" -- TODO: random name gen
    })
    self.screengui = screengui
end

function ui.make_sidebar(self)
    local sidebar = self.ui_utils:inst("Frame", {
        Parent = self.screengui,
        AnchorPoint = Vector2.new(1, 0.5),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = self.current_theme.background,
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromScale(0.03, 0)
    })

    -- sidebar uicorner
    self.ui_utils:inst("UICorner", {
        Parent = sidebar,
        TopLeftRadius = UDim.new(0, 8),
        BottomLeftRadius = UDim.new(0, 8),
        BottomRightRadius = UDim.new(0, 0),
        TopRightRadius = UDim.new(0, 0)
    })

    -- sidebar inner stroke
    self.ui_utils:inst("UIStroke", {
        Parent = sidebar,
        BorderStrokePosition = Enum.BorderStrokePosition.Inner,
        Color = self.current_theme.inner_stroke,
        Thickness = 1
    })

    -- sidebar outer stroke
    self.ui_utils:inst("UIStroke", {
        Parent = sidebar,
        BorderStrokePosition = Enum.BorderStrokePosition.Outer,
        Color = self.current_theme.outer_stroke,
        Thickness = 1
    })

    -- sidebar layout
    self.ui_utils:inst("UIListLayout", {
        Parent = sidebar,
        Padding = UDim.new(0, 4),
        FillDirection = Enum.FillDirection.Vertical,
        VerticalAlignment = Enum.VerticalAlignment.Center
    })

    local explorer_frame = self.ui_utils:inst("Frame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 50)
    })

    local explorer_button = self.ui_utils:inst("ImageButton", {
        Parent = explorer_frame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.6, 0.6),
        Image = "http://www.roblox.com/asset/?id=6034925620",
        ImageTransparency = 0.75
    })

    local explorer_frame = self.ui_utils:inst("Frame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 50)
    })

    local explorer_button = self.ui_utils:inst("ImageButton", {
        Parent = explorer_frame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.6, 0.6),
        Image = "http://www.roblox.com/asset/?id=6034925620",
        ImageTransparency = 0.75
    })

    local explorer_frame = self.ui_utils:inst("Frame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 50)
    })

    local explorer_button = self.ui_utils:inst("ImageButton", {
        Parent = explorer_frame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.6, 0.6),
        Image = "http://www.roblox.com/asset/?id=6034925620",
        ImageTransparency = 0.75
    })

    local explorer_frame = self.ui_utils:inst("Frame", {
        Parent = sidebar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 50)
    })

    local explorer_button = self.ui_utils:inst("ImageButton", {
        Parent = explorer_frame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.6, 0.6),
        Image = "http://www.roblox.com/asset/?id=6034925620",
        ImageTransparency = 0.75
    })
end

function ui.init(self)
    self.logging = getgenv().Logging
    self.ui_utils = getgenv().UI_Utils

    ui:create()

    if not self.screengui then
        self.logging:log("ui.init: self.screengui doesn't exist")
        return
    end

    ui:make_sidebar()

    getgenv().thermite_unload = function()
        ui.screengui:Destroy()
    end
end

ui:init()

return ui
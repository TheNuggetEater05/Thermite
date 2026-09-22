local ui = {
    screengui = nil,
    logging = {},
    ui_utils = {},

    themes = {
        thermite = {
            background = Color3.fromRGB(18, 18, 18),
            inner_stroke = Color3.fromRGB(85, 85, 85),
            outer_stroke = Color3.fromRGB(0, 0, 0),
            text = Color3.fromRGB(150, 150, 150)
        }
    },

    current_theme = {
        background = Color3.fromRGB(18, 18, 18),
        inner_stroke = Color3.fromRGB(85, 85, 85),
        outer_stroke = Color3.fromRGB(0, 0, 0),
        text = Color3.fromRGB(150, 150, 150)
    }
}

function ui.create(self)
    local screengui = self.ui_utils:inst("ScreenGui", {
        Parent = gethui(),
        Name = "Thermite" -- TODO: random name gen
    })
    self.screengui = screengui
end

function ui.make_button(self, name: string?, icon: string?, callback: () -> ()?)
    name = name or "name"
    icon = icon or "http://www.roblox.com/asset/?id=6034925620"
    callback = callback or function() end

    local frame = self.ui_utils:inst("Frame", {
        Name = name.."_frame",
        Parent = self.screengui:WaitForChild("sidebar"),
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 50)
    })

    local button = self.ui_utils:inst("ImageButton", {
        Name = name.."_button",
        Parent = frame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.6, 0.6),
        Image = icon,
        ImageTransparency = 0.75
    })

    button.MouseButton1Click:Connect(function()
        callback()
    end)
end

function ui.explorer_window(self)
    if self.screengui:FindFirstChild("explorer_window") then
        self.screengui.explorer_window.Visible = not self.screengui.explorer_window.Visible
    else
        local window = self.ui_utils:inst("Frame", {
            Name = "explorer_window",
            Parent = self.screengui,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = self.current_theme.background,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(450, 600)
        })

        -- window inner stroke
        self.ui_utils:inst("UIStroke", {
            Parent = window,
            BorderStrokePosition = Enum.BorderStrokePosition.Inner,
            Color = self.current_theme.inner_stroke,
            Thickness = 1
        })

        -- window outer stroke
        self.ui_utils:inst("UIStroke", {
            Parent = window,
            BorderStrokePosition = Enum.BorderStrokePosition.Outer,
            Color = self.current_theme.outer_stroke,
            Thickness = 1
        })

        -- window uicorner
        self.ui_utils:inst("UICorner", {
            Parent = window,
            TopLeftRadius = UDim.new(0, 0),
            BottomLeftRadius = UDim.new(0, 8),
            BottomRightRadius = UDim.new(0, 8),
            TopRightRadius = UDim.new(0, 0)
        })

        -- topbar
        local topbar = self.ui_utils:inst("Frame", {
            Parent = window,
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 0.95,
            Position = UDim2.fromScale(0.5, 0),
            Size = UDim2.new(1, 0, 0, 25)
        })

        -- topbar inner stroke
        self.ui_utils:inst("UIStroke", {
            Parent = topbar,
            BorderStrokePosition = Enum.BorderStrokePosition.Inner,
            Color = self.current_theme.inner_stroke,
            Thickness = 1
        })

        self.ui_utils:inst("TextLabel", {
            Parent = topbar,
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 8, 0.5, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            FontFace = self.ui_utils.fonts.ProggyClean,
            Text = "Explorer",
            TextColor3 = self.current_theme.text,
            TextStrokeTransparency = 0,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left
        })
    end
end

function ui.make_sidebar(self)
    local sidebar = self.ui_utils:inst("Frame", {
        Name = "sidebar",
        Parent = self.screengui,
        AnchorPoint = Vector2.new(1, 0.5),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = self.current_theme.background,
        Position = UDim2.fromScale(1, 0.5),
        Size = UDim2.fromOffset(50, 0)
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

    self:make_button("Explorer", "http://www.roblox.com/asset/?id=6034925620", function() 
        self:explorer_window()
    end)
    self:make_button("Remote Inspector", "http://www.roblox.com/asset/?id=6031763426")
    self:make_button("Script Inspector", "http://www.roblox.com/asset/?id=6022668955")
end

function ui.init(self)
    self.logging = getgenv().Logging
    self.ui_utils = getgenv().UI_Utils

    -- load font
    self.ui_utils:register_font("ProggyClean.ttf", game:HttpGet("https://github.com/bluescan/proggyfonts/raw/refs/heads/master/ProggyOriginal/ProggyClean.ttf"))
    
    ui:create()

    if not self.screengui then
        self.logging:log("ui.init: self.screengui doesn't exist")
        return
    end

    ui:make_sidebar()
end

return ui
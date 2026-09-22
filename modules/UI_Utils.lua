local ui_utils = {
    fonts = {},
    logging = {}
}

do
    function ui_utils.init(self)
        self.logging = getgenv().Logging
    end

    function ui_utils.inst(self, object_type: string, properties: {[any] : any})
        local instance = nil

        local success, error = xpcall(function()
            instance = Instance.new(object_type)

            for property, value in pairs(properties) do
                instance[property] = value
            end
        end, function(err)
            self.logging:log(err, 3)
        end)

        return instance
    end

    function ui_utils.register_font(self, font_name: string, source: string?)
        source = source or ""
        local font_parent_dir = "thermite/assets/fonts/"
        
        local font_path = tostring(font_parent_dir..font_name)

        local success, err = pcall(function()
            readfile(font_path)
        end)

        if tostring(err):find("File not found") or source:len() > 1 then -- if font isn't present in workspace, download it from the source
            writefile(font_path, source)
        end

        local font_json = {
            name = font_name,
            faces = {{
                name = "Regular",
                weight = 400,
                style = "normal",
                assetId = getcustomasset(font_path)
            }}
        }

        local json_path = font_path:split(".")[1]..".json"

        writefile(json_path, game:GetService("HttpService"):JSONEncode(font_json))

        self.fonts[font_name:split(".")[1]] = Font.new(getcustomasset(json_path), Enum.FontWeight.Regular)
    end
end

return ui_utils
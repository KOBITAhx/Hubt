-- Crear el GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local Button = Instance.new("TextButton")

-- Configurar el ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Configurar el Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Configurar el TextBox
TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TextBox.Position = UDim2.new(0.5, -75, 0.2, 0)
TextBox.Size = UDim2.new(0, 150, 0, 40)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderText = "Enter Torso Size"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextScaled = true
TextBox.TextWrapped = true
TextBox.AnchorPoint = Vector2.new(0.5, 0)

-- Configurar el Botón
Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(0, 128, 0)
Button.Position = UDim2.new(0.5, -50, 0.7, 0)
Button.Size = UDim2.new(0, 100, 0, 30)
Button.Font = Enum.Font.SourceSans
Button.Text = "Ejecutar"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextScaled = true
Button.TextWrapped = true
Button.AnchorPoint = Vector2.new(0.5, 0)

-- Funcionalidad del botón
Button.MouseButton1Click:Connect(function()
    local inputSize = tonumber(TextBox.Text)
    if inputSize then
        _G.TorsoSize = inputSize
        
        -- Ejecutar el script de cambio de tamaño
        _G.Enabled = true
        
        game:GetService('RunService').RenderStepped:Connect(function()
            if _G.Enabled then
                for i, v in next, game:GetService('Players'):GetPlayers() do
                    if v.Name ~= game:GetService('Players').LocalPlayer.Name then
                        pcall(function()
                            if v.Character and v.Character:FindFirstChild("Torso") then
                                v.Character.Torso.Size = Vector3.new(_G.TorsoSize, _G.TorsoSize, _G.TorsoSize)
                                v.Character.Torso.Transparency = 1
                                v.Character.Torso.BrickColor = BrickColor.new("Red")
                                v.Character.Torso.Material = "Neon"
                                v.Character.Torso.CanCollide = false
                                v.Character.Torso.Massless = true
                            end
                        end)
                    end
                end
            end
        end)

        -- Ocultar el hub después de ejecutar el script
        ScreenGui:Destroy()
    else
        TextBox.Text = "Número inválido"
    end
end)

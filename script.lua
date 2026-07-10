-- MENU MASTER PERFORMANCE V6 ULTIMATE (PC/MOBILE - DESIGN PREMIUM)
if not game:IsLoaded() then game.Loaded:Wait() end

local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Terrain = Workspace:FindFirstChildOfClass("Terrain")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- 1. SISTEMA DE CORES E ESTILO (DESIGN BONITO)
local Tema = {
    Fundo = Color3.fromRGB(15, 15, 20),
    FundoSec = Color3.fromRGB(22, 22, 28),
    BotaoPadrao = Color3.fromRGB(30, 30, 38),
    BotaoAtivo = Color3.fromRGB(0, 150, 255),
    Texto = Color3.fromRGB(250, 250, 250),
    TextoSec = Color3.fromRGB(180, 180, 190),
    Destaque = Color3.fromRGB(0, 180, 255)
}

-- 2. CRIANDO A INTERFACE VISUAL (UI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MasterPerformance_V6"
ScreenGui.ResetOnSpawn = false

-- Suporte para Delta/Mobile (CoreGui)
local sucesso, erro = pcall(function() ScreenGui.Parent = CoreGui end)
if not sucesso then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- 3. BOTÃO FLUTUANTE PREMIUM (MINIMIZAR/ABRIR)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 20, 0, 100)
ToggleBtn.BackgroundColor3 = Tema.FundoSec
ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Tema.Destaque
ToggleBtn.TextSize = 28
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.ZIndex = 10
ToggleBtn.Parent = ScreenGui

local CornerToggle = Instance.new("UICorner")
CornerToggle.CornerRadius = UDim.new(0, 25)
CornerToggle.Parent = ToggleBtn

local StrokeToggle = Instance.new("UIStroke")
StrokeToggle.Color = Tema.Destaque
StrokeToggle.Thickness = 1.5
StrokeToggle.Parent = ToggleBtn

-- SISTEMA DE ARRASTAR O BOTÃO FLUTUANTE (MOBILE)
local dragging, dragInput, dragStart, startPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
ToggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 4. JANELA PRINCIPAL DO MENU
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainWindow"
MainFrame.Size = UDim2.new(0, 340, 0, 380)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -190)
MainFrame.BackgroundColor3 = Tema.Fundo
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local CornerMain = Instance.new("UICorner")
CornerMain.CornerRadius = UDim.new(0, 15)
CornerMain.Parent = MainFrame

local StrokeMain = Instance.new("UIStroke")
StrokeMain.Color = Color3.fromRGB(40, 40, 50)
StrokeMain.Thickness = 2
StrokeMain.Parent = MainFrame

-- TÍTULO DO MENU (HEADER BAR)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundColor3 = Tema.FundoSec
Header.Parent = MainFrame

local CornerHeader = Instance.new("UICorner")
CornerHeader.CornerRadius = UDim.new(0, 15)
CornerHeader.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MASTER v6 ULTIMATE"
Title.TextColor3 = Tema.Destaque
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- SISTEMA ABRE/FECHA
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- 5. CONTAINER DE FUNÇÕES (SCROLLING)
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -65)
Container.Position = UDim2.new(0, 10, 0, 55)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 420)
Container.ScrollBarThickness = 4
Container.ScrollBarImageColor3 = Tema.Destaque
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 10)
UIList.Parent = Container

-- FUNÇÃO PARA CRIAR BOTÕES (UI MODULE)
local function CriarModulo(texto, funcao)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 50)
    Btn.BackgroundColor3 = Tema.BotaoPadrao
    Btn.Text = "  " .. texto
    Btn.TextColor3 = Tema.TextoSec
    Btn.TextSize = 16
    Btn.Font = Enum.Font.Gotham
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = Container

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 10)
    Corner.Parent = Btn

    local Indicador = Instance.new("Frame")
    Indicador.Size = UDim2.new(0, 4, 1, -16)
    Indicador.Position = UDim2.new(1, -10, 0.5, -16)
    Indicador.AnchorPoint = Vector2.new(1, 0)
    Indicador.BackgroundColor3 = Tema.FundoSec
    Indicador.Parent = Btn

    local CornerInd = Instance.new("UICorner")
    CornerInd.CornerRadius = UDim.new(0, 2)
    CornerInd.Parent = CornerInd

    local ativo = false
    Btn.MouseButton1Click:Connect(function()
        ativo = not ativo
        if ativo then
            Btn.BackgroundColor3 = Tema.FundoSec
            Btn.TextColor3 = Tema.Texto
            Indicador.BackgroundColor3 = Tema.BotaoAtivo
            Btn.Font = Enum.Font.GothamMedium
        else
            Btn.BackgroundColor3 = Tema.BotaoPadrao
            Btn.TextColor3 = Tema.TextoSec
            Indicador.BackgroundColor3 = Tema.FundoSec
            Btn.Font = Enum.Font.Gotham
        end
        pcall(funcao, ativo)
    end)
end

--- ==========================================
--- ADICIONANDO AS MELHORES FUNÇÕES CORRIGIDAS
--- ==========================================

-- Modulo 1: Limpeza Máxima de Lag (Texturas)
CriarModulo("Otimizar Gráficos (Remover Lag)", function(estado)
    if estado then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        if Lighting then Lighting.GlobalShadows = false end
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Texture") or obj:IsA("Decal") then obj:Destroy()
            elseif obj:IsA("Part") or obj:IsA("MeshPart") then 
                obj.Material = Enum.Material.SmoothPlastic 
                obj.CastShadow = false
            end
        end
    end
end)

-- Modulo 2: Filtro Anti-Lag para PvP (Skills)
CriarModulo("Esconder Efeitos de Golpes (PvP)", function(estado)
    _G.EsconderSkills = estado
    task.spawn(function()
        while _G.EsconderSkills do
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Beam") then
                    obj.Enabled = false
                elseif obj:IsA("Explosion") then
                    obj.Visible = false
                end
            end
            task.wait(1.5)
        end
    end)
end)

-- Modulo 3: Rastreador de Frutas do Mapa (Visual ESP)
local marcadoresFrutas = {}
CriarModulo("Mostrar Frutas no Mapa", function(estado)
    _G.FruitESP = estado
    if not estado then
        for _, v in pairs(marcadoresFrutas) do if v then v:Destroy() end end
        table.clear(marcadoresFrutas)
    else
        task.spawn(function()
            while _G.FruitESP do
                -- Remove marcadores antigos para não duplicar
                for _, v in pairs(marcadoresFrutas) do if v then v:Destroy() end end
                table.clear(marcadoresFrutas)
                
                -- Procura por frutas soltas no mapa
                for _, obj in ipairs(Workspace:GetChildren()) do
                    if obj:IsA("Tool") and (obj.Name:find("Fruit") or obj:FindFirstChild("Handle")) then
                        local Box = Instance.new("Highlight")
                        Box.Color3 = Color3.fromRGB(0, 255, 100)
                        Box.FillTransparency = 0.5
                        Box.Adornee = obj
                        Box.Parent = ScreenGui
                        table.insert(marcadoresFrutas, Box)
                    end
                end
                task.wait(3) -- Atualiza a cada 3 segundos de forma leve
            end
        end)
    end
end)

-- Modulo 4: Rastreador e Notificador de Chefes (Boss ESP)
local marcadoresBoss = {}
CriarModulo("Localizar Bosses Ativos", function(estado)
    _G.BossESP = estado
    if not estado then
        for _, v in pairs(marcadoresBoss) do if v then v:Destroy() end end
        table.clear(marcadoresBoss)
    else
        task.spawn(function()
            while _G.BossESP do
                for _, v in pairs(marcadoresBoss) do if v then v:Destroy() end end
                table.clear(marcadoresBoss)

                for _, npc in ipairs(Workspace.Enemies:GetChildren()) do
                    local hum = npc:FindFirstChildOfClass("Humanoid")
                    if hum and hum.MaxHealth >= 50000 then -- Filtra apenas inimigos fortes (Bosses)
                        local Box = Instance.new("Highlight")
                        Box.Color3 = Color3.fromRGB(255, 0, 50)
                        Box.FillTransparency = 0.4
                        Box.Adornee = npc
                        Box.Parent = ScreenGui
                        table.insert(marcadoresBoss, Box)
                    end
                end
                task.wait(4)
            end
        end)
    end
end)

print("🎯 MENU MASTER V6 CARREGADO: Interface visual ativa e corrigida!")

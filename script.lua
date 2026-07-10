-- ====================================================================
-- 👁️ SCRIPT INDEPENDENTE: DETECTOR E ESP DE FRUTAS & BOSSES
-- ====================================================================
if not game:IsLoaded() then game.Loaded:Wait() end

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- Função para criar a caixinha brilhante (ESP)
local function AplicarESP(alvo, corExibida)
    if not alvo:FindFirstChild("TrackerESP") then
        local esp = Instance.new("Highlight")
        esp.Name = "TrackerESP"
        esp.FillColor = corExibida
        esp.OutlineColor = Color3.fromRGB(255, 255, 255)
        esp.FillTransparency = 0.4
        esp.OutlineTransparency = 0
        esp.Parent = alvo
    end
end

-- Analisa o objeto para ver se é uma fruta ou chefe
local function VerificarEntidade(obj)
    local nome = obj.Name:lower()
    
    -- Identifica Frutas (no chão ou na mão)
    if obj:IsA("Tool") and (nome:find("fruit") or nome:find("fruta")) or obj:FindFirstChild("Fruit") then
        AplicarESP(obj, Color3.fromRGB(0, 255, 0)) -- Frutas brilham em VERDE
        
    -- Identifica Bosses
    elseif obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
        if nome:find("boss") or nome:find("rei") or nome:find("god") or obj:FindFirstChild("Boss") then
            AplicarESP(obj, Color3.fromRGB(255, 0, 255)) -- Bosses brilham em MAGENTA/ROXO
        end
    end
end

-- Varredura inicial no mapa
local itens atuais = Workspace:GetDescendants()
for i = 1, #itens_atuais do pcall(VerificarEntidade, itens_atuais[i]) end

-- Monitora novos itens que nascem (Spawn) no mapa em tempo real
Workspace.DescendantAdded:Connect(function(obj)
    pcall(VerificarEntidade, obj)
end)

print("💀 [Dragon Stalo] RASTREADOR DE FRUTAS E BOSSES PRONTO!")

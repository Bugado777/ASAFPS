local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ==========================================
-- 1. TABELA DE CONFIGURAÇÃO (CONFIG)
-- ==========================================
local CONFIG = {
	SmoothPlasticParts = true,    -- Troca materiais de BaseParts para SmoothPlastic
	DisablePartShadows = true,    -- Define CastShadow = false em BaseParts
	DisableGlobalShadows = true,  -- Desativa sombras globais no Lighting
	DisableEffects = true,        -- Desativa ParticleEmitter, Trail, Beam e PostEffects
	SimplifyTerrain = true,       -- Desativa decoração e reduz ondas/reflexo da água no Terrain
	ApplyToNewDescendants = true, -- Otimiza automaticamente novos objetos no Workspace
	PreserveForceField = true,    -- Preserva ForceField se necessário
}

local IMAGEM_BOTAO_ID = "rbxassetid://10690036902"
local DURACAO_BEM_VINDO = 3

-- ==========================================
-- 2. INTERFACE ESTILO HUB / JANELA (SEM RAYFIELD)
-- ==========================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HubFpsGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Tela de Bem-Vindo (exibida por 3 segundos ao iniciar)
local telaBemVindo = Instance.new("Frame")
telaBemVindo.Name = "TelaBemVindo"
telaBemVindo.Size = UDim2.new(0, 260, 0, 110)
telaBemVindo.Position = UDim2.new(0.5, -130, 0.5, -55)
telaBemVindo.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
telaBemVindo.BorderSizePixel = 0
telaBemVindo.ZIndex = 20
telaBemVindo.Visible = true
telaBemVindo.Parent = screenGui

local cornerBemVindo = Instance.new("UICorner")
cornerBemVindo.CornerRadius = UDim.new(0, 12)
cornerBemVindo.Parent = telaBemVindo

local strokeBemVindo = Instance.new("UIStroke")
strokeBemVindo.Color = Color3.fromRGB(65, 65, 80)
strokeBemVindo.Thickness = 1.5
strokeBemVindo.Parent = telaBemVindo

local labelBemVindo = Instance.new("TextLabel")
labelBemVindo.Name = "LabelBemVindo"
labelBemVindo.Size = UDim2.new(1, -20, 0, 36)
labelBemVindo.Position = UDim2.new(0, 10, 0, 18)
labelBemVindo.BackgroundTransparency = 1
labelBemVindo.Text = "Bem-Vindo"
labelBemVindo.TextColor3 = Color3.fromRGB(255, 255, 255)
labelBemVindo.Font = Enum.Font.GothamBold
labelBemVindo.TextSize = 22
labelBemVindo.ZIndex = 21
labelBemVindo.Parent = telaBemVindo

local labelAoAsaFps = Instance.new("TextLabel")
labelAoAsaFps.Name = "LabelAoAsaFps"
labelAoAsaFps.Size = UDim2.new(1, -20, 0, 28)
labelAoAsaFps.Position = UDim2.new(0, 10, 0, 56)
labelAoAsaFps.BackgroundTransparency = 1
labelAoAsaFps.Text = "ao ASAFPS"
labelAoAsaFps.TextColor3 = Color3.fromRGB(160, 185, 235)
labelAoAsaFps.Font = Enum.Font.GothamBold
labelAoAsaFps.TextSize = 16
labelAoAsaFps.ZIndex = 21
labelAoAsaFps.Parent = telaBemVindo

-- Botão de imagem flutuante (arrastável) com título "ASAFPS" acima
local botaoReabrir = Instance.new("ImageButton")
botaoReabrir.Name = "BotaoReabrir"
botaoReabrir.Size = UDim2.new(0, 56, 0, 56)
botaoReabrir.Position = UDim2.new(0, 16, 0, 34)
botaoReabrir.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
botaoReabrir.Image = IMAGEM_BOTAO_ID
botaoReabrir.ImageTransparency = 0
botaoReabrir.ImageColor3 = Color3.fromRGB(255, 255, 255)
botaoReabrir.ScaleType = Enum.ScaleType.Crop
botaoReabrir.Visible = false
botaoReabrir.Parent = screenGui

local cornerReabrir = Instance.new("UICorner")
cornerReabrir.CornerRadius = UDim.new(0, 10)
cornerReabrir.Parent = botaoReabrir

local strokeReabrir = Instance.new("UIStroke")
strokeReabrir.Color = Color3.fromRGB(55, 55, 65)
strokeReabrir.Thickness = 1
strokeReabrir.Parent = botaoReabrir

local labelAsaFps = Instance.new("TextLabel")
labelAsaFps.Name = "LabelAsaFps"
labelAsaFps.Size = UDim2.new(1, 20, 0, 18)
labelAsaFps.Position = UDim2.new(0.5, 0, 0, -20)
labelAsaFps.AnchorPoint = Vector2.new(0.5, 0)
labelAsaFps.BackgroundTransparency = 1
labelAsaFps.Text = "ASAFPS"
labelAsaFps.TextColor3 = Color3.fromRGB(245, 245, 250)
labelAsaFps.TextStrokeTransparency = 0.25
labelAsaFps.Font = Enum.Font.GothamBold
labelAsaFps.TextSize = 12
labelAsaFps.Parent = botaoReabrir

-- Janela principal estilo Hub (arrastável pela barra superior)
local janela = Instance.new("Frame")
janela.Name = "JanelaHub"
janela.Size = UDim2.new(0, 300, 0, 330)
janela.Position = UDim2.new(0.5, -150, 0.5, -165)
janela.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
janela.BorderSizePixel = 0
janela.Visible = false
janela.Parent = screenGui

local cornerJanela = Instance.new("UICorner")
cornerJanela.CornerRadius = UDim.new(0, 10)
cornerJanela.Parent = janela

local strokeJanela = Instance.new("UIStroke")
strokeJanela.Color = Color3.fromRGB(50, 50, 60)
strokeJanela.Thickness = 1
strokeJanela.Parent = janela

local barraTopo = Instance.new("Frame")
barraTopo.Name = "BarraTopo"
barraTopo.Size = UDim2.new(1, 0, 0, 36)
barraTopo.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
barraTopo.BorderSizePixel = 0
barraTopo.Parent = janela

local cornerTopo = Instance.new("UICorner")
cornerTopo.CornerRadius = UDim.new(0, 10)
cornerTopo.Parent = barraTopo

local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, -80, 1, 0)
titulo.Position = UDim2.new(0, 12, 0, 0)
titulo.BackgroundTransparency = 1
titulo.Text = "ASAFPS  |  Performance"
titulo.TextXAlignment = Enum.TextXAlignment.Left
titulo.TextColor3 = Color3.fromRGB(235, 235, 242)
titulo.Font = Enum.Font.GothamBold
titulo.TextSize = 13
titulo.Parent = barraTopo

local botaoMinimizar = Instance.new("TextButton")
botaoMinimizar.Name = "BotaoMinimizar"
botaoMinimizar.Size = UDim2.new(0, 26, 0, 24)
botaoMinimizar.Position = UDim2.new(1, -34, 0.5, -12)
botaoMinimizar.BackgroundColor3 = Color3.fromRGB(42, 42, 50)
botaoMinimizar.TextColor3 = Color3.fromRGB(230, 230, 235)
botaoMinimizar.Font = Enum.Font.GothamBold
botaoMinimizar.TextSize = 14
botaoMinimizar.Text = "-"
botaoMinimizar.Parent = barraTopo

local cornerMin = Instance.new("UICorner")
cornerMin.CornerRadius = UDim.new(0, 6)
cornerMin.Parent = botaoMinimizar

local listaBotoes = Instance.new("ScrollingFrame")
listaBotoes.Name = "ListaBotoes"
listaBotoes.Size = UDim2.new(1, -20, 1, -48)
listaBotoes.Position = UDim2.new(0, 10, 0, 42)
listaBotoes.BackgroundColor3 = Color3.fromRGB(26, 26, 31)
listaBotoes.BorderSizePixel = 0
listaBotoes.ScrollBarThickness = 4
listaBotoes.CanvasSize = UDim2.new(0, 0, 0, 0)
listaBotoes.AutomaticCanvasSize = Enum.AutomaticSize.Y
listaBotoes.Parent = janela

local cornerLista = Instance.new("UICorner")
cornerLista.CornerRadius = UDim.new(0, 8)
cornerLista.Parent = listaBotoes

local strokeLista = Instance.new("UIStroke")
strokeLista.Color = Color3.fromRGB(42, 42, 50)
strokeLista.Thickness = 1
strokeLista.Parent = listaBotoes

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = listaBotoes

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 8)
padding.PaddingBottom = UDim.new(0, 8)
padding.PaddingLeft = UDim.new(0, 8)
padding.PaddingRight = UDim.new(0, 8)
padding.Parent = listaBotoes

-- ==========================================
-- 3. SISTEMA DE ARRASTAR (MOUSE E TOUCH)
-- ==========================================
local function tornarArrastavel(objetoAlvo: GuiObject, alcaArraste: GuiObject)
	local arrastando = false
	local moveuDuranteArraste = false
	local inicioInput: Vector3
	local posicaoInicial: UDim2
	local inputAtivo: InputObject? = nil

	alcaArraste.InputBegan:Connect(function(input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			arrastando = true
			moveuDuranteArraste = false
			inicioInput = input.Position
			posicaoInicial = objetoAlvo.Position
			inputAtivo = input

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					arrastando = false
					inputAtivo = nil
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input: InputObject)
		if not arrastando then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement or input == inputAtivo then
			local delta = input.Position - inicioInput
			if delta.Magnitude > 5 then
				moveuDuranteArraste = true
			end
			objetoAlvo.Position = UDim2.new(
				posicaoInicial.X.Scale,
				posicaoInicial.X.Offset + delta.X,
				posicaoInicial.Y.Scale,
				posicaoInicial.Y.Offset + delta.Y
			)
		end
	end)

	return function(): boolean
		return moveuDuranteArraste
	end
end

local botaoFoiArrastado = tornarArrastavel(botaoReabrir, botaoReabrir)
tornarArrastavel(janela, barraTopo)

-- ==========================================
-- 4. ESTADOS E CACHE DE CADA FUNÇÃO
-- ==========================================
local estados = {
	SmoothPlastic = false,
	PartShadows = false,
	GlobalShadows = false,
	Effects = false,
	Terrain = false,
	NewDescendants = false,
	FpsAll = false,
}

local botoesUI: { [string]: TextButton } = {}

local originalMaterials: { [BasePart]: Enum.Material } = {}
local originalPartShadows: { [BasePart]: boolean } = {}
local originalEffects: { [Instance]: boolean } = {}
local originalPostFx: { [PostEffect]: boolean } = {}
local originalLighting: { GlobalShadows: boolean? } = { GlobalShadows = nil }
local originalTerrain: {
	Decoration: boolean?,
	WaterWaveSize: number?,
	WaterWaveSpeed: number?,
	WaterReflectance: number?,
} = {}

local descendantConnection: RBXScriptConnection? = nil

local function eParteDoJogador(instancia: Instance): boolean
	local character = player.Character
	return character ~= nil and instancia:IsDescendantOf(character)
end

local function atualizarVisualBotao(chave: string, rotuloBase: string, ativo: boolean, permitido: boolean)
	local btn = botoesUI[chave]
	if not btn then return end

	if not permitido then
		btn.Text = rotuloBase .. " (Off Config)"
		btn.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
		btn.TextColor3 = Color3.fromRGB(130, 130, 140)
		return
	end

	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	if ativo then
		btn.Text = rotuloBase .. ": ON"
		btn.BackgroundColor3 = Color3.fromRGB(45, 155, 85)
	else
		btn.Text = rotuloBase
		btn.BackgroundColor3 = chave == "FpsAll" and Color3.fromRGB(52, 120, 210) or Color3.fromRGB(38, 38, 46)
	end
end

-- ==========================================
-- 5. FUNÇÕES SEPARADAS DE OTIMIZAÇÃO
-- ==========================================

-- 5.1 SmoothPlastic em BaseParts (preservando ForceField se configurado)
local function aplicarSmoothPlastic(part: BasePart)
	if eParteDoJogador(part) then return end
	if CONFIG.PreserveForceField and part.Material == Enum.Material.ForceField then return end

	if originalMaterials[part] == nil then
		originalMaterials[part] = part.Material
	end
	if part.Material ~= Enum.Material.SmoothPlastic then
		part.Material = Enum.Material.SmoothPlastic
	end
end

local function restaurarSmoothPlastic()
	local count = 0
	for part, mat in pairs(originalMaterials) do
		if part and part.Parent then
			part.Material = mat
		end
		count += 1
		if count % 300 == 0 then task.wait() end
	end
end

local function setSmoothPlastic(ativo: boolean)
	if not CONFIG.SmoothPlasticParts then
		estados.SmoothPlastic = false
		atualizarVisualBotao("SmoothPlastic", "SmoothPlastic", false, false)
		return
	end

	estados.SmoothPlastic = ativo
	atualizarVisualBotao("SmoothPlastic", "SmoothPlastic", ativo, true)

	if ativo then
		task.spawn(function()
			local descendants = Workspace:GetDescendants()
			for i = 1, #descendants do
				if not estados.SmoothPlastic then return end
				local obj = descendants[i]
				if obj:IsA("BasePart") then
					aplicarSmoothPlastic(obj)
				end
				if i % 250 == 0 then task.wait() end
			end
		end)
	else
		task.spawn(restaurarSmoothPlastic)
	end
end

-- 5.2 Sombras de BaseParts (CastShadow)
local function aplicarPartShadow(part: BasePart)
	if eParteDoJogador(part) then return end
	if originalPartShadows[part] == nil then
		originalPartShadows[part] = part.CastShadow
	end
	if part.CastShadow then
		part.CastShadow = false
	end
end

local function restaurarPartShadows()
	local count = 0
	for part, shadow in pairs(originalPartShadows) do
		if part and part.Parent then
			part.CastShadow = shadow
		end
		count += 1
		if count % 300 == 0 then task.wait() end
	end
end

local function setPartShadows(ativo: boolean)
	if not CONFIG.DisablePartShadows then
		estados.PartShadows = false
		atualizarVisualBotao("PartShadows", "Sem Sombras Parts", false, false)
		return
	end

	estados.PartShadows = ativo
	atualizarVisualBotao("PartShadows", "Sem Sombras Parts", ativo, true)

	if ativo then
		task.spawn(function()
			local descendants = Workspace:GetDescendants()
			for i = 1, #descendants do
				if not estados.PartShadows then return end
				local obj = descendants[i]
				if obj:IsA("BasePart") then
					aplicarPartShadow(obj)
				end
				if i % 250 == 0 then task.wait() end
			end
		end)
	else
		task.spawn(restaurarPartShadows)
	end
end

-- 5.3 Sombras globais no Lighting
local function setGlobalShadows(ativo: boolean)
	if not CONFIG.DisableGlobalShadows then
		estados.GlobalShadows = false
		atualizarVisualBotao("GlobalShadows", "Sem Sombras Global", false, false)
		return
	end

	estados.GlobalShadows = ativo
	atualizarVisualBotao("GlobalShadows", "Sem Sombras Global", ativo, true)

	if ativo then
		if originalLighting.GlobalShadows == nil then
			originalLighting.GlobalShadows = Lighting.GlobalShadows
		end
		Lighting.GlobalShadows = false
	elseif originalLighting.GlobalShadows ~= nil then
		Lighting.GlobalShadows = originalLighting.GlobalShadows
	end
end

-- 5.4 Efeitos visuais (ParticleEmitter, Trail, Beam e PostEffect)
local function aplicarEfeitoInstancia(inst: Instance)
	if eParteDoJogador(inst) then return end

	if inst:IsA("ParticleEmitter") or inst:IsA("Trail") or inst:IsA("Beam") then
		if originalEffects[inst] == nil then
			originalEffects[inst] = inst.Enabled
		end
		inst.Enabled = false
	elseif inst:IsA("PostEffect") then
		if originalPostFx[inst] == nil then
			originalPostFx[inst] = inst.Enabled
		end
		inst.Enabled = false
	end
end

local function restaurarEfeitos()
	for inst, enabled in pairs(originalEffects) do
		if inst and inst.Parent then
			(inst :: ParticleEmitter).Enabled = enabled
		end
	end
	for postFx, enabled in pairs(originalPostFx) do
		if postFx and postFx.Parent then
			postFx.Enabled = enabled
		end
	end
end

local function setEffects(ativo: boolean)
	if not CONFIG.DisableEffects then
		estados.Effects = false
		atualizarVisualBotao("Effects", "Sem Efeitos", false, false)
		return
	end

	estados.Effects = ativo
	atualizarVisualBotao("Effects", "Sem Efeitos", ativo, true)

	if ativo then
		task.spawn(function()
			for _, child in ipairs(Lighting:GetChildren()) do
				if not estados.Effects then return end
				if child:IsA("PostEffect") then
					aplicarEfeitoInstancia(child)
				end
			end

			local descendants = Workspace:GetDescendants()
			for i = 1, #descendants do
				if not estados.Effects then return end
				local obj = descendants[i]
				if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("PostEffect") then
					aplicarEfeitoInstancia(obj)
				end
				if i % 250 == 0 then task.wait() end
			end
		end)
	else
		task.spawn(restaurarEfeitos)
	end
end

-- 5.5 Simplificação do Terrain (Decoration + água)
local function setTerrain(ativo: boolean)
	if not CONFIG.SimplifyTerrain then
		estados.Terrain = false
		atualizarVisualBotao("Terrain", "Terrain Simples", false, false)
		return
	end

	local terrain = Workspace:FindFirstChildOfClass("Terrain")
	if not terrain then return end

	estados.Terrain = ativo
	atualizarVisualBotao("Terrain", "Terrain Simples", ativo, true)

	if ativo then
		if originalTerrain.Decoration == nil then
			originalTerrain.Decoration = terrain.Decoration
			originalTerrain.WaterWaveSize = terrain.WaterWaveSize
			originalTerrain.WaterWaveSpeed = terrain.WaterWaveSpeed
			originalTerrain.WaterReflectance = terrain.WaterReflectance
		end
		terrain.Decoration = false
		terrain.WaterWaveSize = 0
		terrain.WaterWaveSpeed = 0
		terrain.WaterReflectance = 0
	elseif originalTerrain.Decoration ~= nil then
		terrain.Decoration = originalTerrain.Decoration
		terrain.WaterWaveSize = originalTerrain.WaterWaveSize :: number
		terrain.WaterWaveSpeed = originalTerrain.WaterWaveSpeed :: number
		terrain.WaterReflectance = originalTerrain.WaterReflectance :: number
	end
end

-- 5.6 Escuta em Workspace.DescendantAdded para novos objetos
local function desconectarNewDescendants()
	if descendantConnection then
		descendantConnection:Disconnect()
		descendantConnection = nil
	end
end

local function setNewDescendants(ativo: boolean)
	if not CONFIG.ApplyToNewDescendants then
		estados.NewDescendants = false
		desconectarNewDescendants()
		atualizarVisualBotao("NewDescendants", "Auto Novos Objetos", false, false)
		return
	end

	estados.NewDescendants = ativo
	atualizarVisualBotao("NewDescendants", "Auto Novos Objetos", ativo, true)
	desconectarNewDescendants()

	if ativo then
		descendantConnection = Workspace.DescendantAdded:Connect(function(descendant: Instance)
			if not estados.NewDescendants then return end
			if descendant:IsA("BasePart") then
				if estados.SmoothPlastic then aplicarSmoothPlastic(descendant) end
				if estados.PartShadows then aplicarPartShadow(descendant) end
			elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") or descendant:IsA("PostEffect") then
				if estados.Effects then aplicarEfeitoInstancia(descendant) end
			end
		end)
	end
end

-- 5.7 Botão "Fps all" (ativa ou desativa todas as funções configuradas)
local function setFpsAll(ativo: boolean)
	estados.FpsAll = ativo
	atualizarVisualBotao("FpsAll", "Fps all", ativo, true)

	setGlobalShadows(ativo)
	setTerrain(ativo)
	setSmoothPlastic(ativo)
	setPartShadows(ativo)
	setEffects(ativo)
	setNewDescendants(ativo)
end

-- ==========================================
-- 6. CRIAÇÃO DOS BOTÕES NA JANELA
-- ==========================================
local function criarBotao(ordem: number, chave: string, rotuloBase: string, permitido: boolean, callback: () -> ())
	local btn = Instance.new("TextButton")
	btn.Name = "Botao_" .. chave
	btn.LayoutOrder = ordem
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(38, 38, 46)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13
	btn.Text = rotuloBase
	btn.AutoButtonColor = permitido
	btn.Parent = listaBotoes

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 7)
	corner.Parent = btn

	botoesUI[chave] = btn
	atualizarVisualBotao(chave, rotuloBase, false, permitido)

	if permitido then
		btn.MouseButton1Click:Connect(callback)
	end
end

criarBotao(1, "FpsAll", "Fps all", true, function()
	setFpsAll(not estados.FpsAll)
end)

criarBotao(2, "SmoothPlastic", "SmoothPlastic", CONFIG.SmoothPlasticParts, function()
	setSmoothPlastic(not estados.SmoothPlastic)
end)

criarBotao(3, "PartShadows", "Sem Sombras Parts", CONFIG.DisablePartShadows, function()
	setPartShadows(not estados.PartShadows)
end)

criarBotao(4, "GlobalShadows", "Sem Sombras Global", CONFIG.DisableGlobalShadows, function()
	setGlobalShadows(not estados.GlobalShadows)
end)

criarBotao(5, "Effects", "Sem Efeitos", CONFIG.DisableEffects, function()
	setEffects(not estados.Effects)
end)

criarBotao(6, "Terrain", "Terrain Simples", CONFIG.SimplifyTerrain, function()
	setTerrain(not estados.Terrain)
end)

criarBotao(7, "NewDescendants", "Auto Novos Objetos", CONFIG.ApplyToNewDescendants, function()
	setNewDescendants(not estados.NewDescendants)
end)

-- ==========================================
-- 7. ABRIR / MINIMIZAR JANELA E TELA DE BOAS-VINDAS
-- ==========================================
botaoMinimizar.MouseButton1Click:Connect(function()
	janela.Visible = false
	botaoReabrir.Visible = true
end)

botaoReabrir.MouseButton1Click:Connect(function()
	if botaoFoiArrastado() then return end
	janela.Visible = true
	botaoReabrir.Visible = false
end)

task.delay(DURACAO_BEM_VINDO, function()
	if telaBemVindo and telaBemVindo.Parent then
		telaBemVindo.Visible = false
	end
	if botaoReabrir and botaoReabrir.Parent and not janela.Visible then
		botaoReabrir.Visible = true
	end
end)

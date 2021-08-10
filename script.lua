-- Conceptos
local arma = script.Parent
local GUIRecarga = arma:WaitForChild("Recarga")
local GUIRecargando = arma:WaitForChild("Recargando")
local RemoteEvent = arma:WaitForChild("Activacion")
local Player = arma.Parent.Parent
local esta = true

-- Propiedades arma
local FireRate = 2
local CooldownRecarga = 3
local MaxMunicion = "30"
local damage = 10
local Municion = GUIRecarga:WaitForChild("Municion")
local CooldownDisparo = true

-- Auxiliares
local aux = false
local equipado = false
local EstaCargando = false

-- GUI'S
GUIRecarga.Parent = Player.PlayerGui
GUIRecargando.Parent = Player.PlayerGui

-- Funciones
function Recarga()

	RemoteEvent.OnServerEvent:Connect(function(jugador)
		
		if equipado == true and EstaCargando == false and Municion.Text < MaxMunicion then -- Cuando presiono y equipo el arma, toma en cuenta los seg del local player
			
			print"Esta cargando"
			EstaCargando = true
			GUIRecarga.Enabled = false
			GUIRecargando.Enabled = true
			wait(CooldownRecarga)

			if equipado == true then
				
				GUIRecarga.Enabled = true
				
			else
				
				GUIRecarga.Enabled = false
				
			end

			EstaCargando = false
			GUIRecargando.Enabled = false
			Municion.Text = MaxMunicion
			
		end

	end)

end

function Equipado()
	
	equipado = true
	
	if EstaCargando == true  then
		
		GUIRecarga.Enabled = false
		GUIRecargando.Enabled = true
		
	else
		
		GUIRecarga.Enabled = true
		GUIRecargando.Enabled = false
		
	end
	
	Recarga()

end

function NoEquipado()
	
	equipado = false
	
	if equipado == false then
		
		GUIRecarga.Enabled = false
		GUIRecargando.Enabled = false
		
	end
	
end

function Dano(bala)
	
	bala.Touched:Connect(function(ParteTocada)
		
		local humanoid = ParteTocada.Parent:FindFirstChild("Humanoid")
		if humanoid and humanoid ~= Player.Character.Humanoid and esta == true then
			
			esta = false
			humanoid:TakeDamage(damage)
			game.Debris:AddItem(bala,0.1)
			wait(1)
			esta = true
		
		end
		
	end)
	
end

function NoBalas()
	
	if EstaCargando == false then
		
		EstaCargando = true
		GUIRecarga.Enabled = false
		GUIRecargando.Enabled = true
		wait(CooldownRecarga)
		Municion.Text = MaxMunicion
		
		if equipado == true then
			
			GUIRecarga.Enabled = true
			
		else
			
			GUIRecarga.Enabled = false
			
		end
		
		EstaCargando = false
		GUIRecargando.Enabled = false

	end

end

function Disparo()
	
	if Municion.Text >= "1" and EstaCargando == false then
		
		if CooldownDisparo == true then
			
			CooldownDisparo = false
			local Character = Player.Character
			local ManoDerecha = Character.RightHand
			local bala = Instance.new("Part",workspace)
			bala.Name = "Bala"
			bala.Shape = Enum.PartType.Ball
			bala.Anchored = false
			bala.Color = Color3.new(1, 0, 0) 
			bala.Size = Vector3.new(1.3,1.3,1.3)
			bala.CanCollide = false
			bala.Position = ManoDerecha.Position + Vector3.new(0,1,-1)
			
			Municion.Text -= 1
			game.Debris:AddItem(bala,2)
			Dano(bala)
			
			local BodyVelocity = Instance.new("BodyVelocity",bala)
			BodyVelocity.Name = "Motor"
			BodyVelocity.MaxForce = Vector3.new("inf","inf","inf")
			BodyVelocity.Velocity = Player.Character.HumanoidRootPart.CFrame.LookVector * 100

			if Municion.Text == "0" then

				NoBalas()

			end
			
			wait(0.4)
			CooldownDisparo = true
			
		end
		
	end
	
end
arma.Activated:Connect(Disparo)
arma.Unequipped:Connect(NoEquipado)
arma.Equipped:Connect(Equipado)

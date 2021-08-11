local letra = game:GetService("UserInputService")
local evento = script.Parent:WaitForChild("Activacion")
local aux = true
local arma = script.Parent
local activado = true
local MouseEvent = arma:WaitForChild("Raton")

arma.Equipped:Connect(function(mouse)
	
	activado = true
	
	while activado do
		wait()
		MouseEvent:FireServer(mouse.Hit.LookVector)
	end
	
end)

letra.InputBegan:Connect(function(tecla)

	arma.Unequipped:Connect(function()
		
		activado = false
		
		if tecla.KeyCode == Enum.KeyCode.R and aux == true then

			aux = false
			evento:FireServer()
			wait(0)
			aux = true

		end
		
	end)
	
	if tecla.KeyCode == Enum.KeyCode.R and aux == true then

		aux = false
		evento:FireServer()
		wait(0)
		aux = true

	end

end)

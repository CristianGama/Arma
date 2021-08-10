local letra = game:GetService("UserInputService")
local evento = script.Parent:WaitForChild("Activacion")
local aux = true
local arma = script.Parent

letra.InputBegan:Connect(function(tecla)

	arma.Unequipped:Connect(function()
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

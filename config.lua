mid = {}

-- Nome do comando 
mid.registercommand = "nitro"

-- Se vai ser por comando ou por evento
mid.comando = true

-- Evento da sua progress-bar
mid.progress = "Progress"

-- Tipo do DrawMaker
mid.TypeDraw = 0 

-- Cor do DrawMaker
mid.ColorR = 255
mid.ColorG = 255
mid.ColorB = 255

return mid


--[[ Para colocar evento para colocar no item
	TriggerClientEvent("mid:ActiveNitro")
]]
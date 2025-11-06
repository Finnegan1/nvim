
return function( model )
	return function()
		return require("codecompanion.adapters").extend("openai_compatible", {
			env = {
				url = "https://openrouter.ai/api",
				api_key = "OPENROUTER_API_KEY_CODECOMPANION",
				chat_url = "/v1/chat/completions",
			},
			schema = {
				model = {
				default = model,
				},
			},
		})
	end
end

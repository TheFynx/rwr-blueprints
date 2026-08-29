{
	"services": [
		{
			"name": "ollama",
			"provider": "brew",
			// brew services start launches Ollama now and registers the
			// per-user LaunchAgent for future logins.
			"action": "enable"
		}
	]
}

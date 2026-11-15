{
	"services": [
		{
			"name": "ollama",
			"provider": "brew",
			// Gated to the "ai" profile like the package: without --profile ai
			// the brew ollama package is not installed, and enabling its
			// service would fail on a machine that never got it.
			"profiles": ["ai"],
			// brew services start launches Ollama now and registers the
			// per-user LaunchAgent for future logins.
			"action": "enable"
		}
	]
}

// The macOS fleet ranges from 32 GB to 64 GB of unified memory. Use the 27B
// MLX build throughout; the 125B model is intentionally not provisioned.
{
	"scripts": [
		{
			"name": "pull_ollama_model",
			"action": "run",
			"content": "#!/bin/bash\nset -euo pipefail\n\nmodel=\"qwen3.8:27b-mlx\"\n\nfor _ in {1..30}; do\n  if curl --fail --silent http://127.0.0.1:11434/ >/dev/null; then\n    break\n  fi\n  sleep 1\ndone\n\nif ! curl --fail --silent http://127.0.0.1:11434/ >/dev/null; then\n  echo \"Ollama service did not become ready at 127.0.0.1:11434\" >&2\n  exit 1\nfi\n\nif ollama show \"$model\" >/dev/null 2>&1; then\n  echo \"$model is already present\"\nelse\n  ollama pull \"$model\"\nfi\n"
		}
	]
}

// COSMIC desktop tuning, kept for a future COSMIC return. Gated behind the
// cosmic profile: this machine runs Cinnamon now, and the main files.cue copy
// deliberately no longer reaches the cosmic sources (they moved from
// src/.config/cosmic to src/cosmic). Deploy with:
//   rwr all --profile ... ,cosmic
{
	"directories": [
		{
			"action": "copy",
			"name": "cosmic",
			"profiles": ["cosmic"],
			"source": "./src/",
			"target": "{{ .User.home }}/.config/"
		}
	]
}

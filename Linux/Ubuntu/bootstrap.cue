// Minimal bootstrap: everything the rest of the tree needs to run. Full base
// comes from Common/packages/debian via the packages processor.
{
	"packages": [
		{
			"action": "install",
			"names": ["git", "curl", "ca-certificates", "gnupg", "build-essential"],
			"package_manager": "apt"
		}
	]
}

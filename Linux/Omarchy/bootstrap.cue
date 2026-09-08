// Install fresh-machine dependencies before credentials and theme setup.
{
 packages: [{
  names: ["openssh", "gnupg", "jq", "foot", "python", "socat", "ttfx"]
  action: "install"
  package_manager: "pacman"
 }]
}

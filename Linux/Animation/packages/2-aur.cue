packages: [
 {import: "../../../Common/packages/arch/base-aur.cue"},
 {
  // See README: Unreal needs authorized EpicGames/UnrealEngine GitHub access
  // before this pass.
  action: "install"
  package_manager: "yay"
  names: ["unreal-engine"]
 }
 {
  // Local character, backstory, world and story planning.
  // DaVinci Resolve and bibisco CE are deliberately NOT installed here:
  // their AUR recipes expect a vendor ZIP staged by hand, which halts an
  // unattended run. Follow the README's "Manual installs" section instead.
  action: "install"
  package_manager: "yay"
  names: ["manuskript"]
 }
]

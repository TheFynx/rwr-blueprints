packages: [
 {import: "../../../Common/packages/arch/base-aur.cue"},
 {
  // See README: Resolve requires a staged vendor ZIP; Unreal needs
  // authorized EpicGames/UnrealEngine GitHub access before this pass.
  action: "install"
  package_manager: "yay"
  names: ["davinci-resolve", "unreal-engine"]
 }
]

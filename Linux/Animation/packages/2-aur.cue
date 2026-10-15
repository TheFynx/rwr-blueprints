packages: [
 {import: "../../../Common/packages/arch/base-aur.cue"},
 {
  // See README: Resolve requires a staged vendor ZIP; Unreal needs
  // authorized EpicGames/UnrealEngine GitHub access before this pass.
  action: "install"
  package_manager: "yay"
  names: ["davinci-resolve", "unreal-engine"]
 }
 {
  // Local character, backstory, world and story planning.
  // bibisco-ce needs the free vendor CE ZIP staged; see README.
  action: "install"
  package_manager: "yay"
  names: ["manuskript", "bibisco-ce"]
 }
]

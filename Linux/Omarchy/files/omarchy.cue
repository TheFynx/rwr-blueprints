// Apply user-owned Hyprland, launcher-extension, and Topgrade files. Omarchy
// shell state, plugins, theme selection, defaults, and hooks are reconciled by
// configuration/omarchy.cue instead of replacing shell.json wholesale.
{
 directories: [{
  action: "copy"
  name: ".config"
  source: "./omarchy-src/"
  target: "{{ .User.home }}/"
 }]
}

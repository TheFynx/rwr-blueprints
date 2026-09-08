// Apply the working personal bindings and screensaver integration on every
// Omarchy run. The configuration selection already identifies Omarchy.
{
 directories: [{
  action: "copy"
  name: ".config"
  source: "./omarchy-src/"
  target: "{{ .User.home }}/"
 }]
}

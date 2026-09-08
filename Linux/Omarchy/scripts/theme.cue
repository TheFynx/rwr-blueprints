// Install the complete local theme, companion launcher and theme-set hook.
// The source lives in the blueprint checkout, so install.sh can copy it safely.
{
 scripts: [{
  name: "install.sh"
  action: "run"
  exec: "bash"
  source: "../files/src/midgar-mako/integration/"
 }]
}

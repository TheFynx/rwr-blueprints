scripts: [
 {
  action: "run"
  exec: "bash"
  name: "nvim.sh"
  source: "../../../Common/scripts/"
 },
 {
  action: "run"
  exec: "bash"
  name: "retire-midgar-screensaver.sh"
  source: "../../Omarchy/scripts/"
 },
 {
  // Idempotently register Git LFS for the current user, without modifying
  // existing repositories' tracking rules or committing any assets.
  action: "run"
  exec: "bash"
  name: "git-lfs-setup"
  content: "git lfs install --skip-repo\n"
 }
]

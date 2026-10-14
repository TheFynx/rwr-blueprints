// Explicitly selected Omarchy animation workstation; see README.md.
{
 blueprints: {
  format: "cue"
  location: "."
  except: ["credentials"]
  includes: ["../../Common/credentials/gpg.cue"]
  git: {
   target: "{{ .User.home }}/git/thefynx/rwr-blueprints"
   url: "https://github.com/thefynx/rwr-blueprints.git"
  }
  order: ["ssh_keys", "packages", "users", "scripts", "files", "services", "git", "configuration"]
 }
 packageManagers: [{name: "yay", action: "install"}]
}

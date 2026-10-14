// Reuse the Omarchy desktop payload without duplicating it.
directories: [{
 action: "copy"
 name: ".config"
 source: "../../Omarchy/files/omarchy-src/"
 target: "{{ .User.home }}/"
}]

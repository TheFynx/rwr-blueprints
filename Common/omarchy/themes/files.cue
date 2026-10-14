// Both consumers live at Linux/<build>/files; imports retain that source base.
directories: [
 {action: "copy", name: ".config", source: "../../../Common/omarchy/themes/src/home", target: "{{ .User.home }}/"},
 {action: "copy", name: ".local", source: "../../../Common/omarchy/themes/src/home", target: "{{ .User.home }}/"},
 {action: "copy", name: "backgrounds", source: "../../../Common/omarchy/themes/src/minecraft", target: "{{ .User.home }}/.config/omarchy/themes/minecraft-deepstone/"},
 {action: "copy", name: "backgrounds", source: "../../../Common/omarchy/themes/src/minecraft", target: "{{ .User.home }}/.config/omarchy/themes/minecraft-nether/"},
 {action: "copy", name: "backgrounds", source: "../../../Common/omarchy/themes/src/minecraft", target: "{{ .User.home }}/.config/omarchy/themes/minecraft-end/"},
]

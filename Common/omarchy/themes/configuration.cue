// Configuration asset paths are relative to this declaration, including imports.
configurations: [{
 name: "shared-themes"
 tool: "omarchy"
 action: "set"
 plugins: [{
  id: "levi.menu"
  source: {path: "src/levi.menu"}
  enabled: true
  widget: {visible: true, section: "left", index: 0}
 }, {id: "omarchy.menu", enabled: false}]
 theme: {name: "minecraft-deepstone", active: true}
 hooks: [
  {event: "theme-set", name: "50-omasettings-render", source: "src/hooks/50-omasettings-render"},
  {event: "theme-set", name: "90-minecraft-integration", source: "src/hooks/90-minecraft-integration"},
  {event: "post-boot", name: "90-minecraft-integration", source: "src/hooks/90-minecraft-integration"},
 ]
}]

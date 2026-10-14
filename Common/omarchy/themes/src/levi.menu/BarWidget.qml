import QtQuick
import qs.Ui
import Quickshell
import Quickshell.Io

BarWidget {
  id: root
  moduleName: "omarchy.menu"
  property string themeSlug: ""
  readonly property bool minecraft: themeSlug.indexOf("minecraft-") === 0 || themeSlug === "midgar-mako"
  FileView {
    path: Quickshell.env("HOME") + "/.local/state/omarchy/current/theme.name"
    watchChanges: true
    preload: true
    onLoaded: root.themeSlug = text().trim()
    onFileChanged: reload()
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.minecraft ? "" : "\ue900"
    hasVisualContent: root.minecraft || text !== ""
    fontFamily: "omarchy"
    horizontalMargin: 7.5
    implicitWidth: root.minecraft ? 38 : Math.max(30, implicitHeight)
    Image {
      anchors.centerIn: parent
      width: 24; height: 24
      visible: root.minecraft
      source: root.minecraft ? "file://" + Quickshell.env("HOME") + "/.local/state/omarchy/current/theme/assets/menu.svg?v=4-" + root.themeSlug : ""
      smooth: root.themeSlug === "midgar-mako"
      cache: false
    }
    onPressed: function(button) {
      if (!root.bar) return
      if (button === Qt.RightButton) root.bar.run("xdg-terminal-exec")
      else root.bar.run("omarchy-shell shell toggle omarchy.menu '{\"menu\":\"root\"}'")
    }
  }
}

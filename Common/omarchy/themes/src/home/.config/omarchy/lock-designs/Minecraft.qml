import QtQuick
import Quickshell
import qs.Commons
import "../plugins/io.github.sirjul1337.lock-explorer/designs"

DesignBase {
  id: lock
  inputItem: field.input
  shakeOnFail: true
  FontLoader { id: pixelFont; source: "file://" + Quickshell.env("HOME") + "/.local/share/fonts/Minecraft-PressStart2P.ttf" }
  readonly property string assetRoot: "file://" + Quickshell.env("HOME") + "/.local/state/omarchy/current/theme/assets/"
  Wallpaper { anchors.fill: parent; lock: lock; blur: 0.12; dim: 0.28; vignetteBottom: 0.55 }
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onClicked: { lock.wakeRequested(); lock.forcePasswordFocus() }
    onPositionChanged: lock.wakeRequested()
  }
  Column {
    anchors.centerIn: parent
    spacing: 18
    width: Math.min(lock.width - 48, 570)
    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: lock.clock("HH:mm")
      color: Color.lock.text
      font.family: pixelFont.name
      font.pixelSize: 46
      style: Text.Outline
      styleColor: "#0b100e"
    }
    Text {
      anchors.horizontalCenter: parent.horizontalCenter
      text: Qt.formatDate(lock.now, "dddd · d MMMM").toUpperCase()
      color: Color.lock.text
      font.family: Style.font.family
      font.pixelSize: 14
      font.letterSpacing: 2
    }
    Rectangle {
      width: parent.width
      height: 278
      color: Color.lock.background
      border.width: 3
      border.color: Color.lock.placeholder
      Rectangle { x: 3; y: 3; width: parent.width - 6; height: 3; color: "#ffffff"; opacity: 0.15 }
      Rectangle { x: 3; y: parent.height - 6; width: parent.width - 6; height: 3; color: "#000000"; opacity: 0.6 }
      Column {
        anchors.centerIn: parent
        width: parent.width - 42
        spacing: 20
        Row {
          spacing: 12
          Image { width: 35; height: 35; source: lock.assetRoot + "grass.svg"; smooth: false; cache: false }
          Column {
            spacing: 6
            Text { text: "WORLD LOCKED"; color: Color.lock.text; font.family: pixelFont.name; font.pixelSize: 13 }
            Text { text: lock.userName + "  /  " + lock.hostName; color: Color.lock.placeholder; font.family: Style.font.family; font.pixelSize: 13 }
          }
        }
        Row {
          spacing: 5
          Repeater { model: 10; Image { width: 22; height: 22; source: lock.assetRoot + "heart.svg"; smooth: false; opacity: lock.errorState ? 0.4 : 1 } }
        }
        PasswordField {
          id: field
          lock: lock
          width: parent.width
          height: 54
          radius: 0
        }
        Text {
          width: parent.width
          horizontalAlignment: Text.AlignHCenter
          text: lock.authenticatingPassword ? "Unlocking your world…" : (lock.errorState ? lock.failureMessage : (lock.fingerprintConfigured ? "Password or fingerprint to resume" : "Password to resume"))
          textFormat: Text.PlainText
          color: lock.errorState ? Color.lock.textError : Color.lock.text
          font.family: Style.font.family
          font.pixelSize: 13
        }
      }
    }
    Row {
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 4
      Repeater {
        model: ["pickaxe", "sword", "diamond", "grass", "torch", "chest", "crafting", "compass", "food"]
        Rectangle {
          required property string modelData
          required property int index
          width: 48; height: 48
          color: Color.lock.background
          border.width: index === 0 ? 3 : 2
          border.color: index === 0 ? Color.lock.text : Color.lock.placeholder
          Image { anchors.centerIn: parent; width: 34; height: 34; source: lock.assetRoot + parent.modelData + ".svg"; smooth: false; cache: false }
        }
      }
    }
    Rectangle { anchors.horizontalCenter: parent.horizontalCenter; width: 460; height: 5; color: Color.lock.placeholder
      Rectangle { width: parent.width * 0.72; height: parent.height; color: Color.accent }
    }
  }
}

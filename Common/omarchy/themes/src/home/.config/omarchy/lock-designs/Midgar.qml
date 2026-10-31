import QtQuick
import Quickshell
import qs.Commons
import qs.Commons as Commons
import "../plugins/io.github.sirjul1337.lock-explorer/designs"

DesignBase {
 id: lock
 inputItem: field.input
 shakeOnFail: true
 readonly property string assetRoot: "file://" + Quickshell.env("HOME") + "/.local/state/omarchy/current/theme/assets/"
 Wallpaper { anchors.fill: parent; lock: lock; blur: 0.1; dim: 0.4; vignetteBottom: 0.6 }
 MouseArea { anchors.fill: parent; hoverEnabled: true; onClicked: { lock.wakeRequested(); lock.forcePasswordFocus() }
 onPositionChanged: lock.wakeRequested() }
 Column {
  anchors.centerIn: parent
  width: Math.min(lock.width - 48, 550)
  spacing: 18
  Text { anchors.horizontalCenter: parent.horizontalCenter; text: lock.clock("HH:mm"); color: Commons.Color.lock.text; font.family: Style.font.family; font.pixelSize: 56; font.weight: Font.Light }
  Text { anchors.horizontalCenter: parent.horizontalCenter; text: Qt.formatDate(lock.now,"dddd · d MMMM").toUpperCase(); color: Commons.Color.lock.placeholder; font.family: Style.font.family; font.pixelSize: 13; font.letterSpacing: 2 }
  Rectangle {
   width: parent.width; height: 290; radius: 4
   color: Commons.Color.lock.background; border.width: 1; border.color: Commons.Color.accent
   Rectangle { x: 1; y: 1; width: parent.width-2; height: 3; radius: 2; color: Commons.Color.accent; opacity: 0.6 }
   Column {
    anchors.centerIn: parent; width: parent.width-48; spacing: 20
    Row {
     spacing: 14
     Image { width: 46; height: 46; source: lock.assetRoot+"menu.svg"; cache: false }
     Column {
      spacing: 5
      Text { text: "MIDGAR / MAKO NETWORK"; color: Commons.Color.lock.text; font.family: Style.font.family; font.pixelSize: 16; font.letterSpacing: 1 }
      Text { text: lock.userName+"  ·  "+lock.hostName; color: Commons.Color.lock.placeholder; font.family: Style.font.family; font.pixelSize: 13 }
     }
    }
    Row {
     spacing: 10
     Repeater { model: ["magic","support","command","summon","independent"]
      Image { required property string modelData; width: 28; height: 28; source: lock.assetRoot+modelData+".svg"; cache: false }
     }
     Text { text: "SESSION LOCKED"; anchors.verticalCenter: parent.verticalCenter; color: Commons.Color.lock.placeholder; font.family: Style.font.family; font.pixelSize: 11; font.letterSpacing: 1 }
    }
    PasswordField { id: field; lock: lock; width: parent.width; height: 52; radius: 4 }
    Text {
     width: parent.width; horizontalAlignment: Text.AlignHCenter; textFormat: Text.PlainText
     text: lock.authenticatingPassword ? "Resuming session…" : (lock.errorState ? lock.failureMessage : (lock.fingerprintConfigured ? "Password or fingerprint to resume" : "Password to resume"))
     color: lock.errorState ? Commons.Color.lock.textError : Commons.Color.lock.text; font.family: Style.font.family; font.pixelSize: 13
    }
   }
  }
  Text { anchors.horizontalCenter: parent.horizontalCenter; text: "THE LIFESTREAM CONTINUES"; color: Commons.Color.lock.placeholder; font.family: Style.font.family; font.pixelSize: 11; font.letterSpacing: 3 }
 }
}

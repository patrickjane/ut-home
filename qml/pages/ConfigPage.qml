import Ubuntu.Components 1.3
import QtQuick 2.7
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

Page {
   property var webView

   id: configPage
   anchors.fill: parent

   Settings {
      id: settings
      property string mothership
      property double zoomFactor: 1.0
   }

   header: PageHeader {
      id: header
      title: i18n.tr("Settings")
   }

   Flickable {
      anchors.top: header.bottom
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.bottom: parent.bottom

      contentWidth: parent.width
      contentHeight: childrenRect.height

      Column {
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.top: parent.top

         ListItem {
            height: layout1.height + (divider.visible ? divider.height : 0)

            SlotsLayout {
               id: layout1
               mainSlot: Label {
                  text: i18n.tr("Home Assistant URL") + ":"
               }
            }
         }

         ListItem {
            height: layout2.height + (divider.visible ? divider.height : 0)

            SlotsLayout {
               id: layout2
               mainSlot: TextField {
                  id: urlField
                  placeholderText: "http://localhost:8123"
                  text: settings.mothership
                  SlotsLayout.position: SlotsLayout.Trailing;

                  inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText
               }
               Button {
                  id: buttonLogin
                  text: i18n.tr("Go!")
                  enabled: urlField.text && urlField.text.length

                  SlotsLayout.position: SlotsLayout.Trailing;
                  onClicked: {
                     settings.mothership = urlField.text
                     webView.url = urlField.text
                     pageStack.pop()
                  }
               }
            }
         }

         ListItem {
            height: l3.height + (divider.visible ? divider.height : 0)

            ListItemLayout {
               id: l3
               title.text: i18n.tr("Zoom factor")
               title.font.bold: true
               subtitle.text: i18n.tr("Restart the app for the changes to take effect")
               subtitle.color: "red"
               subtitle.visible: false
            }
         }

         ListItem {
              anchors.left: parent.left
              anchors.right: parent.right
              height: l4.height + (divider.visible ? divider.height : 0)

              SlotsLayout {
                 id: l4
                 mainSlot: Column {
                    Slider {
                       id: zoomFactorSlider
                       anchors.left: parent.left
                       anchors.right: parent.right
                       anchors.rightMargin: units.gu(1)

                       function formatValue(v) { return null }

                       minimumValue: 0.1
                       maximumValue: 5.0
                       stepSize: 0.1
                       value: 1.0
                       live: true

                       Settings {
                          property alias zoomFactor: zoomFactorSlider.value
                       }

                       onValueChanged: {
                          settings.zoomFactor = value
                       }

                       onTouched: {
                          l3.subtitle.visible = true
                       }

                    }
                    Text {
                       text: zoomFactorSlider.value.toFixed(1)
                    }
                 }
              }
         }
      }
   }

}
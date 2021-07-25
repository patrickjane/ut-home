import Ubuntu.Components 1.3
import QtQuick 2.7
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Morph.Web 0.1

import "../notify"

Item {
   id: mapPage
   anchors.fill: parent

   Settings {
      id: settings
      property string mothership
   }

   WebView {
      id: webView
      anchors.fill: parent
      url: settings.mothership

      onLoadingChanged: {
         if (loadRequest.status == WebView.LoadFailedStatus) {
            Notify.error(i18n.tr("Network error"), i18n.tr("Failed to load URL ") + loadRequest.url)
            pageStack.push(Qt.resolvedUrl("./ConfigPage.qml"), { webView: webView })
         }
      }
   }

   Component.onCompleted: {
      initTimer.start()
   }

   Timer {
      id: initTimer
      interval: 200
      running: false
      repeat: false

      onTriggered: {
         if (!settings.mothership || !settings.mothership.length)
            pageStack.push(Qt.resolvedUrl("./ConfigPage.qml"), { webView: webView })
      }
   }
}
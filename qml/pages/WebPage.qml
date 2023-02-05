import Lomiri.Components 1.3
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
      property double zoomFactor: 1.0
   }

   WebView {
      id: webView
      anchors.fill: parent
      url: settings.mothership
      zoomFactor: settings.zoomFactor

      onLoadingChanged: {
         if (loadRequest.status == WebView.LoadFailedStatus) {
            Notify.error(i18n.tr("Network error"), i18n.tr("Failed to load URL ") + loadRequest.url)
            pageStack.push(Qt.resolvedUrl("./ConfigPage.qml"), { webView: webView })
         }
      }
   }

   Component.onCompleted: {
      console.log("Mothership:", settings.mothership);
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
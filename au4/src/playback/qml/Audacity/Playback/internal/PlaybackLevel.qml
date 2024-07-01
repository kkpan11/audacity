/*
* Audacity: A Digital Audio Editor
*/
import QtQuick 2.15
import QtQuick.Layouts 1.15

import Muse.UiComponents 1.0
import Muse.Ui 1.0

import "../components"

Item {
    id: root

    property alias volumeLevel: volumeSlider.volumeLevel

    property alias leftCurrentVolumePressure: leftVolumePressure.currentVolumePressure
    property alias leftRecentPeak: leftVolumePressure.recentPeak
    property alias leftMaxPeak: leftVolumePressure.maxPeak

    property alias rightCurrentVolumePressure: rightVolumePressure.currentVolumePressure
    property alias rightRecentPeak: rightVolumePressure.recentPeak
    property alias rightMaxPeak: rightVolumePressure.maxPeak

    property NavigationPanel navigationPanel: null
    property int navigationOrder: 0

    signal volumeLevelChangeRequested(var level)

    RowLayout {
        anchors.fill: parent

        StyledIconLabel {
            Layout.preferredWidth: parent.height
            Layout.preferredHeight: Layout.preferredWidth

            iconCode: IconCode.AUDIO
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            Layout.margins: 4

            Column {
                id: volumePressureContainer

                anchors.fill: parent

                spacing: 2

                VolumePressureMeter {
                    id: leftVolumePressure
                }
                VolumePressureMeter {
                    id: rightVolumePressure
                    showRuler: true
                }
            }

            VolumeSlider {
                id: volumeSlider

                anchors.left: parent.left
                anchors.leftMargin: -handleWidth/2
                anchors.right: parent.right
                anchors.rightMargin: -handleWidth/2 + leftVolumePressure.overloadWidth
                anchors.top: parent.top
                anchors.topMargin: -1

                navigation.panel: root.navigationPanel
                navigation.order: root.navigationOrder

                onVolumeLevelMoved: function(level) {
                    root.volumeLevelChangeRequested(Math.round(level * 10) / 10)
                }
            }
        }
    }
}

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import DarkStyle.Controls 1.0
import DarkStyle 1.0

Rectangle {

    id: root
    property variant inputs: model.inputs
    property variant outputs: model.outputs

    function getInputItem(id) {
        return inputRepeater.itemAt(id);
    }
    function getOutputItem(id) {
        return outputRepeater.itemAt(id);
    }

    x: 10
    y: 10
    z: (currentNodeID == index) ? 2 : 1
    radius: 10
    color: Style.window.color.dark
    border.color: mouse.containsMouse ? Style.window.color.selected : Style.window.color.light
    Behavior on border.color { ColorAnimation {}}
    onXChanged: nodeChanged()
    onYChanged: nodeChanged()

    MouseArea { // drag
        id: mouse
        anchors.fill: parent
        drag.target: root
        drag.axis: Drag.XAndYAxis
        drag.minimumX: 0
        drag.maximumX: root.parent.width - root.width
        drag.minimumY: 0
        drag.maximumY: root.parent.height - root.height
        propagateComposedEvents: true
        hoverEnabled: true
        onClicked: {
            currentNodeID = index;
            selectionChanged(model)
        }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        height: 20
        text: model.name
        font.pixelSize: Style.text.size.xsmall
        color: Style.text.color.dark
        horizontalAlignment: Text.AlignHCenter
    }

    RowLayout {
        anchors.fill: parent
        anchors.topMargin: 20
        anchors.bottomMargin: 10
        spacing: 2
        ScrollView {
            id: inputScrollview
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            Column {
                width: inputScrollview.width
                height: inputRepeater.model.count * (inputRepeater.itemHeight+spacing)
                spacing: 2
                Repeater {
                    id: inputRepeater
                    property int itemHeight: 15
                    anchors.fill: parent
                    model: root.inputs
                    RowLayout {
                        width: inputRepeater.width
                        height: inputRepeater.itemHeight
                        spacing: 2
                        Rectangle {
                            Layout.fillHeight: true
                            Layout.preferredWidth: 2
                            color: Style.window.color.xlight
                        }
                        Text {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: model.name
                            font.pixelSize: Style.text.size.xsmall
                        }
                    }
                }
            }
        }
        ScrollView {
            id: outputScrollview
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            Column {
                width: outputScrollview.width
                height: outputRepeater.model.count * (outputRepeater.itemHeight+spacing)
                spacing: 2
                Repeater {
                    id: outputRepeater
                    property int itemHeight: 15
                    anchors.fill: parent
                    model: root.outputs
                    RowLayout {
                        width: inputRepeater.width
                        height: inputRepeater.itemHeight
                        spacing: 2
                        Text {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: model.name
                            font.pixelSize: Style.text.size.xsmall
                            horizontalAlignment: Text.AlignRight
                        }
                        Rectangle {
                            Layout.fillHeight: true
                            Layout.preferredWidth: 2
                            color: Style.window.color.xlight
                        }
                    }
                }
            }
        }
    }
}

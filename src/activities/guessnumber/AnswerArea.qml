/* GCompris - AnswerArea.qml
*
* Copyright (C) 2014 Thib ROMAIN <thibrom@gmail.com>
*
* Authors:
*   Bruno Coudoin <bruno.coudoin@gcompris.net> (GTK+ version)
*   Thib ROMAIN <thibrom@gmail.com> (Qt Quick port)
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation; either version 3 of the License, or
*   (at your option) any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License
*   along with this program; if not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.1
import GCompris 1.0
import "../../core"
import "guessnumber.js" as Activity

Rectangle {
    id: answerBackground
    width: 100 * ApplicationInfo.ratio
    height: 60 * ApplicationInfo.ratio
    color: activeFocus ? "#ff07fff2" : "#cccccccc"
    radius: 10
    border {
        width: activeFocus ?  3 : 1
        color: "black"
    }

    // The backspace code comming from the vitual keyboard
    property string backspaceCode

    // A top gradient
    Rectangle {
        anchors.fill: parent
        anchors.margins: activeFocus ?  3 : 1
        radius: 10
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#CCFFFFFF" }
            GradientStop { position: 0.5; color: "#80FFFFFF" }
            GradientStop { position: 1.0; color: "#00000000" }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: parent.forceActiveFocus()

    }

    Keys.onPressed: {
        if(event.key === Qt.Key_Backspace) {
            backspace()
        }
        appendText(event.text)
    }

    function backspace() {
        userEntry.text = userEntry.text.slice(0, -1)
        if(userEntry.text.length === 0) {
            userEntry.text = "?"
            return
        } else {
            //Activity.setUserAnswer(parseInt(userEntry.text))
            return
        }
    }

    function appendText(text) {
        if(text === answerBackground.backspaceCode) {
            backspace()
            return
        }

        var number = parseInt(text)
        if(isNaN(number))
            return

        if(userEntry.text === "?") {
            userEntry.text = ""
        }

        if(userEntry.text.length >= 2) {
            return
        }

        userEntry.text += text
        Activity.setUserAnswer(parseInt(userEntry.text))
    }

    GCText {
        id: userEntry
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "?"
        color: "black"
        font.pointSize: 28
        style: Text.Outline
        styleColor: "white"
    }
}

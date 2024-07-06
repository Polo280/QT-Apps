import QtQuick
import QtQuick.Layouts

///////////// SIDE MENU QML /////////////
Item {
    anchors.fill: parent
    property int transitionDurationMs: 250   // Adjust transition duration as needed

    // Create overlapping Rectangle for sidebar
   Rectangle {
       property int menuWidth: 350              // Adjust side menu width as needed

       id: sideMenuRect
       visible: false // Not visible unless triggered via button
       z: 1           // Ensure it is above the middle panel
       // Adjust size and position
       height: parent.height - topPanel.height - 5
       width: menuWidth
       x: 0; y: topPanel.height + 5
       // Define color and appearance
       color: "#181818"
       opacity: 0.97
       radius: 5
       border.color: "#d0d0d0"
       border.width: 1
       // Set an initial state
       state: "enabled"
   }

   // Define Menu states
   states: [
      // Disabled State (not visible)
      State{
           name: "disabled"
           PropertyChanges {
               target: sideMenuRect
               width: 5
               visible: false
           }
       },

       // Enabled State (visible)
       State{
            name: "enabled"
            PropertyChanges {
                target: sideMenuRect
                width: menuWidth
                visible: true
            }
        }
   ]

   // Define transitions disabled<->enabled
   transitions: [
      Transition{
         from: "disabled"
         to: "enabled"

         NumberAnimation {
             property: "width"
             duration: transitionDurationMs
         }
         PropertyAction {
             property: "visible"
             value: true
         }
      },

       Transition{
          from: "enabled"
          to: "disabled"

          SequentialAnimation{   // Sequential to avoid it dissapearing immediately
              NumberAnimation {
                  property: "width"
                  duration: transitionDurationMs
              }
              PropertyAction {
                  property: "visible"
                  value: false
              }
          }
       }
   ]
}

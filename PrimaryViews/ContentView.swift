import SwiftUI

struct ContentView: View {
    @ObservedObject var myVariables: Variables = Variables()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        ViewController(myVariables: myVariables)
            .accentColor(myVariables.allColors[myVariables.selectedColor])
            .fontWidth(.compressed)
    }
}


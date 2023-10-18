import SwiftUI

struct NumpadButton: ButtonStyle {
    @ObservedObject var myVariables: Variables
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundColor(.primary)
                .frame(width: 60, height: myVariables.buttonShrinker ? 45 : 60, alignment: .center)
                .font(.system(size: 30))
                .padding(5)
                .modifier(UIStyle(myVariables: myVariables))
                .opacity(configuration.isPressed ? 0.5 : 1)
    }
}
struct OperationButton: ButtonStyle {
    @ObservedObject var myVariables: Variables
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(myVariables.allColors[myVariables.selectedColor])
            .frame(width: 60, height: myVariables.buttonShrinker ? 45 : 60, alignment: .center)
            .font(.system(size: 30))
            .padding(5)
            .modifier(UIStyle(myVariables: myVariables))
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct LongButton: ButtonStyle {
    @ObservedObject var myVariables: Variables
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .offset(x: 20)
            .frame(width: 140, height: myVariables.buttonShrinker ? 45 : 60, alignment: .leading)
            .font(.system(size: 30))
            .padding(5)
            .modifier(UIStyle(myVariables: myVariables))
            .offset(x: 40)
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct UIStyle: ViewModifier {
    @ObservedObject var myVariables: Variables
    func body(content: Content) -> some View {
            content
                .background(Rectangle().fill(Color(myVariables.allColorsBg[myVariables.selectedColorBg].lighter())).opacity(0.5))
                .cornerRadius(CGFloat(myVariables.cornerSides))
                .shadow(color: Color(myVariables.allColorsBg[myVariables.selectedColorBg].darker()), radius: 3, x: 5, y: 5)
    }
}

struct RegularButton: ButtonStyle {
    @ObservedObject var myVariables: Variables
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(UIStyle(myVariables: myVariables))
            .padding(5)
    }
}

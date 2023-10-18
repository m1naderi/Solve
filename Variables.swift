import SwiftUI

class Variables: ObservableObject {
    @Published var ProcessText = ""
    @Published var DisplayText = ""
    @Published var DisplayHistory = ""
    @Published var ErrorDetected: Bool = false
    @Published var OperationAllowed = false
    @Published var CurrentProcess = ""
    @Published var DecimalActive = false
    @Published var buttonShrinker = false
    @AppStorage("HISTORY") var myHistory: [String] = []
    @AppStorage ("COLOR") var selectedColor = 3
    @AppStorage ("BGCOLOR") var selectedColorBg = 5
    @AppStorage("CORNERS") var cornerSides: Double = 40.0
    
    let allColors: [Color] = [
        .blue,
        .green,
        .yellow,
        .orange,
        .red,
        .pink,
        .purple,
        .indigo
    ]
    
    let allColorsText: [String] = [
        "Blue",
        "Green",
        "Yellow",
        "Orange",        
        "Red",
        "Pink",
        "Purple",
        "Indigo"
    ]
    
    let allColorsBg: [UIColor] = [
        UIColor(hue: 0, saturation: 0, brightness: 0.1, alpha: 1),
        UIColor(hue: 0, saturation: 0, brightness: 0.9, alpha: 1),
        UIColor(hue: 0.6, saturation: 0.7, brightness: 0.4, alpha: 1),
        UIColor(hue: 0.35, saturation: 0.3, brightness: 0.6, alpha: 1),
        UIColor(hue: 0.15, saturation: 0.3, brightness: 0.9, alpha: 1),
        UIColor(hue: 0.05, saturation: 0.6, brightness: 0.8, alpha: 1),
        UIColor(hue: 0, saturation: 0.7, brightness: 0.8, alpha: 1),
        UIColor(hue: 0, saturation: 0.4, brightness: 0.95, alpha: 1),
        UIColor(hue: 0.7, saturation: 0.3, brightness: 0.5, alpha: 1),
        UIColor(hue: 0.75, saturation: 0.5, brightness: 0.3, alpha: 1)
    ]
    
    let allColorsBgText: [String] = [
        "Fig",
        "Coconut",
        "Blueberry",
        "Mint",
        "Lemon",
        "Carrot",
        "Apple",
        "Peach",
        "Grapes",
        "Eggplant"
    ]
}

extension UIColor {    
    // Add value to component ensuring the result is 
    // between 0 and 1
    private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        return max(0, min(1, toComponent + value))
    }
}

extension UIColor {
    private func makeColor(componentDelta: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Extract r,g,b,a components from the
        // current UIColor
        getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
        
        // Create a new UIColor modifying each component
        // by componentDelta, making the new UIColor either
        // lighter or darker.
        return UIColor(
            red: add(componentDelta, toComponent: red),
            green: add(componentDelta, toComponent: green),
            blue: add(componentDelta, toComponent: blue),
            alpha: alpha
        )
    }
}

extension UIColor {
    func lighter(componentDelta: CGFloat = 0.1) -> UIColor {
        return makeColor(componentDelta: componentDelta)
    }
    
    func darker(componentDelta: CGFloat = 0.1) -> UIColor {
        return makeColor(componentDelta: -1*componentDelta)
    }
}

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

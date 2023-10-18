import SwiftUI

struct Display: View {
    @ObservedObject var myVariables: Variables
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                if myVariables.ErrorDetected != true{
                    Text(myVariables.DisplayHistory)
                        .font(.system(size: myVariables.buttonShrinker ? 50 : 100))
                        .padding(.horizontal, 30)
                        .padding(.vertical, myVariables.buttonShrinker ? -60 : -10)
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .bottomTrailing)
                        .textSelection(.enabled)
                    VStack{
                        if geo.size.height > 100 {
                            if myVariables.DisplayText == ""{
                                Text("0")
                            }else{
                                Text(myVariables.DisplayText)
                            }
                        }
                    }
                    .font(.system(size: geo.size.height*2))
                    .fixedSize()
                    .frame(width: geo.size.width-30, height: geo.size.height, alignment: .bottomLeading)
                    .offset(y: geo.size.height/5)
                    .opacity(0.1)
                } else {
                    Text("ERROR")
                        .font(.system(size: geo.size.height - 200))
                        .frame(width: geo.size.width-30, height: geo.size.height, alignment: .bottomTrailing)
                }
            }
        }
    }
}

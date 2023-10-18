import SwiftUI
import MessageUI

struct ViewLayout: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @ObservedObject var myVariables: Variables
    
    var body: some View {
        GeometryReader{geo in
            VStack{
                VStack{
                    Display(myVariables: myVariables)
                        .frame(height: myVariables.buttonShrinker ?  geo.size.height - 350 : geo.size.height - 450)
                        .onChange(of: geo.size){ _ in
                            if geo.size.height < 500 {
                                myVariables.buttonShrinker = true
                            } else {
                                myVariables.buttonShrinker = false
                            }
                        }
                    HStack{
                        if horizontalSizeClass == .regular{
                            History(myVariables: myVariables)
                                .frame(width: geo.size.width - 400, height: myVariables.buttonShrinker ? 305 : 380)
                                .modifier(UIStyle(myVariables: myVariables))
                                .padding(.leading, 20)
                        }
                        Numpad(myVariables: myVariables)
                    }
                }
            }
                .frame(width: geo.size.width, height: geo.size.height+20)
                .background(Color(myVariables.allColorsBg[myVariables.selectedColorBg]))
        }.ignoresSafeArea(.keyboard, edges: .all)
    }
}

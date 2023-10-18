import SwiftUI

struct ViewController: View{
    @ObservedObject var myVariables: Variables
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View{
        NavigationStack{
            ViewLayout(myVariables: myVariables)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: HistoryCompact(myVariables: myVariables)){
                            if horizontalSizeClass == .compact{
                                Image(systemName: "clock")
                                    .frame(width: 60, height: 40, alignment: .center)
                                    .modifier(UIStyle(myVariables: myVariables))
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: Settings(myVariables: myVariables)){
                            Image(systemName: "gear")
                                .frame(width: 80, height: 40, alignment: .center)
                                .modifier(UIStyle(myVariables: myVariables))
                        }
                    }
                }
        }
    }
}

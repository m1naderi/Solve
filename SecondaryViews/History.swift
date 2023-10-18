import SwiftUI

struct History: View {
    @ObservedObject var myVariables: Variables
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: horizontalSizeClass == .compact ? geo.size.height/3 : geo.size.height/1.5))
                    .offset(x: geo.size.width/2.5, y: geo.size.height/3)
                    .opacity(0.1)
                    .padding(-100)
                VStack{
                    if myVariables.myHistory == []{
                        Text("No History")
                            .frame(width: geo.size.width, height: geo.size.height - 80, alignment: .center)
                    }else{
                        ScrollView(showsIndicators: false){
                            Text("")
                            ForEach(myVariables.myHistory.indices, id:\.self){ index in
                                Text(myVariables.myHistory[((myVariables.myHistory.count-1)-index)])
                                    .font(.title2)
                                    .padding(.leading)
                                    .frame(width: geo.size.width, height: 50, alignment: .leading)
                                    .textSelection(.enabled)
                                Rectangle()
                                    .frame(height: 1)
                            }
                        }
                    }
                }.frame(height: geo.size.height - 20)
            }
        }
    }
}

struct HistoryCompact: View {
    @ObservedObject var myVariables: Variables
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                History(myVariables: myVariables)
                    .padding(.top, 50)
                Button{
                    self.presentationMode.wrappedValue.dismiss()  
                }label: {
                    Text("Back")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(myVariables.allColors[myVariables.selectedColor])
                        .padding(.horizontal)
                        .padding(5)
                        .modifier(UIStyle(myVariables: myVariables))
                }
                .padding()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color(myVariables.allColorsBg[myVariables.selectedColorBg]))
            .navigationBarBackButtonHidden(true)
        }
    }
}

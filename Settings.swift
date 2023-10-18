import SwiftUI
import MessageUI

struct Settings: View {
    @ObservedObject var myVariables: Variables
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var showingAlert = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var showingAlertCustomization = false
    @State var showingAlertHistory = false
    @State var isPresentedSupport = false
    @State var isPresentedSecondaryColor = false
    @State var isPresentedBackgroundColor = false
    @State var gearRotation: Angle = Angle(degrees: 0)
    
    let rows = [
        GridItem(.fixed(75)),
        GridItem(.fixed(75))
    ]
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                Image(systemName: "gear")
                    .rotationEffect(gearRotation, anchor: .center)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1)){
                            gearRotation = Angle(degrees: 45)
                        }
                    }
                    .font(.system(size: geo.size.height*2))
                    .offset(x: geo.size.width/2, y: -geo.size.height/2)
                    .opacity(0.1)
                ScrollView(showsIndicators: false){ 
                    VStack{
                        Text("Solve")
                            .font(.system(size: horizontalSizeClass == .regular ? geo.size.width / 8: geo.size.width / 5))
                            .fontWeight(.bold)
                            .padding(.vertical, -geo.size.width / 30)
                            .padding(.top, 100)
                        Text("1.0.0")
                            .font(.system(size: 40))
                    }.frame(width: geo.size.width - 80, alignment: .leading)
                    VStack{
                        HStack{
                            Button{
                                withAnimation{
                                    if myVariables.cornerSides == 40.0 {
                                        myVariables.cornerSides = 5.0
                                    }
                                    else if myVariables.cornerSides == 20.0 {
                                        myVariables.cornerSides = 40.0
                                    } 
                                    else if myVariables.cornerSides == 5.0 {
                                        myVariables.cornerSides = 20.0
                                    }
                                }
                            }label: {
                                ZStack{
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(width: 75, height: 75)
                                    RoundedRectangle(cornerRadius: myVariables.cornerSides)
                                        .stroke(lineWidth: 8)
                                        .frame(width: 75, height: 75)
                                        .offset(x: 25, y: 25)
                                }
                            }
                            Button {
                                isPresentedSecondaryColor.toggle()
                            } label: {
                                Text(myVariables.allColorsText[myVariables.selectedColor])
                                    .font(.title)
                                    .foregroundColor(myVariables.allColors[myVariables.selectedColor])
                                    .frame(width: 105, height: 75)
                            }.popover(isPresented: $isPresentedSecondaryColor){
                                ZStack{
                                    Color(myVariables.allColorsBg[myVariables.selectedColorBg])
                                        .scaleEffect(2)
                                    
                                    ScrollView(.horizontal, showsIndicators: false){
                                        HStack{
                                            ForEach(myVariables.allColors.indices, id: \.self) { index in
                                                Button{
                                                    myVariables.selectedColor = index
                                                    isPresentedSecondaryColor = false
                                                }label: {
                                                    VStack{
                                                        Circle()
                                                            .foregroundColor(myVariables.allColors[index])
                                                            .frame(width: 50)
                                                            .padding(5)
                                                            .overlay(
                                                                Image(systemName: "checkmark")
                                                                    .foregroundColor(Color.primary)
                                                                    .font(.system(size: 15, weight: .medium))
                                                                    .shadow(color: Color.black.opacity(0.25), radius: 3, x: 0, y: 1)
                                                                    .opacity(index == myVariables.selectedColor ? 1 : 0)
                                                            )
                                                        Text(myVariables.allColorsText[index])
                                                            .foregroundColor(.primary)
                                                            .font(.title3)
                                                            .fontWeight(.bold)
                                                    }
                                                    .padding(20)
                                                    .modifier(UIStyle(myVariables: myVariables))
                                                }
                                            } 
                                        }
                                        .padding(.horizontal, 10)
                                        .padding()
                                    }
                                }
                                    .presentationDetents([.height(250)])
                                    .presentationDragIndicator(.visible)
                                    .frame(width: horizontalSizeClass == .compact ? geo.size.width : 500, height: 250)
                            }
                        }
                        Button {
                            isPresentedBackgroundColor.toggle()
                        }label: {
                            Label(
                                title: {
                                    Text(myVariables.allColorsBgText[myVariables.selectedColorBg])
                                        .frame(width: 80)
                                },
                                icon: { Image(systemName: "paintbrush.fill") }
                            )
                            .foregroundColor(.primary)
                            .font(.title)
                            .frame(width: 200, height: 75)
                        }.popover(isPresented: $isPresentedBackgroundColor){
                            ZStack{
                                Color(myVariables.allColorsBg[myVariables.selectedColorBg])
                                    .scaleEffect(2)
                                ScrollView(.horizontal, showsIndicators: false){
                                    LazyHGrid(rows: rows){
                                        ForEach(myVariables.allColorsBg.indices, id: \.self) { index in
                                            Button{
                                                myVariables.selectedColorBg = index
                                                isPresentedBackgroundColor = false
                                            }label: {
                                                HStack{
                                                    Circle()
                                                        .frame(width: 50, height: 50)
                                                        .foregroundColor(Color(myVariables.allColorsBg[index]))
                                                        .overlay(
                                                            Image(systemName: "checkmark")
                                                                .foregroundColor(Color.primary)
                                                                .font(.system(size: 15, weight: .medium))
                                                                .shadow(color: Color.black.opacity(0.25), radius: 3, x: 0, y: 1)
                                                                .opacity(index == myVariables.selectedColorBg ? 1 : 0)
                                                        )
                                                    Text(myVariables.allColorsBgText[index])
                                                        .foregroundColor(.primary)
                                                        .font(.title3)
                                                        .fontWeight(.bold)
                                                        .frame(width: 80)
                                                }
                                                .frame(width: 160, height: 75)
                                                .modifier(UIStyle(myVariables: myVariables))
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                    .padding()
                                }
                            }
                            .presentationDetents([.height(250)])
                            .presentationDragIndicator(.visible)
                            .frame(width: horizontalSizeClass == .compact ? geo.size.width : 500, height: 250)
                        }
                        
                        Button{
                            self.isShowingMailView.toggle()
                        }label: {
                            Label(
                                title: {
                                    Text("Feedback")
                                        .frame(width: 80)
                                },
                                icon: { Image(systemName: "bubble.fill") }
                            )
                            .foregroundColor(.primary)
                            .font(.title)
                            .frame(width: 200, height: 75)
                        }
                        .sheet(isPresented: $isShowingMailView) {
                            MailView(result: self.$result)
                        }
                        
                        Button{
                            isPresentedSupport = true
                        }label: {
                            Label(
                                title: { 
                                    Text("Support")
                                        .frame(width: 80)
                                },
                                icon: { Image(systemName: "heart.fill") }
                            )
                            .foregroundColor(.primary)
                            .font(.title)
                            .frame(width: 200, height: 75)
                        }.sheet(isPresented: $isPresentedSupport) { 
                            GeometryReader{ sheet in
                                Text("Donation Page")
                                    .frame(width: sheet.size.width, height: sheet.size.height)
                                    .background(Color(myVariables.allColorsBg[myVariables.selectedColorBg]))
                            }
                        }
                        
                        Text("Created by Mehrad Naderi")
                            .foregroundColor(.primary)
                            .font(.title)
                    }.padding(.trailing)
                    .frame(width: geo.size.width - 80, alignment: .trailing)
                    
                    HStack{
                        Button{
                            showingAlertCustomization = true
                        }label: {
                            Image(systemName: "gear.badge.xmark")
                                .font(.title3)
                                .frame(width: 60, height: 50)
                        }
                        .alert(isPresented:$showingAlertCustomization) {
                            Alert(
                                title: Text("Do you want to reset your Settings?"),
                                message: Text("You can't undo this action."),
                                primaryButton: .destructive(Text("Reset")) {
                                    myVariables.selectedColor = 3
                                    myVariables.cornerSides = 40.0
                                    myVariables.selectedColorBg = 2
                                },
                                secondaryButton: .cancel(Text("Cancel"))
                            )
                        }
                        
                        Button{
                            showingAlertHistory = true
                        }label: {
                            Image(systemName: "clock.badge.xmark")
                                .font(.title3)
                                .frame(width: 60, height: 50)
                        }
                        .alert(isPresented:$showingAlertHistory) {
                            Alert(
                                title: Text("Do you want to delete your History records?"),
                                message: Text("You can't undo this action."),
                                primaryButton: .destructive(Text("Delete")) {
                                    myVariables.myHistory = []
                                },
                                secondaryButton: .cancel(Text("Cancel"))
                            )
                        }
                    }.frame(width: geo.size.width - 80, alignment: .leading)
                        .foregroundColor(myVariables.allColors[myVariables.selectedColor])
                        .padding(.top, -10)
                    
                }.frame(width: geo.size.width, height: geo.size.height)
                Button{
                    self.presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("Back")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(myVariables.allColors[myVariables.selectedColor])
                        .padding(.horizontal)
                        .padding(5)
                }
                .padding()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .topLeading)
                
            }
            .buttonStyle(RegularButton(myVariables: myVariables))
            .frame(width: geo.size.width, height: geo.size.height)
            .background(Color(myVariables.allColorsBg[myVariables.selectedColorBg]))
            .navigationBarBackButtonHidden(true)
        }
    }
}

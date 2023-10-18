import SwiftUI

struct Numpad: View {
    @ObservedObject var myVariables: Variables

    let columnLayout = Array(repeating: GridItem(), count: 3)
    
    let NumbersLabel: [Int] = [
        7,8,9,4,5,6,1,2,3
    ]
    
    let OperationsLabel: [String] = [
        "divide","multiply","minus","plus"
    ]
    
    let Operations: [String] = [
        "/","*","-","+"
    ]
    
    let OperationsDisplay: [String] = [
        "÷","×","-","+"
    ]
    
    var body: some View {
        VStack{
            HStack{
                LazyVGrid(columns: columnLayout) {
                    Button("C"){
                        myVariables.ProcessText = ""
                        myVariables.DisplayText = ""
                        myVariables.DisplayHistory = ""
                        myVariables.CurrentProcess = ""
                        myVariables.OperationAllowed = false
                        myVariables.ErrorDetected = false
                        myVariables.DecimalActive = false
                    }
                        
                    Button{
                        if myVariables.OperationAllowed == true{
                            myVariables.ProcessText = "-" + myVariables.ProcessText
                            myVariables.DisplayText = "-" + myVariables.DisplayText
                            myVariables.DisplayHistory = "-" + myVariables.DisplayHistory
                        }
                    }label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .font(.title2)
                    }
                    
                    Button("%"){
                        if myVariables.OperationAllowed == true{
                            if myVariables.DecimalActive == false{
                                myVariables.ProcessText += ".0"
                            }
                            myVariables.ProcessText += "/100"
                            myVariables.DisplayText += "%"
                            myVariables.DisplayHistory += "%"
                        }
                    }
                    
                    ForEach(NumbersLabel.indices, id:\.self){ index in
                        Button{
                            myVariables.ProcessText += "\(NumbersLabel[index])"
                            myVariables.DisplayText += "\(NumbersLabel[index])"
                            myVariables.DisplayHistory += "\(NumbersLabel[index])"
                            myVariables.OperationAllowed = true
                        } label:{
                            Text("\(Int(NumbersLabel[index]))")
                        }
                    } 
                    
                    Button("0"){
                        myVariables.ProcessText += "0"
                        myVariables.DisplayText += "0"
                        myVariables.DisplayHistory += "0"
                        myVariables.OperationAllowed = true
                    }.buttonStyle(LongButton(myVariables: myVariables))
                    
                    Text("")
                    
                    Button("."){
                        if myVariables.DecimalActive == false{
                            myVariables.ProcessText += "."
                            myVariables.DisplayText += "."
                            myVariables.DisplayHistory += "."
                            myVariables.OperationAllowed = false
                            myVariables.DecimalActive = true
                        }
                    }
                }
                
                VStack{
                    ForEach(OperationsLabel.indices, id:\.self){ index in
                        Button{
                            if myVariables.OperationAllowed == true{
                                if myVariables.DecimalActive == false{
                                    myVariables.ProcessText += ".0"
                                }
                                myVariables.ProcessText += Operations[index]
                                myVariables.DisplayHistory += OperationsDisplay[index]
                                myVariables.DisplayText = ""
                                myVariables.OperationAllowed = false
                                myVariables.DecimalActive = false
                            }
                        } label:{
                            Image(systemName: "\(OperationsLabel[index])")
                        }
                    }
                    
                    Button{
                        if myVariables.OperationAllowed == true{
                            myVariables.CurrentProcess = myVariables.DisplayHistory
                            do {
                                let expr = try(NSExpression(format:myVariables.ProcessText))
                                if let result = expr.expressionValue(with: nil, context: nil) as? NSNumber {
                                    let x = result.floatValue
                                    myVariables.ProcessText = "\(x)"
                                } else {
                                    myVariables.ProcessText = ""
                                }
                            }catch {
                                // Handle error here
                            }
                            if Double((myVariables.ProcessText as NSString).intValue) == (myVariables.ProcessText as NSString).doubleValue{
                                myVariables.ProcessText = String(myVariables.ProcessText.dropLast(2))
                                myVariables.DecimalActive = false
                            }else{
                                myVariables.DecimalActive = true
                            }
                            myVariables.DisplayText = myVariables.ProcessText
                            myVariables.DisplayHistory = myVariables.ProcessText
                            myVariables.myHistory += [myVariables.CurrentProcess+"="+myVariables.DisplayText]
                            myVariables.CurrentProcess = myVariables.ProcessText
                        }else{
                            myVariables.ErrorDetected = true
                        }
                    }label:{
                        Image(systemName: "equal")
                    }
                }.buttonStyle(OperationButton(myVariables: myVariables))
            }
                .buttonStyle(NumpadButton(myVariables: myVariables))
                .frame(width: 470, alignment: .center)
        }.frame(width: 320)
    }
}

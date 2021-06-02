//
//  AddTaskComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

enum StateTask {
    case PLACEHOLDER
    case ADD_TASK
}

func stateComponent(_ keyboardResponder: KeyboardResponder) -> StateTask{
    if keyboardResponder.currentHeight != 0.0 {
        return StateTask.ADD_TASK
    }
    
    return StateTask.PLACEHOLDER
    //    return StateTask.ADD_TASK
}

func textFieldBackground(_ kr: KeyboardResponder) -> Color{
    return stateComponent(kr) == StateTask.PLACEHOLDER  ?
        Color.white : 
        Color(CGColor(red: 202/255, green: 206/255, blue: 212/255, alpha: 1.0))
}

struct AddTaskComponent: View {
    @State var text: String = ""
    @State var deadline:Date = Date()
    @State var sheet = false
    @ObservedObject var kr = KeyboardResponder()
    
    func didDismiss(){}
    
    var body: some View {
        ZStack{
            if stateComponent(kr) == StateTask.ADD_TASK {
                Rectangle()
                    .frame(width: .infinity, height: .infinity, alignment: .center)
                    .foregroundColor(Color(CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)))
                    .ignoresSafeArea()
            }
            
            //if stateComponent(kr) == StateTask.ADD_TASK {
                //DeadLineChoose()
            //}
        
            
            VStack {
                Spacer()
                
                VStack {
                    HStack {
                        ZStack{
                            
                            if stateComponent(kr) == StateTask.PLACEHOLDER {
                                Rectangle()
                                    .fill(
                                        Color(CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8))
                                    )
                                    .cornerRadius(8)
                                    .frame(width: .infinity, height: 42, alignment: .center)
                                    .padding()
                            }
                            if stateComponent(kr) == StateTask.ADD_TASK {
                                Rectangle()
                                    .fill(
                                        Color(CGColor(red: 202/255, green: 206/255, blue: 212/255, alpha: 1.0))
                                    )
                                    .cornerRadius(12, corners: [.topLeft, .topRight])
                                    .frame(width: .infinity, height: 42, alignment: .center)
                                
                            }
                            
                            HStack{
                                
                                if stateComponent(kr) == StateTask.PLACEHOLDER {
                                    Spacer()
                                        .frame(width: 30, height: 0, alignment: .center)
                                    Text("+")
                                        .foregroundColor(Color.white)
                                }
                                if stateComponent(kr) == StateTask.ADD_TASK {
                                    Spacer()
                                        .frame(width: 16, height: 0, alignment: .center)
                                    Text("☑️")
                                        .foregroundColor(Color.white)
                                    Spacer()
                                        .frame(width: 16, height: 0, alignment: .center)
                                }
                                
                                ZStack(alignment: .leading) {
                                    if text == "" {
                                        Text("Add Task")
                                            .font(.system(size: 16))
                                            .foregroundColor(
                                                stateComponent(kr) == StateTask.PLACEHOLDER ?
                                                    Color(CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)) :
                                                    Color(CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7))
                                            )
                                    }
                                    TextField("", text: $text)
                                        .font(.system(size: 16))
                                        .foregroundColor(
                                            stateComponent(kr) == StateTask.PLACEHOLDER ?
                                                .white : .black
                                        )
                                        .frame(width: .infinity, height: 42, alignment: .center)
                                }
                                Spacer()
                                    .frame(width: 16, height: 0, alignment: .center)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                .sheet(isPresented: $sheet,
                               onDismiss: didDismiss) {
                            VStack {
                                Text("License Agreement")
                                    .font(.title)
                                    .padding(50)
                                Text("""
                                        Terms and conditions go here.
                                    """)
                                    .padding(50)
                                Button("Dismiss",
                                       action: { sheet.toggle() })
                            }
                    
                            .preferredColorScheme(.light)
                }.preferredColorScheme(.light)
                
                
                if stateComponent(kr) == StateTask.ADD_TASK {
                    Spacer().frame(width: 0, height: 0, alignment: .center)
                    HStack{
                        Spacer()
                        
                        Button(action: {
                            print("Button was tapped")
                            sheet = true
                        }) {
                            Image("deadline")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(CGColor(
                                    red:68/255, green: 68/255, blue: 68/255, alpha: 1
                                )))
                                .scaledToFill()
                                .frame(width: 17, height: 19, alignment: .center)
                            
                        }
                        Spacer()
                        Button(action: {
                            print("Button was tapped")
                        }) {
                            Image("days")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(CGColor(
                                    red:68/255, green: 68/255, blue: 68/255, alpha: 1
                                )))
                                .scaledToFill()
                                .frame(width: 24, height: 24, alignment: .center)
                        }
                        Spacer()
                        Button(action: {
                            print("Button was tapped")
                        }) {
                            Image("notification")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(CGColor(
                                    red:68/255, green: 68/255, blue: 68/255, alpha: 1
                                )))
                                .scaledToFill()
                                .frame(width: 18, height: 22, alignment: .center)
                        }
                        Spacer()
                        Button(action: {
                            print("Button was tapped")
                        }) {
                            Image("repeat")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color(CGColor(
                                    red:68/255, green: 68/255, blue: 68/255, alpha: 1
                                )))
                                .scaledToFill()
                                .frame(width: 24, height: 21, alignment: .center)
                        }
                        Spacer()
                        
                    }
                    .frame(width: .infinity, height: 42, alignment: .center)
                    .background(
                        Color(CGColor(red: 202/255, green: 206/255, blue: 212/255, alpha: 1.0))
                    )
                }
                
                
            }
        }
    }
}

struct AddTaskComponent_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskComponent()
            .preferredColorScheme(.light)
        
    }
}

//
//  DeadLineChoose.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.05.2021.
//

import SwiftUI

struct DeadLineChoose: View {
    @State var deadline: Date = Date()
    
    var body: some View {
        ZStack{
            Rectangle()
                .frame(width: .infinity, height: .infinity, alignment: .center)
                .foregroundColor(Color(CGColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)))
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                    .frame(width: .infinity, height: .infinity, alignment: .center)
                ZStack{
                    
                    Rectangle()
                        .cornerRadius(8.0)
                        .foregroundColor(.white)
                    
                    VStack {
                        HStack{
                            Image("deadline")
                                .foregroundColor(Color(CGColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)))
                                .frame(width: 15, height: 17, alignment: .center)
                            Spacer().frame(width: 12, height: 1, alignment: .center)
                            Text("Deadline")
                                .font(.system(size: 24))
                                .foregroundColor(Color(CGColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)))
                            Spacer().frame(width: .infinity, height: .infinity, alignment: .center)
                            Button("X") {
                                
                            }
                            Image("ic_close").frame(width: 24, height: 24, alignment: .center)
                            
                        }
                        DatePicker(
                            "Deadline",
                            selection: $deadline,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        HStack {
                            
                            Button("Clear") {
                                
                            }
                            Button("Submit") {
                                
                            }
                        }
                    }.padding()
                    
                }.padding()
                Spacer()
                    .frame(width: .infinity, height: .infinity, alignment: .center)
            }.frame(width: .infinity, height: .infinity, alignment: .center)
            
        }
    }
}

struct DeadLineChoose_Previews: PreviewProvider {
    static var previews: some View {
        DeadLineChoose()
    }
}

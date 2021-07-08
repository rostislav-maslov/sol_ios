//
//  PlaceholderTaskComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 03.06.2021.
//

import SwiftUI

struct PlaceholderTaskComponent: View {
    @Binding var text: String
    var didTouch: () -> Void
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(SolColor.colors().addTask.placeholderBackground)
                .cornerRadius(8)
                .frame(width: .infinity, height: 42, alignment: .center)
                .padding()
            
            
            HStack{
                Spacer()
                    .frame(width: 30, height: 0, alignment: .center)
                Text("+").foregroundColor(Color.white)
                
                
                Text(text == "" ? "Add Task": text)
                    .font(SolFonts.font(size: 16, weight: Font.Weight.medium, color:
                                            text == "" ? SolColor.colors().addTask.placeholderTextDefault : SolColor.colors().addTask.placeholderTextFill
                    ))
                    .foregroundColor(
                        text == "" ? SolColor.colors().addTask.placeholderTextDefault : SolColor.colors().addTask.placeholderTextFill
                    )
                
                
                Spacer()
            }
            
            Button(action: self.didTouch, label: {
                Rectangle()
            })
            .foregroundColor(.clear)
            .frame(width: .infinity, height: 42, alignment: .center)
        }
    }
    
}

struct PlaceholderTaskComponent_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderTaskComponent(text: Binding<String>(get: {
            return "asdfsf"
        }, set: {(rr:String) in
            
        }), didTouch: {
            
        })
    }
}

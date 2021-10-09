//
//  DoneKeyboardButtonView.swift
//  SOL
//
//  Created by Rostislav Maslov on 07.08.2021.
//

import SwiftUI

struct DoneKeyboardButtonView: View {
    var action: (() -> Void)
    
    var body: some View {
            VStack{
                Spacer()
                HStack{
                    Button(action: self.action, label: {
                        ZStack{
                            Rectangle()
                                .fill(SolColor.colors().button.background)
                                .cornerRadius(12, corners: [.topLeft, .topRight])
                                .frame(height: 44, alignment: .center)
                            Text("Submit")
                                .foregroundColor(SolColor.colors().button.font)
                                .font(SolFonts.font(size: 18, weight: Font.Weight.medium, color: SolColor.colors().button.font))
                        }.frame(height: 44, alignment: .center)
                    })
                }
            }
        
    }
}

struct DoneKeyboardButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DoneKeyboardButtonView(action: {})
    }
}

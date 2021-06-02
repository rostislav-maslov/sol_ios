//
//  TaskTitleComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.05.2021.
//

import SwiftUI

struct TaskTitleComponent: View {
    var icon: String
    var title: String
    var showAddButton: Bool
    var addButtonDidTouch: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .center){
            Spacer().frame(width: 16, height: 0, alignment: .center)
            IconComponent(size: 28, icon: icon)
            Spacer().frame(width: 8, height: 0, alignment: .center)
            Text(title)
                .font(SolFonts.font(size: 32, weight: Font.Weight.bold, color: SolColor.colors().fontColors.normal))
            Spacer()
            if showAddButton == true {
                VStack{
                    Spacer().frame(width: 1, height: 12, alignment: .center)
                    Button(action: {
                        self.addButtonDidTouch?()
                    }, label: {
                        Image("ic_add_icon").frame(width: 24, height: 24, alignment: .center)
                    })
                }
            }
            Spacer().frame(width: 16, height: 0, alignment: .center)            
        }
        .preferredColorScheme(.light)
    }
}

struct TaskTitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        TaskTitleComponent(icon: "🥳", title: "Spaces", showAddButton: true, addButtonDidTouch: {
            
        })
        
    }
}

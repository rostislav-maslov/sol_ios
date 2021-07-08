//
//  TaskLineComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 21.05.2021.
//

import SwiftUI

struct TaskLineComponent: View {
    var showChild: Bool
    
    var body: some View {
        HStack{
            Spacer().frame(width: 8, height: 0, alignment: .center)
            VStack{
                TLItemComponent(level: 1, showChild: showChild)
                    .cornerRadius(8.0)
                    .shadow(
                        color: showChild == true ? TaskLineColors.colors().shadow : Color.clear,
                        radius: showChild == true ? 2 : 0,
                        x: 0,
                        y: showChild == true ? 1 : 0)
            }
            Spacer().frame(width: 8, height: 0, alignment: .center)
        }
        
    }
}

struct TaskLineComponent_Previews: PreviewProvider {
    static var previews: some View {
        TaskLineComponent(showChild: false)
    }
}

//
//  TLItemComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 22.05.2021.
//

import SwiftUI

struct TLItemComponent: View {
    var level:Int
    var showChild: Bool
    
    var body: some View {
        VStack{
            if level == 1 {
                Spacer().frame(width: 0, height: 16, alignment: .center)
            }else {
                Spacer().frame(width: 0, height: 8, alignment: .center)
            }
            
            HStack(alignment: .top, spacing: nil, content: {
                
                Spacer().frame(width: 21, height: 1, alignment: .center)
                TLCheckBoxComponent()
                Spacer().frame(width: 11, height: 1, alignment: .center)
                HStack(alignment: .top, spacing: nil, content: {
                    TLIconComponent()
                    VStack(alignment: .leading, spacing: nil, content: {
                        TLTitleComponent()
                        
                        HStack(alignment: .top, spacing: nil, content: {
                            TLSpaceComponent()
                            TLDeadlineComponent()
                        }).frame(width: .infinity, height: 12, alignment: .leading)
                        
                    })
                    
                    Spacer().frame(width: .infinity, height: 1, alignment: .center)
                })
                
            })
            
            if showChild == true{
                if level < 4 {
                    Spacer().frame(width: 0, height: 8, alignment: .center)
                    TLItemComponent(level: level + 1, showChild: true)
                    TLItemComponent(level: level + 1, showChild: false)
                    TLItemComponent(level: level + 1, showChild: false)
                    TLItemComponent(level: level + 1, showChild: false)
                }
            }
            Spacer().frame(width: 0, height: 8, alignment: .center)
            
        }
//        .background(
//            (showChild == true || level == 1) ?
//               // TaskLineColors.colors().background(level: level) : Color.clear
//        )
        
        
        
        
    }
}

struct TLItemComponent_Previews: PreviewProvider {
    static var previews: some View {
        TLItemComponent(level: 1, showChild: false)
    }
}

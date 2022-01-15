//
//  StoryConfigButtonComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 15.01.2022.
//

import Foundation




import SwiftUI

struct StoryConfigButtonComponent: View {
        
    var size = 48.0
    var countSize = 22.0
    var iconSize = 24.0
    var hasNew = AngularGradient(gradient: Gradient(colors: [
        Color(red: 0.27, green:  0.27, blue: 0.27),
        Color(red: 0.27, green: 0.27, blue: 0.27),
        Color(red: 0.27, green: 0.27, blue: 0.27)])
                    , center: .center)
    
    
    
    init() {
        
    }
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(SolColor.colors().stories.background)
                    .frame(width: self.size, height: self.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .position(x: 24.0, y: 24.0)
                
                Circle()
                    .strokeBorder(hasNew,lineWidth: 2)
                    .frame(width: self.size, height: self.size, alignment: .center)
                    .position(x: 24.0, y: 24.0)
                
                Image("ic_story_config")
                    .frame(width: 24, height: 23, alignment: Alignment.center)
            }.frame(width: self.size, height: self.size, alignment: Alignment.center)
            Spacer().frame(width: 1, height: 2, alignment: Alignment.center)
            Text("Config")
                .font(SolFonts.font(size: 12, weight: Font.Weight.medium, color: SolColor.colors().fontColors.normal))
                .foregroundColor(SolColor.colors().fontColors.normal)
        }
    }
}


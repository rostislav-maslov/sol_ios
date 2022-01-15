//
//  StoriesComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.05.2021.
//

import SwiftUI

struct StoryComponent: View {    
    
    @EnvironmentObject var viewStore: ViewUserStore
    var viewUserId: String
    var size = 48.0
    var countSize = 22.0
    var iconSize = 24.0
    var hasNew = AngularGradient(gradient: Gradient(colors: [
        Color(red: 0.27, green:  0.27, blue: 0.27),
        Color(red: 0.27, green: 0.27, blue: 0.27),
        Color(red: 0.27, green: 0.27, blue: 0.27)])
                    , center: .center)
    var noNew = AngularGradient(gradient: Gradient(colors: [
        Color(red: 0.78, green: 0.78, blue: 0.78),
        Color(red: 0.78, green: 0.78, blue: 0.78),
        Color(red: 0.78, green: 0.78, blue: 0.78)])
                    , center: .center)
    
    
    init(_ viewUserId: String) {
        self.viewUserId = viewUserId
    }
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(SolColor.colors().stories.background)
                    .frame(width: self.size, height: self.size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .position(x: 24.0, y: 24.0)
                
                Circle()
                    .strokeBorder(
                        (viewStore.all[viewUserId]!.hasTaskAdded == true || viewStore.all[viewUserId]!.hasNewTaskToAdd == true) ?
                            hasNew : noNew,
                        lineWidth: 2)
                    .frame(width: self.size, height: self.size, alignment: .center)
                    .position(x: 24.0, y: 24.0)
                
                IconComponent(size: self.iconSize, icon: viewStore.all[viewUserId]!.view!.icon!.data!) 
                    .position(x: 24.0, y: 24.0)
                
                if viewStore.all[viewUserId]!.count != nil && viewStore.all[viewUserId]!.count! > 0 {
                    self.count.position(x: 41.0, y: 12.0)
                }
                
            }.frame(width: self.size + 4, height: self.size, alignment: Alignment.center)
            Spacer().frame(width: 1, height: 2, alignment: Alignment.center)
            Text(viewStore.all[viewUserId]!.view!.title!)
                .font(SolFonts.font(size: 12, weight: Font.Weight.medium, color: SolColor.colors().fontColors.normal))
                .foregroundColor(SolColor.colors().fontColors.normal)
                
        }
    }
}

extension StoryComponent{
    var count: some View {
            ZStack{
                Circle()
                    .fill(
                        (viewStore.all[viewUserId]!.hasTaskAdded == true || viewStore.all[viewUserId]!.hasNewTaskToAdd == true) ?
                            hasNew : noNew)
                    .frame(width: self.countSize, height: self.countSize, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text((viewStore.all[viewUserId]!.count != nil) ? "\(viewStore.all[viewUserId]!.count!)" : "")
                    .font(SolFonts.font(size: 12, weight: Font.Weight.medium, color: Color.white))
                    .foregroundColor(
                        (viewStore.all[viewUserId]!.hasTaskAdded == true || viewStore.all[viewUserId]!.hasNewTaskToAdd == true) ?
                        SolColor.colors().stories.countFontHasNew : SolColor.colors().stories.countFontNoNew
                    )
            }.frame(width: self.countSize, height: self.countSize, alignment: Alignment.center)
    }
}



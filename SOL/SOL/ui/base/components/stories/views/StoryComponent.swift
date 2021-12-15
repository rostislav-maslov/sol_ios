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
    
    init(_ viewUserId: String) {
        self.viewUserId = viewUserId
    }
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(Color(CGColor(
                                    red: 243/255, green: 243/255, blue: 243/255, alpha: 1)

                    ))
                    .frame(width: 64, height: 64, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Circle()
                    .strokeBorder(
                        (viewStore.all[viewUserId]!.hasTaskAdded == true || viewStore.all[viewUserId]!.hasNewTaskToAdd == true) ?
                       
                            AngularGradient(gradient: Gradient(colors: [
                                Color(red:100/255, green:100/255, blue:100/255),
                                Color(red:100/255, green:100/255, blue:100/255),
                                Color(red:100/255, green:100/255, blue:100/255)])
                                            , center: .center):
                            AngularGradient(gradient: Gradient(colors: [
                                Color(red:18/255, green:91/255, blue:233/255),
                                Color(red:249/255, green:241/255, blue:30/255),
                                Color(red:227/255, green:50/255, blue:93/255)])
                                            , center: .center) 
                        ,lineWidth: 2)
                    .frame(width: 64, height: 64, alignment: .center)
    
                IconComponent(size: 24, icon: viewStore.all[viewUserId]!.view!.icon!.data!) 
            }
            Text("#" + viewStore.all[viewUserId]!.view!.title!)
                .font(.system(size: 11))
        }
    }
}



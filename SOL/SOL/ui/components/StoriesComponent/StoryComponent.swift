//
//  StoriesComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 09.05.2021.
//

import SwiftUI

struct StoryComponent: View {    
    
    init() {
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
                        AngularGradient(gradient: Gradient(colors: [
                                                                                                    Color(red:18/255, green:91/255, blue:233/255),
                                                                                                    Color(red:249/255, green:241/255, blue:30/255),
                                                                                                    Color(red:227/255, green:50/255, blue:93/255)])
                            , center: .center)
                        ,lineWidth: 2)
                    .frame(width: 64, height: 64, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    
                IconComponent(size: 24, icon: "🥳") 
            }
            Text("#today")
                .font(.system(size: 11))
        }
    }
}

struct StoryComponent_Previews: PreviewProvider {
    static var previews: some View {
        StoryComponent()
            .preferredColorScheme(.light)
    }
}

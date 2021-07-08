//
//  StoriesComponent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

struct StoriesComponent: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                Spacer().frame(width: 10, height: 10, alignment: .center)
                StoryComponent()
                StoryComponent()
                StoryComponent()
                StoryComponent()
                StoryComponent()
                StoryComponent()
                StoryComponent()
                Spacer()
            }
        }
        .frame(height: 90)
    }
}

struct StoriesComponent_Previews: PreviewProvider {
    static var previews: some View {
        StoriesComponent()
            .preferredColorScheme(.light)
    }
}

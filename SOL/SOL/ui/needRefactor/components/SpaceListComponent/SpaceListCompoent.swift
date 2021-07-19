//
//  SpaceListCompoent.swift
//  SOL
//
//  Created by Rostislav Maslov on 10.05.2021.
//

import SwiftUI

struct SpaceListCompoent: View {
    init() {
        
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer()
                .frame(width: 1, height: 41+16, alignment: .center)
            StoriesComponent()
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            TaskTitleComponent(icon: "", title: "dd", showAddButton: false)
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            //CommandMenuComponent()
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            TaskTitleComponent(icon: "", title: "df", showAddButton: false)
            Spacer()
                .frame(width: 1, height: 16, alignment: .center)
            
            
            VStack{
                Spacer().frame(width: 1, height: 12, alignment: .center)
              //  SpaceItemComponent()
                VStack {
                TaskLineComponent(showChild: true)
                Spacer().frame(width: 1, height: 8, alignment: .center)
                TaskLineComponent(showChild: false)
                Spacer().frame(width: 1, height: 8, alignment: .center)
                TaskLineComponent(showChild: false)
                Spacer().frame(width: 1, height: 8, alignment: .center)
                TaskLineComponent(showChild: false)
            }
                Spacer().frame(width: 1, height: 8, alignment: .center)
                TaskLineComponent(showChild: true)
              //  SpaceItemComponent()
                
                
                Spacer()
                    .frame(width: 1, height: 142, alignment: .center)
            }
            
            
        }
        .background(Color(CGColor(
            red:239/255, green:239/255, blue: 239/255, alpha:1

        )))
        .ignoresSafeArea(.all)
    }
}

struct SpaceListCompoent_Previews: PreviewProvider {
    static var previews: some View {
        SpaceListCompoent()
            .preferredColorScheme(.light)
    }
}
